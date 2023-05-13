import 'dart:math';
import 'dart:io';
import 'dart:convert';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nakama/nakama.dart';
import 'package:nouns_flutter/controllers/animations_controller.dart';
import 'package:nouns_flutter/controllers/game_controller.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/controllers/leaderboards_controller.dart';
import 'package:nouns_flutter/models/player_round_ranking.dart';
import 'package:nouns_flutter/models/presence_summary.dart';
import 'dart:async';
import 'package:nouns_flutter/utils/op_codes.dart' as op_codes;
import 'package:nouns_flutter/utils/nakama_helpers.dart' as nakama_helpers;

class MpController extends GetxController {
  Timer? alphabetRandomizationTimer;
  final Logger _logger = Get.find();
  void Function()? onRoundEnd;
  final _autofillsRemaining = 0.obs;
  final _userSelectingAlphabet = "Stan_Lee".obs;
  final _selectedAlphabet = "A".obs;
  final _currentRound = 1.obs;
  final _totalRounds = 8.obs;
  final _selectedAlphabets = <Rx<String>>[].obs;
  final _tappedAlphabet = "".obs;
  final _answers = Map<Rx<String>, Rx<String>>.of({}).obs;
  final usedWords = <String>[];
  final StreamController<CategoryResult> resultsStreamController =
      StreamController<CategoryResult>.broadcast();
  final _midwayPassed = false.obs;
  final _roundResults = Map<Rx<String>, Rx<int>>.of({
    // "musical_instruments".obs: 0.obs,
    // "chemical_elements".obs: 0.obs,
    // "countries_and_capitals".obs: 0.obs,
    // "sports".obs: 0.obs,
    "round_score".obs: 0.obs,
    "total_score".obs: 0.obs,
  }).obs;
  final _roundRanking = <Rx<PlayerRoundRanking>>[].obs;

  final _finalRanking = <Rx<PlayerRoundRanking>>[].obs;
  int receivedResultsForRound = 0;

  void sendAnswers() {
    var matchId = Get.find<MpSetupController>().matchId;
    usedWords.addAll(answers.values);
    _logger.i("answers", answers);
    nakama_helpers.sendData(
        matchId: matchId,
        opCode: op_codes.submitAnswers,
        data: jsonEncode(answers));
  }

  void sendResultsAcknowledgement() {
    _logger.i("sending acknowledgeemnt");
    var matchId = Get.find<MpSetupController>().matchId;
    var userId = Get.find<UserController>().id;
    nakama_helpers.sendData(
        matchId: matchId,
        opCode: op_codes.acknowledgeResults,
        data: jsonEncode({"userId": userId}));
  }

  void selectRandomAlphabet() {
    print("random letter");
    var time = 0; //milliseconds
    var alphabet = "";
    int interval = 100;

    //keep repeating until time > x and alphabet not in list
    alphabetRandomizationTimer =
        Timer.periodic(Duration(milliseconds: interval), (timer) {
      if (time >= 1500 && !_selectedAlphabets.contains(alphabet)) {
        // _selectedAlphabets.add(alphabet.obs);
        selectedAlphabet = alphabet;
        timer.cancel();
        return;
      }

      var randomSeed = DateTime.now().millisecondsSinceEpoch;
      var charCode = Random(randomSeed).nextInt(26) +
          65; //random 65 -90 (character codes for A - Z)
      alphabet = String.fromCharCode(charCode);
      tappedAlphabet = alphabet; //random
      time += interval;
      print("random letter $alphabet");
    });
  }

  void sendStopSignal() {
    var matchId = Get.find<MpSetupController>().matchId;
    nakama_helpers.sendData(
        matchId: matchId, opCode: op_codes.stop, data: jsonEncode({}));
  }

  Map<String, String> get answers =>
      _answers.map((k, v) => MapEntry(k.value, v.value));
  void updateAnswer({required String category, required String answer}) {
    _answers[category.obs] = answer.obs;
  }

  void initializeAnswers() {
    _answers.forEach((k, v) {
      _answers[k] = "".obs;
    });
  }

  void clearRoundResults() {
    for (var _category in _roundResults.keys) {
      if (_category.value != "total_score") {
        _roundResults[_category] = 0.obs;
      }
    }
  }

  Future<void> updateRoundResults(Map<String, int> results) async {
    _logger.i("updating round results", results);
    var keys = results.keys;
    var sortedKeys = keys
        .where(
            (element) => element != "total_score" && element != "round_score")
        .toList()
      ..sort()
      ..addAll(['round_score', 'total_score']);

    _logger.i("sorted keys", sortedKeys);

    for (var _category in sortedKeys) {
      _logger.i("setting results for $_category ${results[_category]}");
      _roundResults.addAll(Map.of({_category.obs: results[_category]!.obs}));
      resultsStreamController
          .add(CategoryResult(category: _category, score: results[_category]!));
      _logger.i(" after setting results for $_category ${results[_category]!}",
          _roundResults);

      _logger.i("time before sleep seconds ${DateTime.now().second}}");
      await Future.delayed(const Duration(milliseconds: 700), () {});
      _logger.i("time after sleep seconds ${DateTime.now().second}}");
    }

    if (receivedResultsForRound > 0 &&
        receivedResultsForRound == currentRound) {
      _logger.i("time before sleep seconds ${DateTime.now().second}}");
      await Future.delayed(const Duration(seconds: 2), () {});
      _logger.i("time after sleep seconds ${DateTime.now().second}}");
    }

    if (receivedResultsForRound > 0 &&
        receivedResultsForRound == currentRound) {
      //acknowledge results
      _logger.i("acknowledging results 2 seconds after last value update");
      Future.delayed(const Duration(seconds: 2), () {
        sendResultsAcknowledgement();
      });
    }
  }

  Map<String, int> get roundResults =>
      _roundResults.map((k, v) => MapEntry(k.value, v.value));
  RxMap<Rx<String>, Rx<int>> get roundResultsListenable => _roundResults;
  set roundResults(Map<String, int> results) {
    updateRoundResults(results);

    //results.forEach((key, value) {});
  }

  List<PlayerRoundRanking> get roundRanking =>
      _roundRanking.map((rxPlayerRanking) => rxPlayerRanking.value).toList();

  set roundRanking(List<PlayerRoundRanking> ranking) {
    _roundRanking.clear();
    _roundRanking.addAll(ranking.map((rankingEntry) => rankingEntry.obs));
    _roundRanking.sort((a, b) => a.value.ranking.compareTo(b.value.ranking));
  }

  List<PlayerRoundRanking> get finalRanking =>
      _finalRanking.map((rxPlayerRanking) => rxPlayerRanking.value).toList();

  set finalRanking(List<PlayerRoundRanking> ranking) {
    _finalRanking.clear();
    _finalRanking.addAll(ranking.map((rankingEntry) => rankingEntry.obs));
  }

  String get userSelectingAlphabet => _userSelectingAlphabet.value;
  set userSelectingAlphabet(String value) =>
      _userSelectingAlphabet.value = value;

  String get selectedAlphabet => _selectedAlphabet.value;
  set selectedAlphabet(String value) {
    print(
        "selectedAlphabets length   ${selectedAlphabets.length} currentRound ${currentRound}");
    if (_selectedAlphabets.length == currentRound) {
      //this means alphabet for this round already selected
      print("alphabet for this round already selected");
      return;
    }

    HapticFeedback.mediumImpact();
    if (Get.find<UserController>().username == userSelectingAlphabet &&
        value != selectedAlphabet) {
      var matchId = Get.find<MpSetupController>().matchId;
      nakama_helpers.sendData(
          matchId: matchId,
          opCode: op_codes.alphabetSelected,
          data: jsonEncode({"alphabet": value}));
    }

    _logger.i("selecteing alphabet", value);
    _selectedAlphabet.value = value;
    _selectedAlphabets.add(value.obs);
  }

  void clearSelectedAlphabet() {
    _selectedAlphabet.value = "-";
    _tappedAlphabet.value = "-";
  }

  void clearPreviousGame() {
    clearRoundResults();
    clearSelectedAlphabet();
    _selectedAlphabets.clear();
    currentRound = 0;
  }

  List<String> get selectedAlphabets =>
      _selectedAlphabets.map((rxAlphabet) => rxAlphabet.value).toList();

  String get tappedAlphabet => _tappedAlphabet.value;
  set tappedAlphabet(String value) => _tappedAlphabet.value = value;

  bool get isSelectingAlphabet =>
      Get.find<UserController>().username == userSelectingAlphabet;

  int get currentRound => _currentRound.value;
  set currentRound(int value) => _currentRound.value = value;

  bool get isTopPlayer {
    if (_finalRanking.isEmpty) return false;
    if (_finalRanking.length == 1) return true;

    var _userId = Get.find<UserController>().id;
    _roundRanking.sort((a, b) => a.value.ranking - b.value.ranking);
    var topPlayer = _roundRanking.first();
    return topPlayer.user.userId == _userId;
  }

  int get score {
    return roundResults["total_score"] ?? 0;
  }

  int get totalRounds => _totalRounds.value;
  set totalRounds(int value) {
    _totalRounds.value = value;

    _autofillsRemaining.value = (totalRounds * 10 / 26).ceil();
    _logger.i("rounds $totalRounds autofills $autofillsRemaining");
  }

  int get autofillsRemaining => _autofillsRemaining.value;
  set autofillsRemaining(int value) => _autofillsRemaining.value = value;

  int get currentPosition {
    if (roundRanking.isEmpty) return 0;

    var _userId = Get.find<UserController>().id;
    var playerRanking = _roundRanking
        .firstWhere((rxRanking) => rxRanking.value.user.userId == _userId);
    return playerRanking.value.ranking;
  }

  bool get canStopRoundNow {
    return _midwayPassed.value;
  }

  set canStopRoundNow(bool value) => _midwayPassed.value = value;
}

class CategoryResult {
  final String category;
  final int score;

  CategoryResult({required this.category, required this.score});
}

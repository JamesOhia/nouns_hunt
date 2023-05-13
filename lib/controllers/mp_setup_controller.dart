import 'dart:convert';
import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nakama/nakama.dart';
import 'package:nouns_flutter/controllers/game_controller.dart';
import 'package:nouns_flutter/controllers/mp_controller.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/controllers/leaderboards_controller.dart';
import 'package:nouns_flutter/data/categories.dart';
import 'package:nouns_flutter/nakama/rest_api.dart' as Api;
import 'package:nouns_flutter/models/presence_summary.dart';
import 'package:nouns_flutter/utils/op_codes.dart' as op_codes;
import 'package:nouns_flutter/utils/nakama_helpers.dart' as nakama_helpers;

enum MultiplayerMode { Private, Public }

class MpSetupController extends GetxController {
  Logger logger = Get.find();
  final _gameMode = (MultiplayerMode.Private).obs;
  final _selectedCategories = <Rx<String>>[
    // "musical_instruments".obs,
    // "chemical_elements".obs,
    // "countries_and_capitals".obs,
    // "sports".obs
  ].obs;
  final RxList<Rx<PresenceSummary>> _playersInWaitingRoom =
      <Rx<PresenceSummary>>[].obs;
  final int maxCategories = 4;
  final _rounds = 5.obs;
  final _difficulty = 0.obs;
  final _waitingRoomActive = false.obs;
  final _readyToStart = false.obs;
  final _matchIdAlias = "".obs;
  final _matchId = "".obs;
  final _host = "".obs;
  final _isHost = true.obs;
  final _startGameLoading = false.obs;
  final _allowGameStart = false.obs;

  void roundsPlus() {
    rounds++;
  }

  void roundsMinus() {
    if (rounds > 5) {
      rounds--;
    }
  }

  void randomize() {
    rounds = Random().nextInt(21) + 5; //always will be 5-26
    // difficulty = Random().nextInt(5) + 1; //always will be 1-5

    //clear the list and  add 4 randomly selcted categories
    _selectedCategories.clear();
    (Categories.mpCategories.keys.toList()..shuffle())
        .getRange(0, 4)
        .forEach((category) {
      addCategory(category);
    });
  }

  Future<void> createGame() async {
    try {
      waitingRoomActive = true;
      var client = NakamaWebsocketClient.instance;

      var response = await Api.callRpc(
          id: "create_match",
          body: Map<String, dynamic>.of({
            "categories": selectedCategories,
            "rounds": rounds,
            "difficulty": difficulty,
            "host": Get.find<UserController>().id
          }));
      matchIdAlias = response!['alias']!;
      matchId = response['matchId']!;
      client.joinMatch(response['matchId']!);
    } catch (e) {
      logger.e("Error creating game", e);
    }
  }

  Future<void> joinGame(String alias) async {
    try {
      var client = NakamaWebsocketClient.instance;
      var response = await Api.callRpc(
          id: "matchid_from_alias",
          body: Map<String, dynamic>.of({"alias": alias}));

      if (response != null && response.isNotEmpty) {
        matchId = response['matchId']!;
        client.joinMatch(response['matchId']!);
      } else {
        Get.snackbar("Not found",
            "No match with given Id found"); //todo make this betetr ux
      }
    } catch (e) {
      logger.e("Error joining game", e);
      Get.snackbar("Couldn't join match", "Couldn't join match with given id");
    }
  }

  void startGame() {
    startGameLoading = true;
    Get.find<MpController>().roundRanking.clear();
    nakama_helpers.sendData(
        matchId: matchId, opCode: op_codes.startGame, data: jsonEncode({}));

    print('start game');
  }

  void reset() {
    _selectedCategories.clear();
    difficulty = 0;
    rounds = 5;
    isHost = true;
    waitingRoomActive = false;
    _playersInWaitingRoom.clear();
  }

  void quit() {
    nakama_helpers.sendData(
        matchId: matchId, opCode: op_codes.quitRequest, data: jsonEncode({}));
    reset();
  }

  MultiplayerMode get gameMode => _gameMode.value;
  set gameMode(MultiplayerMode value) => _gameMode.value = value;

  List<String> get selectedCategories =>
      _selectedCategories.value.map((rxCategory) => rxCategory.value).toList();
  void addCategory(String category) {
    if (selectedCategories.length < 4) {
      _selectedCategories.add(category.obs);
      _selectedCategories.sort((a, b) => a.value.compareTo(b.value));
      calculateDifficulty();
    }
  }

  void calculateDifficulty() {
    if (selectedCategories.isEmpty || selectedCategories.length < 4) {
      difficulty = 0;
      return;
    }
    ;

    var total = 0;
    selectedCategories.forEach((category) {
      total += Categories.mpCategories[category]!["difficulty"] as int;
    });
    difficulty = total ~/ selectedCategories.length;
  }

  List<Rx<PresenceSummary>> get playersInWaitingRoom => _playersInWaitingRoom;
  void addToWaitingRoom(PresenceSummary player) {
    if (_playersInWaitingRoom
        .any((element) => element.value.userId == player.userId)) {
      return;
    }

    if (player.userId == host) {
      _playersInWaitingRoom.insert(0, player.obs);
    } else {
      _playersInWaitingRoom.add(player.obs);
    }
  }

  void removeFromWaitingRoom(PresenceSummary player) {
    _playersInWaitingRoom
        .removeWhere((element) => element.value.userId == player.userId);
  }

  void removeCategory(String category) {
    _selectedCategories.removeWhere((element) => element.value == category);
    calculateDifficulty();
  }

  int get rounds => _rounds.value;
  set rounds(int value) => _rounds.value = value;

  String get host => _host.value;
  set host(String value) => _host.value = value;

  bool get isHost => _isHost.value;
  set isHost(bool value) => _isHost.value = value;

  bool get startGameLoading => _startGameLoading.value;
  set startGameLoading(bool value) => _startGameLoading.value = value;

  bool get allowGameStart => _allowGameStart.value;
  set allowGameStart(bool value) =>
      _allowGameStart.value = value && _playersInWaitingRoom.length > 1;

  bool get waitingRoomActive => _waitingRoomActive.value;
  set waitingRoomActive(bool value) => _waitingRoomActive.value = value;

  bool get readyToStart => _readyToStart.value;
  set readyToStart(bool value) => _readyToStart.value = value;

  int get difficulty => _difficulty.value;
  set difficulty(int value) => _difficulty.value = value;

  String get matchIdAlias => _matchIdAlias.value;
  set matchIdAlias(String value) => _matchIdAlias.value = value;

  String get matchId => _matchId.value;
  set matchId(String value) => _matchId.value = value;

  bool get createGameEnabled => selectedCategories.length == maxCategories;

  bool get startedGameEnabled => _playersInWaitingRoom.length >= 2;

  bool isCategorySelected(String category) =>
      selectedCategories.contains(category);

  bool get actionButtonEnabled =>
      (createGameEnabled && !waitingRoomActive) ||
      (readyToStart && waitingRoomActive);
}

// class Player {
//   final String userId;
//   final String country;
//   final String username;
//   final String avatar;
//   const Player();
// }

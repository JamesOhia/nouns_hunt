// ignore_for_file: avoid_print

import 'dart:math';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/controllers/leaderboards_controller.dart';
import 'package:nouns_flutter/data/categories.dart';
import 'package:nouns_flutter/utils/connection.dart';
import 'package:nouns_flutter/controllers/animations_controller.dart';
import 'package:nouns_flutter/controllers/timer.dart';

class SingleplayerController extends GetxController {
  final Logger _logger = Get.find();

  SingleplayerController() {
    reset();
  }

  final correctAnswerReward = 2;
  List<String> _usedWords = [];
  final _currentCategory = ''.obs;
  final _currentAlphabet = 'A'.obs;
  final _score = 0.obs;
  final _wordComboValue = 1.obs;
  var wordComboInterval = 4;
  List<DateTime> comboTimestamps = [];
  final _btnNextImage = "next".obs;
  final _repeatedAlphabetCategory = false.obs;
  final _isHighscore = false.obs;

  var _categoryRepeatedTimes = 0.obs;
  Map<String, int> _repeatedCategories = {};
  var _correctAnswerTimerReward = 3;
  final _timefreezeActive = false.obs;

  //filename in assets/images/SinglePlayer of respective image files
  final nextArrow = "next";
  final wrongIndicator = "wrong";
  final corrrectIndicator = "correct";

  void nextRound(String answer) async {
    print('Next Round');
    var result = await checkAnswer(answer);
    switch (result) {
      case CheckAnswerResult.correct:
        onCorrectAnser(answer);
        break;
      case CheckAnswerResult.repeated:
        onRepeatedAnswer();
        break;
      case CheckAnswerResult.wrong:
        onWrongAnswer();
        break;
      default:
        _logger.d('Undefined result');
    }

    pickNextCategory();
    pickNextAlphabet();
    checkReapeatedAlphabetCategory();
  }

  Future<CheckAnswerResult> checkAnswer(String answer) async {
    bool isCorrect = answer.toLowerCase().startsWith(currentAlphabet) &&
        await Categories.checkWordInCategory(
            word: answer, category: currentCategory);

    if (isCorrect && _usedWords.contains(answer)) {
      return CheckAnswerResult.repeated;
    } else if (isCorrect) {
      return CheckAnswerResult.correct;
    } else {
      return CheckAnswerResult.wrong;
    }
  }

  void onCorrectAnser(String answer) {
    flashBtnNextImage(corrrectIndicator);
    _usedWords.add(answer);
    checkWordCombo();

    score += correctAnswerReward * _wordComboValue.value;
    //timer+3seconds
    // Get.find<TimerController>().rewindTimer(_correctAnswerTimerReward);
    Get.find<AnimationsController>()
        .rewind90SecAnim(_correctAnswerTimerReward.toDouble());

    checkHighScore();
  }

  void onWrongAnswer() {
    flashBtnNextImage(wrongIndicator);
    _wordComboValue.value = 1;
  }

  void onRepeatedAnswer() {
    flashBtnNextImage(wrongIndicator);
    _wordComboValue.value = 1;
  }

  //todo: display dot for a reapted combo category
  void checkReapeatedAlphabetCategory() {
    var key = currentAlphabet + currentCategory;
    if (_repeatedCategories.containsKey(key)) {
      _repeatedCategories[key] = (_repeatedCategories[key]! + 1);
    } else {
      _repeatedCategories[key] = 1;
    }

    if (_repeatedCategories[key]! > 1) {
      repeatedAlphabetCategory = true;
      categoryRepeatedTimes = _repeatedCategories[key]!;
    } else {
      repeatedAlphabetCategory = false;
    }

    logger.i(
        "$currentCategory $currentAlphabet repeated : $categoryRepeatedTimes $repeatedAlphabetCategory ",
        _repeatedCategories);
  }

  void checkHighScore() {
    var currentHighScore =
        Get.find<LeaderboardsController>().currentUserRecord.score.toInt();

    _isHighscore.value = score > currentHighScore;
  }

  void checkWordCombo() {
    var currentTimeStamp = DateTime.now();
    comboTimestamps.add(currentTimeStamp);

    if (comboTimestamps.length > 1) {
      var lastTimestamp = comboTimestamps[comboTimestamps.length - 1];
      var previousTimestamp = comboTimestamps[comboTimestamps.length - 2];
      var difference = lastTimestamp.difference(previousTimestamp);

      if (timefreezeActive || difference.inSeconds < wordComboInterval) {
        _wordComboValue.value++;
        setWordComboTimeout(currentTimeStamp);
      } else {
        _wordComboValue.value = 1;
      }
    }
  }

  void setWordComboTimeout(DateTime timestamp) {
    Future.delayed(Duration(seconds: wordComboInterval), (() {
      if (comboTimestamps.isNotEmpty &&
          comboTimestamps[comboTimestamps.length - 1] == timestamp) {
        //check if the last timestamp is the same as the one passed in
        _wordComboValue.value = 1;
      }
    }));
  }

  void pickNextCategory() {
    var categoryNames = Categories.spCategories.keys.toList();

    if (categoryNames.isEmpty) {
      currentCategory = '';
    } else {
      int randNo = Random().nextInt(max(categoryNames.length, 1));
      var category = categoryNames[randNo];
      currentCategory = category;
    }
  }

  void pickNextAlphabet() {
    var letters = [
      'a',
      'b',
      'c',
      'd',
      'e',
      'f',
      'g',
      'h',
      'i',
      'j',
      'k',
      'l',
      'm',
      'n',
      'o',
      'p',
      'q',
      'r',
      's',
      't',
      'u',
      'v',
      'w',
      'x',
      'y',
      'z'
    ];

    var index = Random().nextInt(letters.length);
    currentAlphabet = letters[index];
  }

  void reset() {
    score = 0;
    _wordComboValue.value = 1;
    _usedWords = [];
    pickNextCategory();
    pickNextAlphabet();
  }

  //show this image for one second then return to the default one
  void flashBtnNextImage(String image) {
    btnNextImage = image;
    Future.delayed(
        const Duration(seconds: 1), (() => btnNextImage = nextArrow));
  }

  // Getters and Setters
  set currentCategory(String value) => _currentCategory.value = value;
  String get currentCategory => _currentCategory.value;

  set currentAlphabet(String value) => _currentAlphabet.value = value;
  String get currentAlphabet => _currentAlphabet.value;

  set score(int value) => _score.value = value;
  int get score => _score.value;

  set categoryRepeatedTimes(int value) => _categoryRepeatedTimes.value = value;
  int get categoryRepeatedTimes => _categoryRepeatedTimes.value;

  set btnNextImage(String value) => _btnNextImage.value = value;
  String get btnNextImage => _btnNextImage.value;

  set repeatedAlphabetCategory(bool value) =>
      _repeatedAlphabetCategory.value = value;
  bool get repeatedAlphabetCategory => _repeatedAlphabetCategory.value;

  set timefreezeActive(bool value) => _timefreezeActive.value = value;
  bool get timefreezeActive => _timefreezeActive.value;

  bool get isHighscore => _isHighscore.value;

  List<String> usedWords() => _usedWords;

  void setWordcomboListener(void Function(int) onUpdate) {
    _wordComboValue.listen(onUpdate);
  }
}

enum CheckAnswerResult {
  correct,
  repeated,
  wrong,
}

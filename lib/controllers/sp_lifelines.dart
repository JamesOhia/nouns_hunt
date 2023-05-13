import 'dart:math';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/controllers/sp_gameplay.dart';
import 'package:nouns_flutter/controllers/timer.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/data/categories.dart';
import 'package:nouns_flutter/controllers/animations_controller.dart';

SingleplayerController _spController = Get.find();
UserController _userController = Get.find();
//TimerController _timerController = Get.find();
AnimationsController _animationsController = Get.find();
Logger _logger = Get.find();

const autofillCost = 1;
const timeMachineCost = 50;
const timeFreezeCost = 90;

const outOfCoinsTitle = "Oops! Out of Coins!";
const outOfCoinsMessage =
    'Out of Coins! Come back tomorrow for some more in the daily reward';

const outOfPencilsTitle = "Awks! Out of Pencils!";
const outOfPencilsMessage =
    'Out of Pencils! Come back tomorrow for some more in the daily reward!';

const timeMachineDuration = 15;
const timeFreezeDuration = 10;

const autofillCoolDown = 5; //* (1 ~/ _animationsController.t90SecStepTime);
const timeFreezeCoolDown = 15;
// 15 * (1 ~/ _animationsController.t90SecStepTime); //to sync with timer

final _autofillDisabled = false.obs;
bool get autofillDisabled => _autofillDisabled.value;
set autofillDisabled(bool value) => _autofillDisabled.value = value;

final _timeFreezeDisabled = false.obs;
bool get timeFreezeDisabled => _timeFreezeDisabled.value;
set timeFreezeDisabled(bool value) => _timeFreezeDisabled.value = value;

//todo cooldown time
String Autofill({required String category, required String alphabet}) {
  if (autofillDisabled) {
    throw LifeineCooldownException("Waiting for autofill cooldown");
  } else {
    autofillDisabled = true;
    Future.delayed(
        Duration(seconds: autofillCoolDown), () => autofillDisabled = false);
  }

  if (_userController.pencils < autofillCost) {
    _logger.d("Not enough pencils to use autofill");
    throw OutOfPencilsException("Not enough pencils to use autofill");
  }

  _userController.pencils -= autofillCost;

  var usedWOrds = _spController.usedWords();

  var word = "";
  int tries = 0;
  int lengthOfDictionary = Categories.spCategories[category]!.length;

  while (true) {
    var randomIndex =
        Random().nextInt(lengthOfDictionary); //random index in given category

    word = Categories.spCategories[category]![randomIndex];

    if (word.startsWith(alphabet.toLowerCase()) && !usedWOrds.contains(word)) {
      break;
    } else {
      tries++;
    }

    if (tries >= lengthOfDictionary) {
      _logger.w(
          "No more words in category $category starting with $alphabet. Already tried $tries times");
      word = ""; //todo maybe add error notifier
      break;
    }
  }

  return word.toUpperCase();
}

void TimeFreeze() {
  if (timeFreezeDisabled) {
    throw LifeineCooldownException("Waiting for autofill cooldown");
  } else {
    timeFreezeDisabled = true;
    Future.delayed(Duration(seconds: timeFreezeCoolDown), () {
      timeFreezeDisabled = false;
    });
  }

  if (_userController.coins < timeFreezeCost) {
    _logger.d("Not enough coins to use time freeze");
    throw OutOfCoinsException(
        "Not enough coins to use time freeze"); //todo uncommen this
  }

  _userController.coins -= timeFreezeCost;

  //probably activate and deactivate animation here for timefreeze
  _logger.d("Time Freeze active");
  //_timerController.pauseTimer(timeFreezeDuration, onComplete: () {
  //   _logger.d("Time freeze expired");
  // }); //todo confirm time freeze duration
  Get.find<AnimationsController>().pause90SecondsAnimation(timeFreezeDuration);
}

void TimeMachine() {
  if (_userController.coins < timeMachineCost) {
    _logger.d("Not enough coins to use time machine");
    throw OutOfCoinsException("Not enough coins to use time machine");
  }

  _userController.coins -= timeMachineCost;
  // _timerController
  //     .rewindTimer(timeMachineDuration); //todo confirm time machine duration
  // if( _timerController
  //     .timeRemaining >= 75){
  //        Get.find<AnimationsController>().t90SecTimerAnimation!.currentIndex =0;
  //        return;
  //     }
  //find a way to determine current index
  var threshold = 75 / _animationsController.t90SecStepTime;
  if (_animationsController.t90SecTimerAnimation!.currentIndex <= threshold) {
    _animationsController.t90SecTimerAnimation!.currentIndex = 0;
    return;
  }
  _animationsController.rewind90SecAnim(timeMachineDuration.toDouble());
}

class OutOfCoinsException implements Exception {
  String cause;
  OutOfCoinsException(this.cause);
}

class OutOfPencilsException implements Exception {
  String cause;
  OutOfPencilsException(this.cause);
}

class LifeineCooldownException implements Exception {
  String cause;
  LifeineCooldownException(this.cause);
}

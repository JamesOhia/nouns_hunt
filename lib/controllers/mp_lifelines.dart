import 'dart:math';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/controllers/mp_controller.dart';
import 'package:nouns_flutter/controllers/sp_lifelines.dart';
import 'package:nouns_flutter/controllers/timer.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/data/categories.dart';

MpController _mpController = Get.find();
UserController _userController = Get.find();
//TimerController _timerController = Get.find();
Logger _logger = Get.find();

const autofillCost = 1;
const timeMachineCost = 30;
const timeFreezeCost = 50;

const outOfCoinsTitle = "Oops! Out of Coins!";
const outOfCoinsMessage =
    'Out of Coins! Come back tomorrow for some more in the daily reward';

const outOfPencilsTitle = "Awks! Out of Pencils!";
const outOfPencilsMessage =
    'Out of Pencils! Come back tomorrow for some more in the daily reward!';

const timeMachineDuration = 5;
const timeFreezeDuration = 5;

//todo cooldown time
String Autofill({required String category, required String alphabet}) {
  if (_userController.pencils < autofillCost) {
    _logger.d("Not enough pencils to use autofill");
    throw OutOfPencilsException("Not enough pencils to use autofill");
  }

  _userController.pencils -= autofillCost;

  var usedWords = _mpController.usedWords;

  var word = "";
  int tries = 0;
  int lengthOfDictionary = Categories.mpCategories[category]!["words"]!.length;

  while (true) {
    var randomIndex =
        Random().nextInt(lengthOfDictionary); //random index in given category

    word = Categories.mpCategories[category]!["words"]![randomIndex];

    if (word.startsWith(alphabet.toLowerCase()) && !usedWords.contains(word)) {
      Get.find<MpController>().autofillsRemaining -= 1;
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

// void TimeFreeze() {
//   if (_userController.coins < timeFreezeCost) {
//     _logger.d("Not enough coins to use time freeze");
//     throw OutOfCoinsException("Not enough coins to use time freeze");
//   }

//   _userController.coins -= timeFreezeCost;

//   //probably activate and deactivate animation here for timefreeze
//   _logger.d("Time Freeze active");
//   _timerController.pauseTimer(timeFreezeDuration, onComplete: () {
//     _logger.d("Time freeze expired");
//   }); //todo confirm time freeze duration
// }

// void TimeMachine() {
//   if (_userController.coins < timeMachineCost) {
//     _logger.d("Not enough coins to use time machine");
//     throw OutOfCoinsException("Not enough coins to use time machine");
//   }

//   _userController.coins -= timeMachineCost;
//   _timerController
//       .rewindTimer(timeMachineDuration); //todo confirm time machine duration
// }

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nakama/nakama.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/controllers/leaderboards_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends GetxController {
  GameController() {
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
      showTutorial = prefs.getBool('showTutorial') ?? true;
    });
  }

  final _showDailyRewardPopup = false.obs;
  final _showTutorial = false.obs;
  late SharedPreferences _prefs;

  bool get showDailyRewardPopup => _showDailyRewardPopup.value;
  set showDailyRewardPopup(bool value) => _showDailyRewardPopup.value = value;

  bool get showTutorial => _showTutorial.value;
  set showTutorial(bool value) {
    _showTutorial.value = value;
    _prefs.setBool('showTutorial', value);
  }
}

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nakama/nakama.dart';

import 'package:nouns_flutter/controllers/auth_controller.dart';
import 'dart:convert';

class UserController extends GetxController {
  final _id = ''.obs;
  final _username = ''.obs;
  final _level = ''.obs;
  final _coins = 0.obs;
  final _pencils = 0.obs;
  final _country = ''.obs;
  final _avatar = ''.obs;
  final _character = ''.obs;
  final _highScore = 0.obs;
  final _loading = false.obs;
  final _xp = 0.obs;
  final _globalRanking = 1.obs;
  final int maxXp = 5000;
  var syncWallet = false;

  SharedPreferences prefs = Get.find();
  Logger logger = Get.find();
  NakamaBaseClient nakamaClient = Get.find();

  UserController() {
    username = prefs.getString('username') ?? '';
    id = prefs.getString('id') ?? '';
    level = prefs.getString('level') ?? '1';
    coins = prefs.getInt('coins') ?? 0;
    pencils = prefs.getInt('pencils') ?? 0;
    country = prefs.getString('country') ?? 'US';
    avatar = prefs.getString('avatar') ?? '1';
    character = prefs.getString('character') ?? 'lily';
    highScore = prefs.getInt('highScore') ?? 0;
    xp = prefs.getInt('xp') ?? 0;
    globalRanking = prefs.getInt('globalRanking') ?? 0;
  }

  Future<void> fetchUserData(Session session) async {
    loading = true;
    try {
      var account = await nakamaClient.getAccount(session);
      var user = account.user;
      var metadata = jsonDecode(user.metadata);
      var wallet = jsonDecode(account.wallet);
      username = user.username;
      id = session.userId;
      level = metadata['level'] ?? '1';
      country = metadata['country'] ?? 'US';
      avatar = metadata['avatar'] ?? '1';
      character = metadata['character'] ?? 'lily';
      highScore = metadata['highScore'] ?? 0;
      xp = metadata['xp'] ?? 0;
      globalRanking = metadata['globalRanking'] ?? 1;
      coins = wallet['coins'] ?? 0;
      pencils = wallet['pencils'] ?? 0;
      logger.i("fetched user data", account);

      syncWallet = true;
    } catch (e) {
      logger.e(e);
    }
    loading = false;
  }

  Future<void> updateWallet(Map<String, int> walletChangeset) async {
    logger.i("wallet chnageste", walletChangeset);

    await NakamaWebsocketClient.instance
        .rpc(id: "update_wallet", payload: jsonEncode(walletChangeset));
  }

  Future<void> updateUsername(String username) async {
    logger.i("username  update", username);

    await NakamaWebsocketClient.instance.rpc(
        id: "update_username",
        payload: jsonEncode(Map.of({username: username})));
    _username.value = username;
  }

  String get username => _username.value;
  set username(String value) => _username.value = value;

  String get level => _level.value;
  set level(String value) => _level.value = value;

  int get coins => _coins.value;
  set coins(int newValue) {
    //submit changeset
    if (syncWallet) {
      updateWallet({'coins': newValue - coins});
    }
    _coins.value = newValue;
  }

  int get pencils => _pencils.value;
  set pencils(int newValue) {
    if (syncWallet) {
      updateWallet({'pencils': newValue - pencils});
    }
    _pencils.value = newValue;
  }

  String get country => _country.value;
  set country(String value) => _country.value = value;

  String get avatar => _avatar.value;
  set avatar(String value) => _avatar.value = value;

  String get character => _character.value;
  set character(String value) => _character.value = value;

  String get id => _id.value;
  set id(String value) => _id.value = value;

  int get highScore => _highScore.value;
  set highScore(int value) {
    _highScore.value = value;
  }

  int get xp => _xp.value;
  set xp(int value) => _xp.value = value;

  int get globalRanking => _globalRanking.value;
  set globalRanking(int value) => _globalRanking.value = value;

  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;
}

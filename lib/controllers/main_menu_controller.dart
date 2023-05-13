import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nakama/nakama.dart';

import 'package:nouns_flutter/controllers/auth_controller.dart';
import 'dart:convert';

class MainMenuController extends GetxController {
  final _usernameEditable = false.obs;

  bool get usernameEditable => _usernameEditable.value;
  set usernameEditable(bool value) => _usernameEditable.value = value;
}

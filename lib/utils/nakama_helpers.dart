import 'package:flame/game.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:nakama/api.dart';
import 'package:nakama/nakama.dart';
import 'package:nakama/rtapi.dart';
import 'package:nouns_flutter/controllers/game_controller.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/controllers/leaderboards_controller.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:nouns_flutter/controllers/mp_controller.dart';
import 'package:nouns_flutter/models/new_match_state.dart';
import 'package:nouns_flutter/models/player_round_ranking.dart';
import 'package:nouns_flutter/utils/op_codes.dart' as op_codes;
import 'package:nouns_flutter/models/presence_summary.dart';
import 'package:nouns_flutter/models/round_results_data.dart';
import 'package:fixnum/fixnum.dart';

Logger _logger = Get.find();
GameController _gameController = Get.find();
UserController _userController = Get.find();
MpSetupController _mpSetupController = Get.find();
MpController _mpController = Get.find();

void sendData({required matchId, required int opCode, required String data}) {
  _logger.i("sending data to match ${matchId} opcode ${opCode}", data);
  NakamaWebsocketClient.instance.sendMatchData(matchId: matchId, opCode: Int64(opCode), data: data.codeUnits);
  
}
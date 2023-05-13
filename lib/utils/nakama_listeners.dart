import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:nouns_flutter/utils/nakama_helpers.dart';
import 'package:nouns_flutter/utils/op_codes.dart' as op_codes;
import 'package:nouns_flutter/models/presence_summary.dart';
import 'package:nouns_flutter/models/round_results_data.dart';

Logger _logger = Get.find();
GameController _gameController = Get.find();
UserController _userController = Get.find();
MpSetupController _mpSetupController = Get.find();
MpController _mpController = Get.find();

void setupListeners(NakamaWebsocketClient socket) {
  socket.onNotifications.listen((event) {
    for (var notification in event.notifications) {
      if (notification.subject == 'DAILY_REWARD') {
        _gameController.showDailyRewardPopup = true;
      }
    }
  });

  socket.onMatchData.listen((matchData) {
    _logger.i("received new matchdata", matchData);

    switch (matchData.opCode.toInt()) {
      case op_codes.newUserJoined:
        onNewUserJoined(matchData);
        break;

      case op_codes.joinedMatch:
        onJoinedOngoingMatch(matchData);
        break;

      case op_codes.selectAlphabetRequest:
        onSelectAlphabetRequest(matchData);
        break;

      case op_codes.newRoundBegin:
        onNewRoundBegin(matchData);
        break;

      case op_codes.roundResults:
        onRoundResults(matchData);
        break;
      case op_codes.stop:
        onReceiveStop(matchData);
        break;
      case op_codes.matchEnd:
        onMatchEnd(matchData);
        break;
      case op_codes.allowGameStart:
        onAllowGameStart(matchData);
        break;
      case op_codes.hostQuit:
        onHostQuit(matchData);
        break;
      case op_codes.otherPlayerQuit:
        onOtherPlayerQuit(matchData);
        break;
      default:
        _logger.i("unknows opcode", matchData.opCode);
        break;
    }
  });
}

void onNewUserJoined(MatchData matchData) {
  var data = String.fromCharCodes(matchData.data);
  _logger.i("successfully converted List<int> to string", data);

  _mpSetupController
      .addToWaitingRoom(PresenceSummary.fromJson(jsonDecode(data)));
}

void onJoinedOngoingMatch(MatchData matchData) {
  var data =
      jsonDecode(String.fromCharCodes(matchData.data)) as Map<String, dynamic>;
  _logger.i("successfully decoded json map matchstate", data);
  var matchState = NewMatchState.fromJson(data);
  _logger.i("successfully parsed new matchstate", matchState);

  _mpSetupController.rounds = matchState.rounds;
  _mpSetupController.difficulty = matchState.difficulty;

  _mpSetupController.matchIdAlias = matchState.alias;
  _mpSetupController.host = matchState.host;
  _mpSetupController.isHost = matchState.host == _userController.id;

  _mpController.totalRounds = matchState.rounds;
  var roundRessults = Map<String, int>.of({});

  matchState.categories.forEach((category) {
    _mpSetupController.addCategory(category);
    roundRessults[category] = 0;
  });
  roundRessults["total_score"] = 0;
  roundRessults["round_score"] = 0;
  _mpController.roundResults = roundRessults;

  _mpSetupController.waitingRoomActive = true;
  matchState.presencesSummary.forEach((userId, user) {
    _mpSetupController.addToWaitingRoom(user);
  });

  sendData(
      matchId: Get.find<MpSetupController>().matchId,
      opCode: op_codes.acknowledgeJoin,
      data: jsonEncode({}));
  Get.toNamed("/mpSetup");
}

void onSelectAlphabetRequest(MatchData matchData) {
  var data =
      jsonDecode(String.fromCharCodes(matchData.data)) as Map<String, dynamic>;
  _logger.i("select alphabet request", data);

  _mpSetupController.startGameLoading = false;
  _mpController.userSelectingAlphabet = data["username"];
  _mpController.currentRound = data["currentRound"];
  _mpController.clearSelectedAlphabet();
  Get.toNamed("/mpSelectAlphabet");

  // _mpController.userSelectingAlphabet = data["username"];
  // _mpController.currentRound = data["currentRound"];
  // Get.toNamed("/mpSelectAlphabet");
}

void onNewRoundBegin(MatchData matchData) {
  var data =
      jsonDecode(String.fromCharCodes(matchData.data)) as Map<String, dynamic>;
  _logger.i("new round begin", data);
  _mpController.selectedAlphabet = data["alphabet"];
  _mpController.initializeAnswers();
  Get.toNamed("/multiplayer");
}

void onAllowGameStart(MatchData matchData) {
  var data =
      jsonDecode(String.fromCharCodes(matchData.data)) as Map<String, dynamic>;
  _logger.i("received allow game start", data);
  _mpSetupController.allowGameStart = true;
}

void onReceiveStop(MatchData matchData) {
  HapticFeedback.mediumImpact();
  var data =
      jsonDecode(String.fromCharCodes(matchData.data)) as Map<String, dynamic>;
  _logger.i("round stop", data);
  _mpController.onRoundEnd?.call();
}

void onRoundResults(MatchData matchData) {
  var data =
      jsonDecode(String.fromCharCodes(matchData.data)) as Map<String, dynamic>;
  _logger.i(" raw round results", data);
  var roundResults = RoundResultsData.fromJson(data);
  _logger.i("round results parsed", roundResults);
  _mpController.receivedResultsForRound = _mpController.currentRound;
  _mpController.roundResults = roundResults.results;

  _mpController.roundRanking = roundResults.ranking.map((entry) {
    var user = _mpSetupController.playersInWaitingRoom
        .firstWhere((element) => element.value.userId == entry["userId"]);
    return PlayerRoundRanking(
        score: entry["score"], ranking: entry["ranking"], user: user.value);
  }).toList();
}

void onMatchEnd(MatchData matchData) {
  var data =
      jsonDecode(String.fromCharCodes(matchData.data)) as Map<String, dynamic>;
  _logger.i(" end mp gmatcgh", data);
  Get.toNamed("/mpGameover");
}

void onHostQuit(MatchData matchData) {
  var data =
      jsonDecode(String.fromCharCodes(matchData.data)) as Map<String, dynamic>;
  _logger.i("host quit", data);
  Get.toNamed("/mpGameover");
  Get.snackbar("", "Host unexpectly left the game",
      duration: Duration(seconds: 5),
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.GROUNDED);
}

void onOtherPlayerQuit(MatchData matchData) {
  var data =
      jsonDecode(String.fromCharCodes(matchData.data)) as Map<String, dynamic>;
  var player = PresenceSummary.fromJson(data);
  _logger.i("other player quit quit", player);

  _mpSetupController.removeFromWaitingRoom(player);
  Get.snackbar("", "${player.username} left the game",
      duration: Duration(seconds: 5),
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.GROUNDED);
}

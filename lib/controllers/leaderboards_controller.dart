import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nakama/api.dart';
import 'package:nakama/nakama.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/controllers/auth_controller.dart';

class LeaderboardEntry {
  final String userId;
  final int rank;
  final String username;
  final String avatar;
  final String country;
  final int score;
  final String movement;

  LeaderboardEntry(
      {required this.userId,
      required this.rank,
      required this.country,
      required this.movement,
      required this.username,
      required this.avatar,
      required this.score});
}

class LeaderboardsController extends GetxController {
  final AuthController _authController = Get.find();
  final UserController _userController = Get.find();
  final Logger logger = Get.find();

  final _globalLeaderboard = <Rx<LeaderboardEntry>>[].obs;
  final _countryLeaderboard = <Rx<LeaderboardEntry>>[].obs;
  final Rx<LeaderboardRecord> _currentUserRecord = (LeaderboardRecord()).obs;

  Future<void> fecthGlobalLeaderbaord() async {
    logger.d("Fetching global leaderboard");
    var list = await getNakamaClient().listLeaderboardRecords(
        session: _authController.session, leaderboardName: 'sp_global');

    globalLeaderboard = await createLeaderboardEntries(list.records);
  }

  Future<void> fecthCountryLeaderbaord() async {
    logger.d("Fetching country leaderboard");
    var list = await getNakamaClient().listLeaderboardRecords(
        session: _authController.session,
        leaderboardName: 'sp_${_userController.country}');
    logger.d("fetched country leaderboard", list);
    countryLeaderboard = await createLeaderboardEntries(list.records);
  }

  Future<List<Rx<LeaderboardEntry>>> createLeaderboardEntries(
      List<LeaderboardRecord> records) async {
    var entries = <Rx<LeaderboardEntry>>[];

    for (var element in records) {
      var user = (await getNakamaClient().getUsers(
              session: _authController.session, ids: [element.ownerId]))
          .users[0];
      var userMetadata = jsonDecode(user.metadata);

      entries.add(LeaderboardEntry(
              userId: element.ownerId,
              rank: element.rank.toInt(),
              username: user.username, //element.username.value,
              avatar: userMetadata['avatar'] ?? "1",
              country: userMetadata['country'] ?? "KE",
              score: element.score.toInt(),
              movement: "up")
          .obs);
    }

    return entries;
  }

  Future<void> fetchCurrentUserRecord() async {
    logger.d("Fetching current user leaderboard record");

    var list = await getNakamaClient().listLeaderboardRecords(
        session: _authController.session,
        leaderboardName: 'sp_global',
        ownerIds: [_authController.session.userId],
        limit: 1);
    logger.d(
        "fetched record for owner ${_authController.session.userId}", list);
    // currentUserRecord = list.records.firstWhere(
    //     (element) => element.ownerId == _authController.session.userId,
    //     orElse: () => list.records[0]);
    logger.d("owner records ", list.ownerRecords);
    currentUserRecord = list.ownerRecords.first;
    logger.d("picked record for owner ", currentUserRecord);
  }

  List<Rx<LeaderboardEntry>> get globalLeaderboard => _globalLeaderboard.value;
  set globalLeaderboard(List<Rx<LeaderboardEntry>> value) =>
      _globalLeaderboard.value = value;

  List<Rx<LeaderboardEntry>> get countryLeaderboard =>
      _countryLeaderboard.value;
  set countryLeaderboard(List<Rx<LeaderboardEntry>> value) =>
      _countryLeaderboard.value = value;

  LeaderboardRecord get currentUserRecord => _currentUserRecord.value;
  set currentUserRecord(LeaderboardRecord value) =>
      _currentUserRecord.value = value;
}

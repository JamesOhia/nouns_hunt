import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nakama/nakama.dart';
import 'package:nouns_flutter/controllers/auth_controller.dart';
import 'package:nouns_flutter/controllers/leaderboards_controller.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/controllers/sp_gameplay.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/utils/connection.dart';
import 'package:nouns_flutter/widgets/mainmenu/leaderboard_popup.dart';
import 'package:nouns_flutter/widgets/mainmenu/rectangle_button.dart';
import 'package:nouns_flutter/widgets/mainmenu/square_button.dart';
import 'package:nouns_flutter/widgets/mainmenu/user_summary.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SpGameOver extends StatefulWidget {
  const SpGameOver({super.key});

  @override
  State<SpGameOver> createState() => _SpGameOverState();
}

class _SpGameOverState extends State<SpGameOver> {
  UserController _userController = Get.find();
  SingleplayerController _singleplayerController = Get.find();
  Logger _logger = Get.find();

  var leaderboardScale = 0.0;
  var timeUpScale = 0.0;
  var scoreScale = 0.0;
  var rotatingLightRadians = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      var pageWidth = constraints.maxWidth;
      var pageHeight = constraints.maxHeight;

      return SizedBox(
        width: pageWidth,
        height: pageHeight,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    child: UserSummary(width: pageWidth * 0.4))),
            Align(
              alignment: Alignment.topCenter,
              child: Transform.translate(
                offset: Offset(0, pageHeight * 0.12),
                child: SizedBox(
                    width: pageWidth * 0.55,
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 500),
                      scale: timeUpScale,
                      curve: Curves.bounceIn,
                      child: Image.asset(
                          "assets/images/SinglePlayer/time_up_label.png"),
                    )),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: AnimatedScale(
                  duration: const Duration(milliseconds: 500),
                  scale: scoreScale,
                  curve: Curves.bounceIn,
                  child: SizedBox(
                    width: pageWidth * 0.6,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Obx(() => _singleplayerController.isHighscore
                              ? Transform.scale(
                                  scale: 1.2,
                                  child: Transform.rotate(
                                    angle: rotatingLightRadians,
                                    child: Image.asset(
                                        "assets/images/SinglePlayer/Image_Effect_Rotate_1.png"),
                                  ),
                                )
                              : Container()),
                          Transform.translate(
                            offset: Offset(0, pageWidth * 0.05),
                            child: Transform.scale(
                              //scaleY: 0.8,
                              scaleX: 1.2,
                              child: Image.asset(
                                  "assets/images/SinglePlayer/ImageGroup_LevelUP_bg2_Lihgt.png"),
                            ),
                          ),
                          Image.asset(_singleplayerController.isHighscore
                              ? "assets/images/SinglePlayer/score_badge_highscore.png"
                              : "assets/images/SinglePlayer/ImageGroup_LevelUP_Mark_light.png"),
                          LayoutBuilder(builder: (context, constraints) {
                            return Transform.translate(
                              offset: Offset(0, constraints.maxWidth * 0.03),
                              child: SizedBox(
                                //color: Colors.red,
                                width: constraints.maxWidth * 0.35,
                                height: constraints.maxWidth * 0.35,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                      _singleplayerController.score.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: whiteColor,
                                              fontSize: pageWidth * 0.1)),
                                ),
                              ),
                            );
                          })
                        ],
                      ),
                      Container(
                        child: Image.asset(_singleplayerController.isHighscore
                            ? "assets/images/SinglePlayer/new_score.png"
                            : "assets/images/SinglePlayer/score.png"),
                      )
                    ]),
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Transform.translate(
                offset: const Offset(0, 0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: pageHeight * 0.01),
                    child: RectangleButton(
                        width: constraints.maxWidth * 0.4,
                        height: constraints.maxWidth * 0.14,
                        bgImage: "assets/images/MainMenu/blue_scaled.png",
                        textColor: blueColor,
                        label: "PLAY AGAIN",
                        onPressed: () {
                          Get.toNamed("/singleplayer");
                        },
                        locked: false),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: pageHeight * 0.01),
                    child: RectangleButton(
                        bgImage: "assets/images/MainMenu/red_scaled.png",
                        width: constraints.maxWidth * 0.4,
                        height: constraints.maxWidth * 0.14,
                        textColor: redColor,
                        label: "QUIT",
                        onPressed: () {
                          Get.toNamed("/mainMenu");
                        },
                        locked: false),
                  )
                ]),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.only(
                    left: pageWidth * 0.01, bottom: pageWidth * 0.01),
                child: SquareButton(
                  label: "Ranking",
                  onPressed: openLeaderboard,
                  locked: false,
                  iconPath:
                      'assets/images/MainMenu/IconGroup_MenuIcon02_Ranking.png',
                ),
              ),
            ),
            SizedBox(
              width: pageWidth,
              height: pageHeight,
              child: AnimatedScale(
                  alignment: Alignment.bottomLeft,
                  curve: Curves.elasticInOut,
                  duration: const Duration(milliseconds: 250),
                  scale: leaderboardScale,
                  child: LeaderboardPopup(back: closeLeaderboard)),
            ),
          ],
        ),
      );
    }));
  }

  @override
  void initState() {
    super.initState();

    apiCallWithRetry(apiCall: postHighScore);
    // postHighScore();
    //addPostfreameCallback is used to delay the animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          timeUpScale = 1;
        });
      });

      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          scoreScale = 1;
        });
      });

      Future.doWhile(() async {
        setState(() {
          rotatingLightRadians += 0.05;
        });
        await Future.delayed(const Duration(milliseconds: 100));
        return true;
      });
    });
  }

  void closeLeaderboard() {
    setState(() {
      leaderboardScale = 0;
    });
  }

  void openLeaderboard() {
    setState(() {
      leaderboardScale = 1;
    });
  }

  Future<void> postHighScore() async {
    if (_singleplayerController.isHighscore) {
      _logger.d("Posting highscore");
      _userController.highScore = _singleplayerController.score;
      Session session = Get.find<AuthController>().session;
      var metadata = Map.of({
        "triggerHook": true,
      });

      await getNakamaClient().writeLeaderboardRecord(
          session: session,
          leaderboardId: "sp_global",
          score: _singleplayerController.score,
          metadata: jsonEncode(metadata));

      Get.find<LeaderboardsController>().fetchCurrentUserRecord();
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nakama/nakama.dart';
import 'package:nouns_flutter/controllers/auth_controller.dart';
import 'package:nouns_flutter/controllers/leaderboards_controller.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/controllers/mp_controller.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/widgets/mainmenu/leaderboard_popup.dart';
import 'package:nouns_flutter/widgets/mainmenu/rectangle_button.dart';
import 'package:nouns_flutter/widgets/mainmenu/square_button.dart';
import 'package:nouns_flutter/widgets/mainmenu/user_summary.dart';
import 'package:nouns_flutter/utils/string_extensions.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/widgets/multiplayer/round_ranking_popup.dart';

class MpGameOver extends StatefulWidget {
  const MpGameOver({super.key});

  @override
  State<MpGameOver> createState() => _MpGameOverState();
}

class _MpGameOverState extends State<MpGameOver> with TickerProviderStateMixin {
  UserController _userController = Get.find();
  MpController _mpController = Get.find();

  late AnimationController _part1Controller;
  late Animation<double> _part1Animation;

  late AnimationController _part2Controller;
  late Animation<double> _part2Animation;

  var timeUpScale = 0.0;
  var scoreScale = 0.0;
  var rotatingLightRadians = 0.0;
  var showLeaderboardAndButtons = false;

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
            ScaleTransition(
                scale: _part1Animation,
                child: //Container()),
                    buildBadge(pageWidth: pageWidth, pageHeight: pageHeight)),
            ScaleTransition(
                scale: _part2Animation,
                child: buildLeaderboard(
                    pageHeight: pageHeight,
                    constraints: constraints,
                    pageWidth: pageWidth)),
            ScaleTransition(
                scale: _part2Animation,
                child: buildButtons(
                    pageHeight: pageHeight, constraints: constraints)),
          ],
        ),
      );
    }));
  }

  @override
  void initState() {
    super.initState();

    _part1Controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _part1Animation =
        CurvedAnimation(parent: _part1Controller, curve: Curves.easeInOut);

    _part2Controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _part2Animation =
        CurvedAnimation(parent: _part2Controller, curve: Curves.easeInOut);

    //postHighScore();
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

      Future.delayed(const Duration(milliseconds: 3500), () {
        setState(() {
          _part1Controller.animateTo(0,
              duration: const Duration(milliseconds: 300));
          _part2Controller.animateTo(1,
              duration: const Duration(milliseconds: 500));
        });
      });

      _part1Controller.animateTo(1, duration: const Duration(milliseconds: 0));
      _part2Controller.animateTo(0, duration: const Duration(milliseconds: 0));
    });
  }

  Widget buildButtons(
      {required BoxConstraints constraints, required double pageHeight}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Transform.translate(
        offset: const Offset(0, 0),
        child: Container(
          // color: Colors.yellow,
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(bottom: constraints.maxWidth * 0.06),
          height: constraints.maxHeight * 0.25,
          //width: constraints.maxWidth * 0.4,
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: pageHeight * 0.01),
                child: RectangleButton(
                    width: constraints.maxHeight * 0.25 * 3.0,
                    height: constraints.maxHeight * 0.25,
                    bgImage: "assets/images/MainMenu/blue_scaled.png",
                    textColor: blueColor,
                    label: "PLAY AGAIN",
                    onPressed: () {
                      Get.toNamed("/mpSetup");
                      Get.find<MpSetupController>().reset();
                      Get.find<MpController>().clearPreviousGame();
                      print("play again");
                    },
                    locked: false),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: pageHeight * 0.01),
              //   child: RectangleButton(
              //       width: constraints.maxHeight * 0.25 * 3.0,
              //       height: constraints.maxHeight * 0.25,
              //       bgImage: "assets/images/MainMenu/blue_scaled.png",
              //       textColor: blueColor,
              //       label: "NEW GAME",
              //       onPressed: () {
              //         //Get.toNamed("/singleplayer");
              //         print("new game");
              //       },
              //       locked: false),
              // ),
              Container(
                margin: EdgeInsets.symmetric(vertical: pageHeight * 0.01),
                child: RectangleButton(
                    bgImage: "assets/images/MainMenu/red_scaled.png",
                    width: constraints.maxHeight * 0.25 * 3.0,
                    height: constraints.maxHeight * 0.25,
                    textColor: redColor,
                    label: "QUIT",
                    onPressed: () {
                      Get.toNamed("/mainMenu");
                    },
                    locked: false),
              )
            ]);
          }),
        ),
      ),
    );
  }

  Widget buildBadge({required double pageWidth, required double pageHeight}) {
    return Align(
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
                  _mpController.isTopPlayer
                      ? Transform.scale(
                          scale: 1.2,
                          child: Transform.rotate(
                            angle: rotatingLightRadians,
                            child: Image.asset(
                                "assets/images/SinglePlayer/Image_Effect_Rotate_1.png"),
                          ),
                        )
                      : Container(),
                  Transform.translate(
                    offset: Offset(0, pageWidth * 0.05),
                    child: Transform.scale(
                      //scaleY: 0.8,
                      scaleX: 1.2,
                      child: Image.asset(
                          "assets/images/SinglePlayer/ImageGroup_LevelUP_bg2_Lihgt.png"),
                    ),
                  ),
                  Image.asset(_mpController.isTopPlayer
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
                          child: Text(_mpController.score.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: whiteColor,
                                      fontSize: pageWidth * 0.08)),
                        ),
                      ),
                    );
                  })
                ],
              ),
              Container(
                  alignment: Alignment.center,
                  width: pageHeight * 0.1 * 2.5,
                  height: pageHeight * 0.1,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/multiplayer/rank_badge.png"))),
                  child: Container(
                      margin: EdgeInsets.only(top: pageHeight * 0.02),
                      child: Text(
                          '${_mpController.currentPosition}'.formatAsRank(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: whiteColor,
                                  fontSize: pageWidth * 0.04)))),
            ]),
          )),
    );
  }

  Widget buildLeaderboard(
      {required double pageWidth,
      required double pageHeight,
      required BoxConstraints constraints}) {
    return Align(
        alignment: Alignment.topCenter,
        child: AnimatedScale(
            duration: const Duration(milliseconds: 500),
            scale: scoreScale,
            curve: Curves.bounceIn,
            child: Transform.translate(
                offset: Offset(0, pageHeight * 0.21),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      //color: Colors.white,
                      borderRadius: BorderRadius.circular(pageHeight * 0.01)),
                  //color: Colors.grey,
                  child: RoundRankingPopup(
                      back: () {}, inset: true, sizeMultiplier: 1.5),
                  width: pageWidth * 0.8,
                  height: pageHeight * 0.47,
                ))));
  }
}

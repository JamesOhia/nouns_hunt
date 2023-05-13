import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/controllers/game_controller.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/widgets/mainmenu/daily_reward_popup.dart';
import 'package:nouns_flutter/widgets/mainmenu/rectangle_button.dart';
import 'package:nouns_flutter/widgets/mainmenu/square_button.dart';
import 'package:nouns_flutter/widgets/mainmenu/user_summary.dart';
import 'package:nouns_flutter/widgets/mainmenu/profile_dialog.dart';
import 'package:nouns_flutter/widgets/mainmenu/leaderboard_popup.dart';
import 'package:nouns_flutter/widgets/singleplayer/currency_gauge.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  var profileDialogScale = 0.0;
  var leaderboardScale = 0.0;
  GameController _gameController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Scaffold(body: LayoutBuilder(builder: (context, constraints) {
        var pageWidth = constraints.maxWidth;
        var pageHeight = constraints.maxHeight;

        return Container(
          width: pageWidth,
          height: pageHeight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/MainMenu/main_menu_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                  margin: EdgeInsets.only(top: pageHeight * 0.03, bottom: 30),
                  child: TopSection(
                      openProfileDialog: openProfileDialog,
                      pageConstraints: Size(pageWidth, pageHeight))),
              Container(
                  margin: EdgeInsets.only(top: pageHeight * 0.13),
                  child: Image.asset(
                    "assets/images/Common/nouns_title.png",
                    width: pageWidth * 0.8,
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: pageHeight * 0.15,
                  ),
                  child: RectangleButton(
                      bgImage: "assets/images/MainMenu/gray_scaled.png",
                      width: pageWidth * 0.4,
                      height: pageWidth * 0.14,
                      label: "NOUNS HUNT",
                      onPressed: null,
                      locked: true),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: pageHeight * 0.25,
                  ),
                  child: RectangleButton(
                      width: pageWidth * 0.4,
                      height: pageWidth * 0.14,
                      label: "SPEED RUN",
                      bgImage: "assets/images/MainMenu/purple_scaled.png",
                      textColor: purpleColor,
                      onPressed: () {
                        // SharedPreferences.getInstance().then((prefs) {
                        //   if (prefs.getBool("showTutorial") ?? true) {
                        //     Get.toNamed("/spTutorial");
                        //   } else {
                        //     Get.toNamed("/singleplayer");
                        //   }
                        // });
                        Get.toNamed("/singleplayer");
                      },
                      locked: false),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: pageHeight * 0.35,
                  ),
                  child: RectangleButton(
                      width: pageWidth * 0.4,
                      height: pageWidth * 0.14,
                      bgImage: "assets/images/MainMenu/green_scaled.png",
                      textColor: greenColor,
                      label: "PLAY",
                      onPressed: () {
                        Get.toNamed("/mpLaunch");
                      },
                      locked: false),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: pageHeight * 0.02,
                  ),
                  child: SquareButton(
                    label: "Characters",
                    onPressed: () {
                      print("charcters");
                    },
                    locked: true,
                    iconPath: 'assets/images/MainMenu/Icon_ColorIcon_Emoji.Png',
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: pageHeight * 0.02,
                    left: pageHeight * 0.02,
                  ),
                  child: SquareButton(
                    label: "Store",
                    onPressed: () {
                      Get.toNamed("/store");
                    },
                    locked: true,
                    iconPath: 'assets/images/MainMenu/itemicon_home_shop_0.png',
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: pageHeight * 0.17, left: pageHeight * 0.02),
                  child: SquareButton(
                    label: "Ranking",
                    onPressed: openLeaderboard,
                    locked: false,
                    iconPath:
                        'assets/images/MainMenu/IconGroup_MenuIcon02_Ranking.png',
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: pageHeight * 0.02,
                    right: pageHeight * 0.02,
                  ),
                  child: SquareButton(
                    label: "Achievements",
                    onPressed: () {
                      print("Achievements");
                    },
                    locked: true,
                    iconPath:
                        'assets/images/MainMenu/Icon_ColorIcon_Trophy01.png',
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: pageHeight * 0.17, right: pageHeight * 0.02),
                  child: SquareButton(
                    label: "Rules",
                    onPressed: () {
                      print("Rules");
                    },
                    locked: true,
                    iconPath:
                        'assets/images/MainMenu/Icon_ColorIcon_Scroll_l.png',
                  ),
                ),
              ),
              SizedBox(
                width: pageWidth,
                height: pageHeight,
                child: Transform.scale(
                    alignment: Alignment.topLeft,
                    scale: profileDialogScale,
                    child: ProfileDialog(
                        scale: profileDialogScale,
                        closeDialog: closeProfileDialog)),
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
              SizedBox(
                width: pageWidth,
                height: pageHeight,
                child: Obx(() => Transform.scale(
                      scale: _gameController.showDailyRewardPopup ? 1 : 0,
                      child: DailyRewardPopup(
                          scale: _gameController.showDailyRewardPopup ? 1 : 0),
                    )),
              )
            ],
          ),
        );
      })),
    );
  }

  void closeProfileDialog() {
    setState(() {
      profileDialogScale = 0;
    });
  }

  void openProfileDialog() {
    setState(() {
      profileDialogScale = 1;
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
}

class TopSection extends StatelessWidget {
  final void Function() openProfileDialog;
  final Size pageConstraints;
  TopSection({
    Key? key,
    required this.openProfileDialog,
    required this.pageConstraints,
  }) : super(key: key);

  UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: pageConstraints.width,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: openProfileDialog,
                child: UserSummary(width: pageConstraints.width * 0.4)),
            Container(
              padding: EdgeInsets.only(top: pageConstraints.height * 0.01),
              width: pageConstraints.width * 0.55,
              height: pageConstraints.height * 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: pageConstraints.height * 0.035,
                      child: Obx(() => CurrencyGauge(
                          imageUrl: "assets/images/MainMenu/dash_coins.png",
                          amount: _userController.coins,
                          darkColor: orangeColor,
                          lightColor: lightOrangeColor,
                          iconSize: 20,
                          currencyIconoffset: const Offset(5, 2),
                          onPressed: () {
                            print("coins passed");
                          })),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: pageConstraints.height * 0.035,
                      child: Obx(() => CurrencyGauge(
                          imageUrl: "assets/images/MainMenu/nouns_pencil.png",
                          amount: _userController.pencils,
                          darkColor: blueColor,
                          lightColor: lightBlueColor,
                          iconSize: 17,
                          currencyIconoffset: const Offset(5, 0),
                          onPressed: () {
                            print("pencils passed");
                          })),
                    ),
                  ),
                  Container(
                    height: pageConstraints.width * 0.06,
                    //alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(
                        left: pageConstraints.width * 0.01,
                        right: pageConstraints.width * 0.01),
                    width: pageConstraints.width * 0.06,
                    //color: Colors.yellow,
                    child: Container(
                      //alignment: Alignment.topCenter,
                      //color: Colors.red,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            print("settings pressed");
                          },
                          icon: Image.asset(
                            "assets/images/MainMenu/settings_icon.png",
                            height: pageConstraints.width * 0.06,
                            width: pageConstraints.width * 0.06,
                          )),
                    ),
                  ),
                ],
              ),
            )
          ]),
    );
  }
}

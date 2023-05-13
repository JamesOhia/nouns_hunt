import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/controllers/mp_controller.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/utils/audio.dart';
import 'package:nouns_flutter/widgets/mainmenu/rectangle_button.dart';
import 'package:flutter/services.dart';

class MultiplayerLaunch extends StatefulWidget {
  const MultiplayerLaunch({super.key});

  @override
  State<MultiplayerLaunch> createState() => _MultiplayerLaunchState();
}

class _MultiplayerLaunchState extends State<MultiplayerLaunch> {
  var mpMode = MultiplayerMode.Private;
  var page = 0;
  MpSetupController _mpSetupController = Get.find();
  MpController _mpController = Get.find();

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
                margin: EdgeInsets.only(
                    top: pageHeight * 0.05, left: pageWidth * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: pageWidth * 0.07,
                      height: pageWidth * 0.07,
                      margin: EdgeInsets.only(right: pageWidth * 0.03),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: primaryColor),
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          color: Colors.white,
                          style: IconButton.styleFrom(
                              backgroundColor: darkGreyTextColor),
                          onPressed: () {
                            back();
                          },
                          icon: Icon(
                            Icons.chevron_left,
                            size: pageWidth * 0.06,
                          )),
                    ),
                    Text(
                        page == 0
                            ? 'Multiplayer'
                            : _mpSetupController.gameMode.name,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: pageWidth * 0.04, color: primaryColor))
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: pageHeight * 0.12),
                  child: Image.asset(
                    "assets/images/Common/nouns_title.png",
                    width: MediaQuery.of(context).size.width * 0.8,
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    margin: EdgeInsets.only(
                      bottom: pageHeight * 0.15,
                    ),
                    child: AnimatedSwitcher(
                        // switchInCurve: Curves.bounceIn,
                        // switchOutCurve: Curves.bounceOut,
                        transitionBuilder: (child, animation) => FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        child: page == 0
                            ? Container(
                                key: const ValueKey<int>(0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                  
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: pageHeight * 0.01),
                                      child: RectangleButton(
                                          textColor: darkBlueColor,
                                          bgImage:
                                              "assets/images/MainMenu/gray_scaled.png",
                                          width: pageWidth * 0.4,
                                          height: pageWidth * 0.14,
                                          label: "PUBLIC",
                                          onPressed: () {
                                            // setState(() {
                                            //   _mpSetupController.gameMode =
                                            //       MultiplayerMode.Public;
                                            //   page = 1;
                                            // });
                                          },
                                          locked: true),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: pageHeight * 0.01),
                                      child: RectangleButton(
                                          textColor: darkBlueColor,
                                          bgImage:
                                              "assets/images/MainMenu/blue_scaled.png",
                                          width: pageWidth * 0.4,
                                          height: pageWidth * 0.14,
                                          label: "PRIVATE",
                                          onPressed: () {
                                            setState(() {
                                              _mpSetupController.gameMode =
                                                  MultiplayerMode.Private;
                                              page = 1;
                                            });
                                          },
                                          locked: false),
                                    ),
                                  ],
                                ))
                            : Container(
                                key: const ValueKey<int>(1),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: pageHeight * 0.01),
                                      child: RectangleButton(
                                          textColor: darkBlueColor,
                                          bgImage:
                                              "assets/images/MainMenu/blue_scaled.png",
                                          width: pageWidth * 0.4,
                                          height: pageWidth * 0.14,
                                          label: "HOST",
                                          onPressed: () {
                                            _mpSetupController.reset();
                                            _mpController.clearPreviousGame();
                                            Get.toNamed("/mpSetup");
                                          },
                                          locked: false),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: pageHeight * 0.01),
                                      child: RectangleButton(
                                          textColor: darkBlueColor,
                                          bgImage:
                                              "assets/images/MainMenu/blue_scaled.png",
                                          width: pageWidth * 0.4,
                                          height: pageWidth * 0.14,
                                          label: "JOIN",
                                          onPressed: () {
                                            _mpSetupController.reset();
                                            _mpController.clearPreviousGame();
                                            _mpSetupController.isHost = false;

                                            Get.toNamed("/joinGame");
                                          },
                                          locked: false),
                                    ),
                                  ],
                                )))),
              ),
            ],
          ),
        );
      })),
    );
  }

  void back() {
    if (page == 1) {
      setState(() {
        page = 0;
      });
    } else {
      Get.back();
      playBackButtonClickSound();
    }
  }
}

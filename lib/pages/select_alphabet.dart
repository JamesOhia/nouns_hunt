import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/widgets/multiplayer/long_press_button.dart';
import 'package:nouns_flutter/widgets/multiplayer/selected_alphabet.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/widgets/mainmenu/square_button.dart';
import 'package:nouns_flutter/controllers/mp_controller.dart';
import 'package:nouns_flutter/widgets/multiplayer/alphabet_selector.dart';
import 'package:nouns_flutter/widgets/multiplayer/round_ranking_popup.dart';

class MpSelectAlphabet extends StatefulWidget {
  const MpSelectAlphabet({
    super.key,
  });

  @override
  State<MpSelectAlphabet> createState() => _MpSelectAlphabetState();
}

class _MpSelectAlphabetState extends State<MpSelectAlphabet> {
  final MpController _mpController = Get.find();
  final UserController _userController = Get.find();
  var _showRandomSelectMessage = false;
  var _randomSelectCountdown = 5;
  final _showRandomSelectMessageCountdown = 10;
  var _leaderboardScale = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Scaffold(body: LayoutBuilder(
          builder: (context, constraints) {
            var pageWidth = constraints.maxWidth;
            var pageHeight = constraints.maxHeight;

            return Container(
              width: pageWidth,
              height: pageHeight,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned.fill(
                      child: Image.asset(
                    "assets/images/MainMenu/main_menu_plainbg.png",
                    fit: BoxFit.fill,
                  )),
                  Positioned.fill(
                    child: Container(
                      padding: EdgeInsets.only(
                        top: pageHeight * 0.05,
                        bottom: pageHeight * 0.15,
                        left: pageWidth * 0.06,
                        right: pageWidth * 0.06,
                      ),
                      width: pageWidth,
                      height: pageHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: pageWidth * 0.14,
                              height: pageWidth * 0.14,
                              alignment: Alignment.center,
                              child: Obx(() => SelectedAlphabet(
                                  _mpController.selectedAlphabet))),
                          Container(
                              width: pageWidth * 0.7,
                              margin: EdgeInsets.only(
                                top: pageHeight * 0.015,
                              ),
                              alignment: Alignment.center,
                              child: Obx(() => Text(
                                  "Round ${_mpController.currentRound}/${_mpController.totalRounds}",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: pageWidth * 0.0175,
                                          color: primaryColor)))),
                          Container(
                              width: pageWidth * 0.7,
                              margin: EdgeInsets.only(
                                  top: pageHeight * 0.025,
                                  bottom: pageHeight * 0.015),
                              alignment: Alignment.center,
                              child: Obx(
                                () => _mpController.isSelectingAlphabet
                                    ? Text(
                                        "Tap And Hold Alphabet To Begin Next Round",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontSize: pageWidth * 0.02,
                                                color: primaryColor))
                                    :
                                    //  Text(
                                    //     "Waiting for ${_mpController.userSelectingAlphabet} to select alphabet"),
                                    RichText(
                                        text: TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    fontSize: pageWidth * 0.02,
                                                    color: primaryColor),
                                            children: [
                                            TextSpan(text: "Waiting for "),
                                            TextSpan(
                                                text: _mpController
                                                    .userSelectingAlphabet,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontSize:
                                                            pageWidth * 0.025,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: primaryColor)),
                                            TextSpan(
                                                text: " to select alphabet."),
                                          ])),
                              )),
                          Container(
                            width: pageWidth * 0.6,
                            height: pageWidth * 0.003,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius:
                                    BorderRadius.circular(pageWidth * 0.5)),
                          ),
                          Expanded(child:
                              LayoutBuilder(builder: (context, constraints) {
                            return Container(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,
                              alignment: Alignment.center,
                              // color: Colors.blue,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AlphabetSlectorRow(
                                      constraints: constraints,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'A',
                                          ),
                                          // child: LongPressButton(
                                          //   color: primaryColor,
                                          //   longpressAction: () {
                                          //     print("long press action");
                                          //   },
                                          // )
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'B',
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'C',
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'D',
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'E',
                                          ),
                                        ),
                                      ]),
                                  AlphabetSlectorRow(
                                      constraints: constraints,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'F',
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'G',
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'H',
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'I',
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'J',
                                          ),
                                        ),
                                      ]),
                                  AlphabetSlectorRow(
                                      constraints: constraints,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'K',
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'L',
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'M',
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'N',
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'O',
                                          ),
                                        ),
                                      ]),
                                  AlphabetSlectorRow(
                                      constraints: constraints,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'P',
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'Q',
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'R',
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'S',
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'T',
                                          ),
                                        ),
                                      ]),
                                  AlphabetSlectorRow(
                                      constraints: constraints,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'U',
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'V',
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'W',
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'X',
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'Y',
                                          ),
                                        ),
                                      ]),
                                  AlphabetSlectorRow(
                                      constraints: constraints,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          width: constraints.maxWidth / 6,
                                          height: constraints.maxWidth / 6,
                                          child: const AlphabetSelector(
                                            alphabet: 'Z',
                                          ),
                                        ),
                                      ])
                                ],
                              ),
                            );
                          })),
                          Container(
                            width: pageWidth * 0.6,
                            height: pageWidth * 0.003,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius:
                                    BorderRadius.circular(pageWidth * 0.5)),
                          ),
                          Container(
                              width: pageWidth * 0.7,
                              margin: EdgeInsets.only(
                                top: pageHeight * 0.015,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                  _showRandomSelectMessage
                                      ? "Random select in ${_randomSelectCountdown} seconds"
                                      : "",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: pageWidth * 0.02,
                                          color: redColor)))
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: pageHeight * 0.02, left: pageHeight * 0.02),
                      child: SquareButton(
                        label: "Ranking",
                        onPressed: openRanking,
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
                        scale: _leaderboardScale,
                        child: RoundRankingPopup(back: closeRanking)),
                  ),
                ],
              ),
            );
          },
        )));
  }

  @override
  initState() {
    super.initState();

    //if selecting
    if (_mpController.userSelectingAlphabet == _userController.username) {
      Future.delayed(Duration(seconds: _showRandomSelectMessageCountdown), () {
        setState(() {
          _showRandomSelectMessage = true;
        });

        Timer.periodic(const Duration(seconds: 1), (timer) {
          if (_randomSelectCountdown == 0) {
            _mpController.selectRandomAlphabet();
            timer.cancel();
            return;
          }
          setState(() {
            _randomSelectCountdown--;
          });
        });
      });
    }
  }

  void closeRanking() {
    setState(() {
      _leaderboardScale = 0;
    });
  }

  void openRanking() {
    setState(() {
      _leaderboardScale = 1;
    });
  }
}

class AlphabetSlectorRow extends StatelessWidget {
  final BoxConstraints constraints;
  final List<Widget> children;
  const AlphabetSlectorRow(
      {super.key, required this.constraints, required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}

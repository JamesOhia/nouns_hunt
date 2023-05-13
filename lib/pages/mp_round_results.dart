import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/controllers/mp_controller.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/widgets/mainmenu/square_button.dart';
import 'package:nouns_flutter/widgets/multiplayer/mp_input_field.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:nouns_flutter/widgets/multiplayer/round_ranking_popup.dart';
import 'package:nouns_flutter/widgets/multiplayer/score_widget.dart';
import 'package:nouns_flutter/controllers/timer.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/utils/string_extensions.dart';

class MpRoundResults extends StatefulWidget {
  const MpRoundResults({
    super.key,
  });

  @override
  State<MpRoundResults> createState() => _MpRoundResultsState();
}

class _MpRoundResultsState extends State<MpRoundResults> {
  final MpController _mpController = Get.find();
  final MpSetupController _mpSetupController = Get.find();
  final UserController _userController = Get.find();
  final TextEditingController _textEditingController = TextEditingController();
  final Logger _logger = Get.find();
  // final TimerController _timerController = Get.find();
  var _leaderboardScale = 0.0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
            bottom: false,
            child: Scaffold(
                extendBodyBehindAppBar: true,
                extendBody: true,
                bottomNavigationBar: Container(
                    color: Colors.transparent,
                    height: Get.height * 0,
                    width: Get.width),
                body: LayoutBuilder(builder: (context, constraints) {
                  var pageWidth = constraints.maxWidth;
                  var pageHeight = constraints.maxHeight;
                  var smallScreen = constraints.maxHeight < 500;

                  return SizedBox(
                      width: pageWidth,
                      height: pageHeight,
                      child: Stack(
                          alignment: Alignment.topCenter,
                          fit: StackFit.expand,
                          children: [
                            Positioned.fill(
                                child: Image.asset(
                              "assets/images/MainMenu/main_menu_plainbg.png",
                              fit: BoxFit.fill,
                            )),
                            Positioned.fill(
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: pageWidth * 0.05,
                                      right: pageWidth * 0.05,
                                      top: pageHeight * 0.08,
                                      bottom: pageHeight * 0.125),
                                  child: Container(
                                      alignment: Alignment.center,
                                      //color: Colors.grey[100],
                                      child: LayoutBuilder(
                                          builder: (context, constraints) {
                                        return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ResultsRow(
                                                  width: constraints.maxWidth,
                                                  height:
                                                      constraints.maxHeight *
                                                          0.09,
                                                  children: const [
                                                    ResultsLabel(
                                                        label: "CURRENT SCORE"),
                                                    ScoreWidget(
                                                      fontSizeMultiplier: 0.4,
                                                      category: "total_score",
                                                      // score: _mpController
                                                      //     .roundResults[
                                                      //         "total_score"]!
                                                      //     .toString()
                                                    )
                                                  ]),
                                              ResultsRow(
                                                  width: constraints.maxWidth,
                                                  height:
                                                      constraints.maxHeight *
                                                          0.03,
                                                  children: const [
                                                    HorizontalLine(),
                                                    HorizontalLine(),
                                                  ]),
                                              ..._mpSetupController
                                                  .selectedCategories
                                                  .map((category) {
                                                return ResultsRow(
                                                    width: constraints.maxWidth,
                                                    height:
                                                        constraints.maxHeight *
                                                            0.09,
                                                    children: [
                                                      MpInputField(
                                                          controller:
                                                              TextEditingController(),
                                                          scanAnimation: false,
                                                          category: category,
                                                          readOnly: true,
                                                          value: _mpController
                                                                  .answers[
                                                              category]),
                                                      ScoreWidget(
                                                        category: category,
                                                        fontSizeMultiplier: 0.4,
                                                      ),
                                                    ]);
                                              }),
                                              ResultsRow(
                                                  width: constraints.maxWidth,
                                                  height:
                                                      constraints.maxHeight *
                                                          0.03,
                                                  children: const [
                                                    HorizontalLine(),
                                                    HorizontalLine(),
                                                  ]),
                                              ResultsRow(
                                                  width: constraints.maxWidth,
                                                  height:
                                                      constraints.maxHeight *
                                                          0.09,
                                                  children: const [
                                                    ResultsLabel(
                                                        label: "ROUND SCORE"),
                                                    ScoreWidget(
                                                      fontSizeMultiplier: 0.4,
                                                      category: "round_score",
                                                      // score: _mpController
                                                      //     .roundResults[
                                                      //         "round_score"]!
                                                      //     .toString()
                                                    )
                                                  ]),
                                              ResultsRow(
                                                  width: constraints.maxWidth,
                                                  height:
                                                      constraints.maxHeight *
                                                          0.09,
                                                  children: [
                                                    const ResultsLabel(
                                                        label: "ROUND"),
                                                    Obx(() => ScoreWidget(
                                                        fontSizeMultiplier:
                                                            0.35,
                                                        score:
                                                            " ${_mpController.currentRound}/${_mpController.totalRounds}"))
                                                  ]),
                                            ]);
                                      }))),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: pageHeight * 0.02,
                                    left: pageHeight * 0.02),
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
                          ]));
                }))));
  }

  @override
  void initState() {
    super.initState();
    _logger.i(
        "round results page results for round ${_mpController.currentRound}");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _mpController.roundResults.forEach((key, value) {
      //   _logger.i("round results page results for round ${_mpController.currentRound} key $key value $value");
      // // });

      _mpController.sendAnswers();
    });
    //send results
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

class ResultsRow extends StatelessWidget {
  final double width;
  final double height;
  final List<Widget> children;
  const ResultsRow(
      {required this.width,
      super.key,
      required this.height,
      required this.children});

  @override
  Widget build(BuildContext context) {
    {
      return Container(
          margin: EdgeInsets.symmetric(vertical: Get.height * 0.01),
          width: width,
          height: height,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: width * 0.75, child: children[0]),
                SizedBox(width: width * 0.15, child: children[1]),
              ]));
    }
  }
}

class ResultsLabel extends StatelessWidget {
  final String label;
  const ResultsLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var smallScreen = constraints.maxHeight < 500;
        return Container(
            alignment: Alignment.center,
            clipBehavior: Clip.hardEdge,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(constraints.maxWidth * 0.3),
                color: primaryColor),
            child: Text(label.formatAsCategory(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: constraints.maxWidth * 0.05, color: whiteColor)));
      },
    );
  }
}

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.maxWidth * 0.6,
        height: constraints.maxHeight * 0.05,
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(constraints.maxHeight * 0.5)),
      );
    });
  }
}

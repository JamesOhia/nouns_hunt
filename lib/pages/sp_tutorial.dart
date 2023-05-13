import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/utils/audio.dart';
import 'package:nouns_flutter/widgets/common/tutorial_dialog.dart';
import 'package:nouns_flutter/widgets/tutorial/dot_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nouns_flutter/controllers/game_controller.dart';

class SpTutorial extends StatefulWidget {
  const SpTutorial({super.key});

  @override
  State<SpTutorial> createState() => _SpTutorialState();
}

class _SpTutorialState extends State<SpTutorial> {
  var images = List.of([
    "assets/images/SinglePlayer/screenshots/tip1.png",
    "assets/images/SinglePlayer/screenshots/tip2.png",
    "assets/images/SinglePlayer/screenshots/tip3.png",
    "assets/images/SinglePlayer/screenshots/tip4.png",
    "assets/images/SinglePlayer/screenshots/tip5.png",
    "assets/images/SinglePlayer/screenshots/tip6.png"
  ]);
  int current = 0;
  var prevDisabled = true;
  var nextDisabled = false;
  final int tipsLength = 6;

  final GameController _gameController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Scaffold(body: LayoutBuilder(builder: (context, constraints) {
          var pageWidth = constraints.maxWidth;
          var pageHeight = constraints.maxHeight;

          return Container(
              height: pageHeight,
              width: pageWidth,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/Common/letters_bg.png"),
                      fit: BoxFit.cover)),
              child: Container(
                  alignment: Alignment.center,
                  color: Colors.black.withAlpha(50),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: pageHeight * 0.8,
                          width: pageWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  //margin: EdgeInsets.only(left: pageWidth * 0.01),
                                  child: IconButton(
                                      padding:
                                          EdgeInsets.only(left: 8, right: 0),
                                      color: whiteColor,
                                      iconSize: pageWidth * 0.12,
                                      onPressed: prevDisabled ? null : prev,
                                      icon: const Icon(
                                          Icons.chevron_left))), //prev
                              Expanded(child: LayoutBuilder(
                                  builder: (context, constraints) {
                                return Container(
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight,
                                  child: Center(
                                    child: TutorialDialog(
                                      icon:
                                          "assets/images/SinglePlayer/IconGroup_TitleIcon_Cap_Navy.png",
                                      title: "Play Tutorial",
                                      heightMultiplier: 1.9,
                                      content: LayoutBuilder(
                                          builder: (context, constraints) {
                                        // return Container();
                                        return Container(
                                          width: constraints.maxWidth * 0.8,
                                          height: constraints.maxHeight,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: constraints
                                                              .maxHeight *
                                                          0.01),
                                                  width: constraints.maxWidth *
                                                      0.8,
                                                  height:
                                                      constraints.maxHeight *
                                                          0.85,
                                                  child: Image.asset(
                                                      images[current])),
                                              Container(
                                                  width: constraints.maxWidth *
                                                      0.75,
                                                  height:
                                                      constraints.maxHeight *
                                                          0.1,
                                                  child: buildTips(
                                                      pageSize: Size(pageWidth,
                                                          pageHeight))[current])
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                );
                              })),
                              Container(
                                  child: IconButton(
                                      padding:
                                          EdgeInsets.only(left: 0, right: 8),
                                      color: whiteColor,
                                      iconSize: pageWidth * 0.12,
                                      onPressed: nextDisabled ? null : next,
                                      icon: const Icon(
                                          Icons.chevron_right))), // next
                            ],
                          )), //slider
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: pageWidth * 0.01),
                                child: DotIndicator(
                                    active: current == 0,
                                    width: pageWidth * 0.025)),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: pageWidth * 0.01),
                                child: DotIndicator(
                                    active: current == 1,
                                    width: pageWidth * 0.025)),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: pageWidth * 0.01),
                                child: DotIndicator(
                                    active: current == 2,
                                    width: pageWidth * 0.025)),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: pageWidth * 0.01),
                                child: DotIndicator(
                                    active: current == 3,
                                    width: pageWidth * 0.025)),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: pageWidth * 0.01),
                                child: DotIndicator(
                                    active: current == 4,
                                    width: pageWidth * 0.025)),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: pageWidth * 0.01),
                                child: DotIndicator(
                                    active: current == 5,
                                    width: pageWidth * 0.025))
                          ],
                        ),
                      ), //dots
                      Container(
                        width: pageWidth,
                        padding:
                            EdgeInsets.symmetric(horizontal: pageWidth * 0.01),
                        child: Row(
                          //mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                  playBackButtonClickSound();
                                },
                                iconSize: pageWidth * 0.1,
                                icon: Image.asset(
                                    'assets/images/SinglePlayer/Tutorial_Focus_Icon_Left.png')),
                            Expanded(
                                child: Container(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                  Obx(() => Checkbox(
                                        value: !_gameController.showTutorial,
                                        onChanged: (value) {
                                          _gameController.showTutorial =
                                              !value!;
                                        },
                                        activeColor: blueColor,
                                        checkColor: whiteColor,
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: pageWidth * 0.005),
                                      child: Text('Don\'t show this again',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  fontSize: pageWidth * 0.02,
                                                  color: whiteColor)))
                                ]))),
                            TextButton(
                                onPressed: () {
                                  print('go to sp');
                                  Get.toNamed('/singleplayer');
                                },
                                child: Text('Skip',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: pageWidth * 0.02,
                                            color: blueColor)))
                          ],
                        ),
                      ) //dont show again
                    ],
                  )));
        })));
  }

  @override
  initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   //buildTips(pageSize: Size());
    // });
  }

  List<Widget> buildTips({required Size pageSize}) {
    return List.of([
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: pageSize.width * 0.02, color: darkGreyTextColor),
              children: [
                const TextSpan(
                  text: 'A ',
                ),
                TextSpan(
                    text: 'correct answer ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: orangeColor, fontSize: pageSize.width * 0.02)),
                const TextSpan(text: 'matches the '),
                TextSpan(
                    text: 'category ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: blueColor, fontSize: pageSize.width * 0.02)),
                const TextSpan(text: 'and '),
                TextSpan(
                    text: 'alphabet',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: blueColor, fontSize: pageSize.width * 0.02)),
                const TextSpan(text: '. You get '),
                TextSpan(
                    text: 'two ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: redColor, fontSize: pageSize.width * 0.02)),
                const TextSpan(text: 'points for each, and  '),
                TextSpan(
                    text: 'three ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: redColor, fontSize: pageSize.width * 0.02)),
                const TextSpan(text: 'seconds added time. '),
              ])),
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: pageSize.width * 0.02, color: darkGreyTextColor),
              children: [
                const TextSpan(
                  text: 'Activate a ',
                ),
                TextSpan(
                    text: 'combo ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: orangeColor, fontSize: pageSize.width * 0.02)),
                const TextSpan(text: 'when you supply answers within a '),
                TextSpan(
                    text: 'three ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: redColor, fontSize: pageSize.width * 0.02)),
                const TextSpan(
                    text:
                        'second window.Sustain this speed to increase your combo. Combos '),
                TextSpan(
                    text: 'multiply ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: blueColor, fontSize: pageSize.width * 0.02)),
                const TextSpan(text: 'your default score.'),
              ])),
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: pageSize.width * 0.02, color: darkGreyTextColor),
              children: [
                const TextSpan(
                  text: 'This is a ',
                ),
                TextSpan(
                    text: 'Time Machine',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: orangeColor, fontSize: pageSize.width * 0.02)),
                const TextSpan(text: '. It goes back '),
                TextSpan(
                    text: 'five ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: redColor, fontSize: pageSize.width * 0.02)),
                const TextSpan(text: 'seconds in time. It costs '),
                TextSpan(
                    text: '30',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: blueColor, fontSize: pageSize.width * 0.02)),
                const TextSpan(text: ' Dash Coins.'),
              ])),
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: pageSize.width * 0.02, color: darkGreyTextColor),
              children: [
                const TextSpan(
                  text: 'This is an ',
                ),
                TextSpan(
                    text: 'Autofill',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: orangeColor, fontSize: pageSize.width * 0.02)),
                const TextSpan(text: '.It selects a '),
                TextSpan(
                    text: 'random answer ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: redColor, fontSize: pageSize.width * 0.02)),
                const TextSpan(text: 'for you from our database. It costs '),
                TextSpan(
                    text: '1',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: blueColor, fontSize: pageSize.width * 0.02)),
                const TextSpan(text: ' pencil.'),
              ])),
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: pageSize.width * 0.02, color: darkGreyTextColor),
              children: [
                const TextSpan(
                  text: 'This is a ',
                ),
                TextSpan(
                    text: 'Time Freeze ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: orangeColor, fontSize: pageSize.width * 0.02)),
                const TextSpan(text: 'It locks  the timer for '),
                TextSpan(
                    text: 'eight ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: redColor, fontSize: pageSize.width * 0.02)),
                const TextSpan(text: 'seconds in time. It costs '),
                TextSpan(
                    text: '50',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: blueColor, fontSize: pageSize.width * 0.02)),
                const TextSpan(text: ' Dash Coins.'),
              ])),
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: pageSize.width * 0.02, color: darkGreyTextColor),
              children: [
                const TextSpan(
                  text: 'Already asnwered a ',
                ),
                TextSpan(
                    text: 'similar ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: orangeColor, fontSize: pageSize.width * 0.02)),
                const TextSpan(text: 'question earlier? Supply a '),
                TextSpan(
                    text: 'different ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: redColor, fontSize: pageSize.width * 0.02)),
                const TextSpan(text: 'correct answer to proceed'),
              ])),
    ]);
  }

  void next() {
    setState(() {
      if (current < tipsLength - 1) {
        current++;
        prevDisabled = current == 0;
        nextDisabled = current == tipsLength - 1;
      }
    });
  }

  void prev() {
    setState(() {
      if (current > 0) {
        current--;
        prevDisabled = current == 0;
        nextDisabled = current == tipsLength - 1;
      }
    });
  }
}

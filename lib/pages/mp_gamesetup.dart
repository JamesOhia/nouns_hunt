import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:nouns_flutter/controllers/mp_controller.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/utils/audio.dart';
import 'package:nouns_flutter/utils/string_extensions.dart';
import 'package:nouns_flutter/widgets/mainmenu/rectangle_button.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/five_star_input.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/mp_categories_listview.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/mp_waitingroom_listview.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/rounds_input.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:expandable/expandable.dart';

class MpGameSetup extends StatefulWidget {
  const MpGameSetup({
    super.key,
  });

  @override
  State<MpGameSetup> createState() => _MpGameSetupState();
}

class _MpGameSetupState extends State<MpGameSetup> {
  final MpSetupController _mpSetupController = Get.find();

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
                      width: pageWidth,
                      height: pageHeight,
                      //color: Colors.red,
                      margin: EdgeInsets.only(
                          left: pageWidth * 0.04,
                          right: pageWidth * 0.04,
                          top: pageHeight * 0.04,
                          bottom: pageHeight * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Obx(
                            () => _mpSetupController.waitingRoomActive
                                ? Container()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: pageWidth * 0.08,
                                        height: pageWidth * 0.08,
                                        margin: EdgeInsets.only(
                                            right: pageWidth * 0.03),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: primaryColor),
                                        child: IconButton(
                                            padding: EdgeInsets.zero,
                                            color: Colors.white,
                                            style: IconButton.styleFrom(
                                                backgroundColor:
                                                    darkGreyTextColor),
                                            onPressed: () {
                                              Get.back();
                                              playBackButtonClickSound();
                                            },
                                            icon: Icon(
                                              Icons.chevron_left,
                                              size: pageWidth * 0.07,
                                            )),
                                      ),
                                      Text('Game Setup',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  fontSize: pageWidth * 0.03,
                                                  color: primaryColor))
                                    ],
                                  ),
                          ), //title
                          Container(
                            margin: EdgeInsets.only(top: pageHeight * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Container(
                                  margin:
                                      EdgeInsets.only(right: pageWidth * 0.02),
                                  //color: Colors.blue,
                                  height: pageWidth * 0.15,
                                  child: TopButton(
                                      tooltip:
                                          "There are 26 rounds available, just like the 26 letters of the alphabet. Choose how many rounds, from a minimum of 5 you want to play. Click 'random' and we'll choose a round size and four categories for you.",
                                      label: 'Rounds',
                                      content: Obx(() => MpRoundsInput(
                                          locked: _mpSetupController
                                              .waitingRoomActive))),
                                )),
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: pageWidth * 0.01),
                                  //color: Colors.blue,
                                  height: pageWidth * 0.15,
                                  child: Obx(() => TopButton(
                                      tooltip:
                                          "Diffferent categories have different difficulties. The game's difficulty is the average difficulty of the four categories you've selected.",
                                      label: 'Difficulty',
                                      color: _mpSetupController
                                                  .selectedCategories.length <
                                              4
                                          ? primaryColor.withOpacity(0.7)
                                          : primaryColor,
                                      content: Obx(() => StarInput(
                                          locked: _mpSetupController
                                              .waitingRoomActive,
                                          maxValue: 5,
                                          currentValue:
                                              _mpSetupController.difficulty,
                                          updateValue: (newValue) {
                                            // _mpSetupController.difficulty =
                                            //     newValue;
                                          })))),
                                )),
                                Obx(() {
                                  return !_mpSetupController.waitingRoomActive
                                      ? Container()
                                      : Expanded(
                                          child: Container(
                                          margin: EdgeInsets.only(
                                              left: pageWidth * 0.02),
                                          //color: Colors.blue,
                                          height: pageWidth * 0.15,
                                          child: LayoutBuilder(
                                            builder: (context, constraints) {
                                              return TopButton(
                                                  icon: Container(
                                                    width:
                                                        constraints.maxHeight *
                                                            0.25,
                                                    child: LayoutBuilder(
                                                        builder: (context,
                                                            constraints) {
                                                      return IconButton(
                                                        iconSize: constraints
                                                                .maxHeight *
                                                            0.8,
                                                        padding:
                                                            EdgeInsets.zero,
                                                        onPressed: () async {
                                                          await Clipboard.setData(
                                                              ClipboardData(
                                                                  text: _mpSetupController
                                                                      .matchIdAlias));
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      'Game ID copied to clipboard')));
                                                        },
                                                        icon: const Icon(
                                                          Icons.copy,
                                                          color: Colors.white,
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                  label: 'Game ID',
                                                  content: Obx(() =>
                                                      _mpSetupController
                                                              .matchIdAlias
                                                              .isNotEmpty
                                                          ? Text(
                                                              _mpSetupController
                                                                  .matchIdAlias,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          constraints.maxWidth *
                                                                              0.08,
                                                                      color:
                                                                          primaryColor),
                                                            )
                                                          : Container(
                                                              width: constraints
                                                                      .maxHeight *
                                                                  0.25,
                                                              height: constraints
                                                                      .maxHeight *
                                                                  0.25,
                                                              child: const CircularProgressIndicator(
                                                                  color:
                                                                      primaryColor),
                                                            )));
                                            },
                                          ),
                                        ));
                                })
                              ],
                            ),
                          ),
                          Container(
                            child: Obx(
                              () => _mpSetupController.waitingRoomActive
                                  ? Container(
                                      margin: EdgeInsets.only(
                                        top: pageHeight * 0.01,
                                      ),
                                      child: Container(
                                          child: ExpandablePanel(
                                              header: Text(
                                                  "Selected Categories",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          fontSize: constraints
                                                                  .maxWidth *
                                                              0.035,
                                                          color: primaryColor)),
                                              collapsed: Container(),
                                              expanded: Container(
                                                  height: pageHeight * 0.12,
                                                  child: Obx(() =>
                                                      GridView.count(
                                                        crossAxisSpacing:
                                                            pageHeight * 0.02,
                                                        mainAxisSpacing:
                                                            pageHeight * 0.02,
                                                        childAspectRatio: 4.0,
                                                        crossAxisCount: 2,
                                                        //  shrinkWrap: true,
                                                        children: _mpSetupController
                                                            .selectedCategories
                                                            .map(
                                                                (category) =>
                                                                    Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      decoration: BoxDecoration(
                                                                          color: primaryColor.withOpacity(
                                                                              0.2),
                                                                          borderRadius:
                                                                              BorderRadius.circular(pageHeight * 0.015)),
                                                                      padding: EdgeInsets.all(
                                                                          pageHeight *
                                                                              0.01),
                                                                      child: Text(
                                                                          category
                                                                              .formatAsCategory(),
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyLarge!
                                                                              .copyWith(fontSize: constraints.maxWidth * 0.030, color: primaryColor)),
                                                                    ))
                                                            .toList(),
                                                      ))),
                                              theme: ExpandableThemeData
                                                  .withDefaults(
                                                      const ExpandableThemeData(
                                                          headerAlignment:
                                                              ExpandablePanelHeaderAlignment
                                                                  .center),
                                                      context))))
                                  : Container(),
                            ),
                          ), //Buttons
                          Expanded(
                              child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.2),
                                    borderRadius:
                                        BorderRadius.circular(pageWidth * 0.03),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      vertical: pageHeight * 0.02),
                                  padding: EdgeInsets.only(
                                      top: pageHeight * 0.02,
                                      bottom: pageHeight * 0.02),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Obx(() => Text(
                                            _mpSetupController.waitingRoomActive
                                                ? "Waiting Room"
                                                : "Categories",
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    fontSize:
                                                        constraints.maxWidth *
                                                            0.035,
                                                    color: primaryColor))),
                                        Expanded(
                                            child: Container(
                                                // color: Colors.red,
                                                margin: EdgeInsets.only(
                                                    top: pageHeight * 0.02,
                                                    left: pageWidth * 0.04),
                                                child: Obx(() =>
                                                    !_mpSetupController
                                                            .waitingRoomActive
                                                        ? MpCategoriesListView()
                                                        : WaitingRoomListView())))
                                      ]))), //Categories
                          Container(
                              margin:
                                  EdgeInsets.only(bottom: pageHeight * 0.01),
                              child: Obx(() => !_mpSetupController
                                      .waitingRoomActive
                                  ? Text(
                                      "${_mpSetupController.selectedCategories.length} / ${_mpSetupController.maxCategories}",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontSize:
                                                  constraints.maxWidth * 0.025,
                                              color: primaryColor))
                                  : Container())),
                          Obx(() => !_mpSetupController.waitingRoomActive &&
                                  _mpSetupController.isHost
                              ? Container(
                                  margin: EdgeInsets.only(
                                    left: pageWidth * 0.04,
                                  ),
                                  child: TextButton(
                                      onPressed: _mpSetupController.randomize,
                                      child: Text('Random',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontSize:
                                                      constraints.maxWidth *
                                                          0.03,
                                                  color: primaryColor))))
                              : Container()),
                          Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                vertical: pageHeight * 0.01,
                              ),
                              child: Obx(() {
                                if (!_mpSetupController.waitingRoomActive &&
                                    _mpSetupController.isHost) {
                                  return Obx(() => RectangleButton(
                                      textColor:
                                          _mpSetupController.createGameEnabled
                                              ? darkBlueColor
                                              : darkGreyTextColor,
                                      bgImage: _mpSetupController
                                              .createGameEnabled
                                          ? "assets/images/MainMenu/blue_scaled.png"
                                          : "assets/images/MainMenu/gray_scaled.png",
                                      width: pageWidth * 0.4,
                                      height: pageWidth * 0.14,
                                      label: "CREATE GAME",
                                      onPressed:
                                          _mpSetupController.createGameEnabled
                                              ? _mpSetupController.createGame
                                              : null,
                                      locked: false));
                                } else if (_mpSetupController
                                        .waitingRoomActive &&
                                    _mpSetupController.isHost) {
                                  return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        RectangleButton(
                                            textColor: redColor,
                                            bgImage:
                                                "assets/images/MainMenu/red_scaled.png",
                                            width: pageWidth * 0.4,
                                            height: pageWidth * 0.14,
                                            label: "QUIT",
                                            onPressed: () {
                                              print('quit game');

                                              _mpSetupController.quit();

                                              Get.find<MpController>()
                                                  .clearPreviousGame();
                                              Get.toNamed(
                                                  "/mainMenu"); //todo implement a dialog
                                            },
                                            locked: false),
                                        Obx(() => RectangleButton(
                                            textColor: whiteColor,
                                            bgImage: _mpSetupController
                                                    .allowGameStart
                                                ? "assets/images/MainMenu/blue_scaled.png"
                                                : "assets/images/MainMenu/gray_scaled.png",
                                            width: pageWidth * 0.4,
                                            height: pageWidth * 0.14,
                                            loading: _mpSetupController
                                                .startGameLoading,
                                            label: "START GAME",
                                            onPressed: // true  ?

                                                _mpSetupController
                                                        .allowGameStart
                                                    ? _mpSetupController
                                                        .startGame
                                                    : null,
                                            locked: false))
                                      ]);
                                } else {
                                  //non host in waiting room
                                  return RectangleButton(
                                      textColor: redColor,
                                      bgImage:
                                          "assets/images/MainMenu/red_scaled.png",
                                      width: pageWidth * 0.4,
                                      height: pageWidth * 0.14,
                                      label: "QUIT",
                                      onPressed: () {
                                        print('quit game');
                                        Get.toNamed(
                                            "/mainMenu"); //todo implement a dialog
                                      },
                                      locked: false);
                                }
                              })),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        )));
  }
}

class TopButton extends StatelessWidget {
  final String? tooltip;
  final String label;
  final Widget content;
  final Widget? icon;
  final Color color;
  const TopButton(
      {super.key,
      required this.label,
      this.tooltip,
      this.icon,
      required this.content,
      this.color = primaryColor});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
            clipBehavior: Clip.hardEdge,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(constraints.maxWidth * 0.1),
                color: primaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                        //color: Colors.blue,
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        alignment: Alignment.center,
                        child: Stack(
                          fit: StackFit.expand,
                          alignment: Alignment.center,
                          children: [
                            Positioned.fill(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    // color: Colors.green,
                                    child: Text(label,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontSize:
                                                    constraints.maxWidth * 0.08,
                                                color: whiteColor)),
                                  ),
                                  Container(
                                      //color: Colors.red,
                                      width: constraints.maxHeight * 0.3,
                                      height: constraints.maxHeight * 0.3,
                                      margin: EdgeInsets.only(
                                          left: constraints.maxWidth * 0.04),
                                      alignment: Alignment.center,
                                      child: icon ?? Container()),
                                ],
                              ),
                            ),
                            Positioned.fill(
                                child: Container(
                              //  color: Colors.blue.withOpacity(0.5),
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                              child: Tooltip(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.015,
                                    vertical: Get.width * 0.015),
                                margin: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.1),
                                showDuration:
                                    Duration(seconds: tooltip == null ? 0 : 10),
                                decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(
                                        Get.width * 0.02)),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: whiteColor,
                                        fontSize: constraints.maxWidth * 0.06),
                                message: tooltip ?? "",
                                triggerMode: TooltipTriggerMode.tap,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: constraints.maxWidth * 0.08),
                                  alignment: Alignment.centerRight,
                                  //color: Colors.yellow,
                                  height: constraints.maxHeight,
                                  width: constraints.maxWidth,
                                  child: tooltip == null ||
                                          Get.find<MpSetupController>()
                                              .waitingRoomActive
                                      ? Container()
                                      : Icon(
                                          Icons.info_outline,
                                          color: whiteColor,
                                          size: constraints.maxWidth * 0.1,
                                        ),
                                ),
                              ),
                            )),
                          ],
                        ))),
                Expanded(
                    child: Container(
                        decoration: const BoxDecoration(color: whiteColor),
                        alignment: Alignment.center,
                        child: content)),
              ],
            ));
      },
    );
  }
}

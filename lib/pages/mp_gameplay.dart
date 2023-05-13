import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:nouns_flutter/controllers/mp_controller.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/widgets/mainmenu/rectangle_button.dart';
import 'package:nouns_flutter/widgets/multiplayer/selected_alphabet.dart';
import 'package:nouns_flutter/widgets/multiplayer/position_widget.dart';
import 'package:nouns_flutter/widgets/multiplayer/mp_input_field.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/five_star_input.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/mp_categories_listview.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/mp_waitingroom_listview.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/rounds_input.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:nouns_flutter/pages/select_alphabet.dart';
import 'package:nouns_flutter/widgets/multiplayer/stop_game_button.dart';
import 'package:nouns_flutter/widgets/singleplayer/out_of_currency_dialog.dart';
import 'package:nouns_flutter/widgets/singleplayer/quit_game_dialog.dart';
import 'package:flame_fire_atlas/flame_fire_atlas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/controllers/sp_lifelines.dart';
import 'package:nouns_flutter/utils/audio.dart';
import 'package:nouns_flutter/widgets/singleplayer/currency_gauge.dart';
import 'package:nouns_flutter/widgets/singleplayer/deduct_add_animation.dart';
import 'package:nouns_flutter/widgets/singleplayer/lifeline_button.dart';
import 'package:nouns_flutter/widgets/singleplayer/out_of_currency_dialog.dart';
import 'package:nouns_flutter/widgets/singleplayer/quit_game_dialog.dart';
import 'package:nouns_flutter/widgets/singleplayer/score_widget.dart';
import 'package:nouns_flutter/widgets/singleplayer/sp_input_field.dart';
import 'package:nouns_flutter/widgets/multiplayer/timer.dart';
import 'package:nouns_flutter/widgets/singleplayer/wordcombo.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/controllers/sp_gameplay.dart';
import 'package:nouns_flutter/controllers/mp_lifelines.dart' as lifelines;
import 'package:nouns_flutter/controllers/timer.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/utils/string_extensions.dart';
import 'package:nouns_flutter/controllers/animations_controller.dart';

class MpGameplay extends StatefulWidget {
  const MpGameplay({
    super.key,
  });

  @override
  State<MpGameplay> createState() => _MpGameplayState();
}

class _MpGameplayState extends State<MpGameplay> {
  final AnimationsController _animationsController = Get.find();
  final MpController _mpController = Get.find();
  final MpSetupController _mpSetupController = Get.find();
  final UserController _userController = Get.find();
  final TextEditingController _textEditingController = TextEditingController();
  // final TimerController _timerController = Get.find();
  final Logger _logger = Get.find();
  final _textFieldDetails = <MpTextFieldDetails>[];
  final GlobalKey<OutOfCurrencyDialogState> _outOfCurrencyDialogKey =
      GlobalKey<OutOfCurrencyDialogState>();
  final GlobalKey<QuitGameDialogState> _quitGameDialogKey =
      GlobalKey<QuitGameDialogState>();

  var _loaded = false;

  var _coinsDeduct = 0;
  var _pencilsDeduct = 0;
  final GlobalKey<DeductAddAnimationState> _deductCoinsKey =
      GlobalKey<DeductAddAnimationState>();
  final GlobalKey<DeductAddAnimationState> _deductPencilsKey =
      GlobalKey<DeductAddAnimationState>();

  var _activeField;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
            bottom: false,
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
                  width: Get.width,
                  height: Get.height - MediaQuery.of(context).viewInsets.bottom,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      var pageWidth = constraints.maxWidth;
                      var pageHeight = constraints.maxHeight;
                      var smallScreen = constraints.maxHeight < 500;

                      return Container(
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
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                /// color:Colors.red,
                                width: constraints.maxWidth,
                                padding: EdgeInsets.only(
                                    left: 0.02 * pageWidth,
                                    right: 0.02 * pageWidth,
                                    top: 0.015 * pageHeight),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  alignment: AlignmentDirectional.topCenter,
                                  children: [
                                    Positioned(
                                        top: 0,
                                        left: 0,
                                        child: SpScoreWidget(
                                          multiplayer: true,
                                          constraints: constraints,
                                        )),
                                    Transform.translate(
                                      offset: Offset(
                                          0, 0.05 * constraints.maxHeight),
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                              // color: Colors.red,
                                              width:
                                                  constraints.maxHeight * 0.2,
                                              height:
                                                  constraints.maxHeight * 0.2,
                                              child: MpTimerWidget(
                                                  constraints: constraints))),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Stack(
                                                  children: [
                                                    Obx(() => CurrencyGauge(
                                                        imageUrl:
                                                            "assets/images/MainMenu/dash_coins.png",
                                                        amount: _userController
                                                            .coins,
                                                        darkColor: orangeColor,
                                                        lightColor:
                                                            lightOrangeColor,
                                                        iconSize: 25,
                                                        locked: true,
                                                        currencyIconoffset:
                                                            const Offset(5, 0),
                                                        onPressed: () {
                                                          print("coins passed");
                                                        })),
                                                    Transform.translate(
                                                      offset: Offset(
                                                          constraints.maxWidth *
                                                              0.15,
                                                          0),
                                                      child: DeductAddAnimation(
                                                        color: orangeColor,
                                                        key: _deductCoinsKey,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Stack(
                                                  children: [
                                                    Obx(() => CurrencyGauge(
                                                        locked: true,
                                                        imageUrl:
                                                            "assets/images/MainMenu/nouns_pencil.png",
                                                        amount: _userController
                                                            .pencils,
                                                        darkColor: blueColor,
                                                        lightColor:
                                                            lightBlueColor,
                                                        iconSize: 20,
                                                        currencyIconoffset:
                                                            const Offset(5, 0),
                                                        onPressed: () {
                                                          print(
                                                              "pencils passed");
                                                        })),
                                                    Transform.translate(
                                                      offset: Offset(
                                                          constraints.maxWidth *
                                                              0.15,
                                                          0),
                                                      child: DeductAddAnimation(
                                                        color: blueColor,
                                                        key: _deductPencilsKey,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: constraints.maxHeight * 0.06,
                                            child: IconButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: openQuitGameDIalog,
                                                icon: Image.asset(
                                                  "assets/images/SinglePlayer/quit button.png",
                                                  width: constraints.maxHeight *
                                                      0.06,
                                                )),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ), //Top Section
                            Positioned.fill(
                              top: constraints.maxHeight *
                                  (constraints.maxHeight < 500 ? 0.3 : 0.23),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: pageWidth * 0.05),
                                //color: Colors.red,
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Container(
                                        height: pageHeight * 0.55,
                                        // color: Colors.blue,
                                        margin: EdgeInsets.only(
                                          top: pageWidth * 0.05,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: smallScreen
                                              ? CrossAxisAlignment.start
                                              : CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Container(
                                                    //color: Colors.grey[300],
                                                    child: LayoutBuilder(
                                                  builder:
                                                      (context, constraints) {
                                                    return Container(
                                                      width: constraints
                                                              .maxHeight *
                                                          0.8,
                                                      height: constraints
                                                              .maxHeight *
                                                          0.8,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Container(
                                                            width: constraints
                                                                    .maxHeight *
                                                                0.2,
                                                            height: constraints
                                                                    .maxHeight *
                                                                0.2,
                                                            child: Obx(() =>
                                                                SelectedAlphabet(
                                                                    _mpController
                                                                        .selectedAlphabet)),
                                                          ),
                                                          Container(
                                                            width: constraints
                                                                    .maxHeight *
                                                                0.2,
                                                            height: constraints
                                                                    .maxHeight *
                                                                0.2,
                                                            child:
                                                                const PositionWidet(
                                                                    1),
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            padding: EdgeInsets
                                                                .all(constraints
                                                                        .maxHeight *
                                                                    0.01),
                                                            width: constraints
                                                                    .maxHeight *
                                                                0.8,
                                                            height: constraints
                                                                    .maxHeight *
                                                                0.1,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    primaryColor,
                                                                borderRadius: BorderRadius
                                                                    .circular(constraints
                                                                            .maxHeight *
                                                                        0.02)),
                                                            child: Obx(() => Text(
                                                                "Round ${_mpController.currentRound}/${_mpController.totalRounds}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .copyWith(
                                                                        fontSize: pageHeight *
                                                                            (smallScreen
                                                                                ? 0.02
                                                                                : 0.015),
                                                                        color:
                                                                            whiteColor))),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ))),
                                            Expanded(
                                                flex: 3,
                                                child: Container(
                                                    // color: Colors.grey[200],
                                                    child: LayoutBuilder(
                                                  builder:
                                                      (context, constraints) {
                                                    return Container(
                                                      width:
                                                          constraints.maxWidth *
                                                              0.8,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children:
                                                            _textFieldDetails
                                                                .map(
                                                                  (details) =>
                                                                      Container(
                                                                    height:
                                                                        constraints.maxHeight /
                                                                            5,
                                                                    width: constraints
                                                                            .maxWidth *
                                                                        0.8,
                                                                    child:
                                                                        MpInputField(
                                                                      focusNode:
                                                                          details
                                                                              .focusNode,
                                                                      controller:
                                                                          details
                                                                              .controller,
                                                                      onSubmit:
                                                                          () {
                                                                        var index =
                                                                            _textFieldDetails.indexOf(details);
                                                                        if (details !=
                                                                            _textFieldDetails.last) {
                                                                          index +=
                                                                              1;
                                                                        }

                                                                        _textFieldDetails[index]
                                                                            .focusNode
                                                                            .requestFocus();
                                                                      },
                                                                      category:
                                                                          details
                                                                              .category,
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                      ),
                                                    );
                                                  },
                                                ))),
                                          ],
                                        )),
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              bottom: pageHeight * 0.04),
                                          child: Obx(() => _animationsController
                                                  .autofillAnimationReady
                                              ? LifeLineBtn(
                                                  onPressed: _autofill,
                                                  limit: _mpController
                                                      .autofillsRemaining,
                                                  spriteAnimation:
                                                      _animationsController
                                                          .autofillAnimation!,
                                                  lifelineIconPath:
                                                      "assets/images/SinglePlayer/autofill.png",
                                                  currencyIconPath:
                                                      "assets/images/MainMenu/nouns_pencil.png",
                                                  currencyAmount: autofillCost,
                                                  constraints: constraints,
                                                )
                                              : Container()),
                                        )),
                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: pageHeight * 0.1,
                                            height: pageHeight * 0.1,
                                            margin: EdgeInsets.only(
                                                bottom: pageHeight * 0.04),
                                            child: BtnStopRound(
                                                stopRound: _stopRound)))
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                width: constraints.maxWidth * 0.8,
                                height: constraints.maxHeight * 0.35,
                                child: OutOfCurrencyDialog(
                                    key: _outOfCurrencyDialogKey),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                width: constraints.maxWidth * 0.8,
                                height: constraints.maxHeight * 0.35,
                                child: QuitGameDialog(
                                  key: _quitGameDialogKey,
                                  quitGame: _quitGame,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ))));
  }

  @override
  void initState() {
    super.initState();

    _animationsController.beforeStart20SecTimerAnimation();
    _mpSetupController.selectedCategories.forEach((category) {
      var _focusNode = FocusNode();
      var _controller = TextEditingController();
      var _details = MpTextFieldDetails(
          category: category, controller: _controller, focusNode: _focusNode);

      _focusNode.addListener(() {
        if (_focusNode.hasPrimaryFocus) {
          print("$category gained focus");
          _activeField = _details;
        }
      });
      _controller.addListener(() {
        print("value updated");
        _mpController.updateAnswer(
            category: _details.category, answer: _controller.text);
      });
      _textFieldDetails.add(_details);
    });
    _logger.i("setup fields", _textFieldDetails);

    mpSetup();
  }

  Future<void> mpSetup() async {
    _mpController.onRoundEnd = _onRoundEnd;
    _textFieldDetails[0].focusNode.requestFocus();
    //playSPBackgroundMusic();
    var loadedAtlas = await FireAtlas.loadAsset('atlases/sp_assets.fa');
    setState(() {
      //_atlas = loadedAtlas;
      _loaded = true;
    });

    _animationsController.t20SecTimerAnimation?.onComplete = _onRoundEnd;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationsController.start20SecTimerAnimation();
      _mpController.canStopRoundNow = false;
    });
  }

  void _quitGame() {
    removeInputFocus();
    // stopSPBackgroundMusic();
    // Get.find<TimerController>().reset();
    Get.toNamed("/mainMenu");
  }

  void _onRoundEnd() {
    //send results
    playTimeUpSound();
    print("round end");

    removeInputFocus();
    //Get.find<TimerController>().reset();
    _mpController.clearRoundResults();
    Get.toNamed("/roundResults");
  }

  void _closeCurrencyDialog() {
    _outOfCurrencyDialogKey.currentState?.dismissDialog();
  }

  void _openCurrencyDialog({required String title, required String message}) {
    _outOfCurrencyDialogKey.currentState
        ?.showDialog(title: title, message: message);
  }

  void _closeQuitGameDIalog() {
    _quitGameDialogKey.currentState?.dismissDialog();
  }

  void openQuitGameDIalog() {
    _quitGameDialogKey.currentState?.showDialog();
  }

  void removeInputFocus() {
    _textFieldDetails.forEach((details) => details.focusNode.unfocus());
  }

  @override
  void dispose() {
    removeInputFocus();
    //stopSPBackgroundMusic();
    super.dispose();
  }

  void _autofill() {
    try {
      var word = lifelines.Autofill(
          category: _activeField.category,
          alphabet: _mpController.selectedAlphabet);
      _activeField.controller.text = word;

      _deductPencilsKey.currentState?.triggerAnimation(text: "-$autofillCost");
    } on OutOfPencilsException catch (e) {
      _openCurrencyDialog(
          title: outOfPencilsTitle, message: outOfPencilsMessage);
    }
  }

  void _stopRound() {
    _mpController.sendStopSignal();
  }
}

class MpTextFieldDetails {
  final FocusNode focusNode;
  final TextEditingController controller;
  final String category;

  const MpTextFieldDetails(
      {required this.focusNode,
      required this.controller,
      required this.category});
}

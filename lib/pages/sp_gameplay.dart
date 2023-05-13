import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';
import 'package:intl/intl.dart';
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
import 'package:nouns_flutter/widgets/singleplayer/timer.dart';
import 'package:nouns_flutter/widgets/singleplayer/wordcombo.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/controllers/sp_gameplay.dart';
import 'package:nouns_flutter/controllers/sp_lifelines.dart' as lifelines;
import 'package:nouns_flutter/controllers/timer.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/utils/string_extensions.dart';
import 'package:nouns_flutter/controllers/animations_controller.dart';

class Singleplayer extends StatefulWidget {
  const Singleplayer({super.key});

  @override
  State<Singleplayer> createState() => _SingleplayerState();
}

class _SingleplayerState extends State<Singleplayer>
    with RouteAware, WidgetsBindingObserver {
  final SingleplayerController _spController = Get.find();
  //final TimerController _timerController = Get.find();
  final UserController _userController = Get.find();
  final AnimationsController _animationsController = Get.find();
  final TextEditingController _textEditingController = TextEditingController();
  late final FireAtlas _atlas;
  var _loaded = false;
  final FocusNode _inputFieldFocusNode = FocusNode();

  var coinsDeduct = 0;
  var pencilsDeduct = 0;
  final GlobalKey<DeductAddAnimationState> _deductCoinsKey =
      GlobalKey<DeductAddAnimationState>();
  final GlobalKey<DeductAddAnimationState> _deductPencilsKey =
      GlobalKey<DeductAddAnimationState>();
  final GlobalKey<SpTimerWidgetState> _timerStateKey =
      GlobalKey<SpTimerWidgetState>();
  final GlobalKey<OutOfCurrencyDialogState> _outOfCurrencyDialogKey =
      GlobalKey<OutOfCurrencyDialogState>();
  final GlobalKey<QuitGameDialogState> _quitGameDialogKey =
      GlobalKey<QuitGameDialogState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: Get.width,
            height: Get.height - MediaQuery.of(context).viewInsets.bottom,
            child: LayoutBuilder(builder: (context, constraints) {
              var smallScreen = constraints.maxHeight < 500;

              print("maxheight: ${constraints.maxHeight}");
              return Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/SinglePlayer/sp_background.png"),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  fit: StackFit.expand,
                  children: [
                    Positioned.fill(
                        child: Center(
                      child: Obx(() => Image(
                            height: constraints.maxWidth > constraints.maxHeight
                                ? constraints.maxHeight * 0.6
                                : null,
                            width: constraints.maxHeight > constraints.maxWidth
                                ? constraints.maxWidth * 0.7
                                : null,
                            image: AssetImage(
                                "assets/images/SinglePlayer/bg_${_spController.currentAlphabet.toUpperCase()}.png"),
                          )),
                    )), //background letter
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: constraints.maxWidth,
                        padding: EdgeInsets.only(
                            left: constraints.maxWidth * 0.02,
                            right: constraints.maxWidth * 0.02,
                            top: constraints.maxHeight * 0.02),
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: AlignmentDirectional.topCenter,
                          children: [
                            Positioned(
                                top: 0,
                                left: 0,
                                child: SpScoreWidget(
                                  constraints: constraints,
                                )),
                            Transform.translate(
                              offset: Offset(0, 0.05 * constraints.maxHeight),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      width: constraints.maxHeight * 0.2,
                                      height: constraints.maxHeight * 0.2,
                                      child: SpTimerWidget(
                                          key: _timerStateKey,
                                          constraints: constraints))),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // color: Colors.blue,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              width: constraints.maxWidth * 0.4,
                                              height:
                                                  constraints.maxHeight * 0.04,
                                              child: Obx(() => CurrencyGauge(
                                                  imageUrl:
                                                      "assets/images/MainMenu/dash_coins.png",
                                                  amount: _userController.coins,
                                                  darkColor: orangeColor,
                                                  lightColor: lightOrangeColor,
                                                  iconSize:
                                                      constraints.maxHeight *
                                                          0.03,
                                                  currencyIconoffset:
                                                      const Offset(5, 1),
                                                  locked: true,
                                                  onPressed: () {
                                                    print("coins passed");
                                                  })),
                                            ),
                                            Transform.translate(
                                              offset: Offset(
                                                  constraints.maxWidth * 0.35,
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
                                            Container(
                                              width: constraints.maxWidth * 0.4,
                                              height:
                                                  constraints.maxHeight * 0.04,
                                              child: Obx(() => CurrencyGauge(
                                                  imageUrl:
                                                      "assets/images/MainMenu/nouns_pencil.png",
                                                  amount:
                                                      _userController.pencils,
                                                  darkColor: blueColor,
                                                  lightColor: lightBlueColor,
                                                  iconSize:
                                                      constraints.maxHeight *
                                                          0.025,
                                                  currencyIconoffset:
                                                      const Offset(5, 1),
                                                  locked: true,
                                                  onPressed: () {
                                                    print("pencils passed");
                                                  })),
                                            ),
                                            Transform.translate(
                                              offset: Offset(
                                                  constraints.maxWidth * 0.35,
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
                                    margin: EdgeInsets.only(
                                        left: constraints.maxHeight * 0.01),
                                    width: constraints.maxHeight * 0.08,
                                    child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: openQuitGameDIalog,
                                        icon: Image.asset(
                                          "assets/images/SinglePlayer/quit button.png",
                                          width: constraints.maxHeight * 0.08,
                                        )),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ), //top section
                    Positioned.fill(
                      top: constraints.maxHeight *
                          (constraints.maxHeight < 500 ? 0.3 : 0.2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          // color: Colors.red,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Column(
                                children: [
                                  _loaded
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              top: constraints.maxHeight *
                                                  (smallScreen ? 0.01 : 0.1)),
                                          width: constraints.maxHeight *
                                              (smallScreen ? 0.65 : 0.6),
                                          height: constraints.maxHeight *
                                              (smallScreen ? 0.25 : 0.3),
                                          child: WordCombo(
                                              spriteAtlas: _atlas,
                                              constraints: constraints))
                                      : Container(),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: constraints.maxHeight *
                                            (smallScreen ? 0.01 : 0.04),
                                        bottom: 1),
                                    child: Obx(() => Text(
                                          _spController.currentCategory
                                              .formatAsCategory(),
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontSize: (smallScreen
                                                          ? 0.035
                                                          : 0.035) *
                                                      constraints.maxHeight),
                                        )),
                                  ),
                                  _loaded
                                      ? SpInputField(
                                          inputFieldFocusNode:
                                              _inputFieldFocusNode,
                                          constraints: constraints,
                                          spriteAtlas: _atlas,
                                          textEditingController:
                                              _textEditingController)
                                      : Container(),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: constraints.maxWidth * 0.01),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(() => _animationsController
                                                .timemachineAnimationReady
                                            ? LifeLineBtn(
                                                onPressed: _timeMachine,
                                                spriteAnimation:
                                                    _animationsController
                                                        .timemachineAnimation!,
                                                lifelineIconPath:
                                                    "assets/images/SinglePlayer/time_machine.png",
                                                currencyIconPath:
                                                    "assets/images/MainMenu/dash_coins.png",
                                                currencyAmount: timeMachineCost,
                                                constraints: constraints,
                                              )
                                            : Container()),
                                        Obx(() => _animationsController
                                                .autofillAnimationReady
                                            ? lifelines.autofillDisabled
                                                ? Container(
                                                    width:
                                                        constraints.maxHeight *
                                                            (smallScreen
                                                                ? 0.15
                                                                : 0.10),
                                                    height:
                                                        constraints.maxHeight *
                                                            (smallScreen
                                                                ? 0.15
                                                                : 0.10),
                                                    child: Image.asset(
                                                        "assets/images/SinglePlayer/disabled_autofill.png"),
                                                  )
                                                : LifeLineBtn(
                                                    onPressed: _autofill,
                                                    spriteAnimation:
                                                        _animationsController
                                                            .autofillAnimation!,
                                                    lifelineIconPath:
                                                        "assets/images/SinglePlayer/autofill.png",
                                                    currencyIconPath:
                                                        "assets/images/MainMenu/nouns_pencil.png",
                                                    currencyAmount:
                                                        autofillCost,
                                                    constraints: constraints,
                                                  )
                                            : Container()),
                                        Obx(() => _animationsController
                                                .timefreezeAnimationReady
                                            ? lifelines.timeFreezeDisabled
                                                ? Container(
                                                    width:
                                                        constraints.maxHeight *
                                                            (smallScreen
                                                                ? 0.15
                                                                : 0.10),
                                                    height:
                                                        constraints.maxHeight *
                                                            (smallScreen
                                                                ? 0.15
                                                                : 0.10),
                                                    child: Image.asset(
                                                        "assets/images/SinglePlayer/disabled_timefreeze.png"),
                                                  )
                                                : LifeLineBtn(
                                                    onPressed: _timeFreeze,
                                                    spriteAnimation:
                                                        _animationsController
                                                            .timefreezeAnimation!,
                                                    lifelineIconPath:
                                                        "assets/images/SinglePlayer/time_freeze.png",
                                                    currencyIconPath:
                                                        "assets/images/MainMenu/dash_coins.png",
                                                    currencyAmount:
                                                        timeFreezeCost,
                                                    constraints: constraints,
                                                  )
                                            : Container())
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              // const Positioned(
                              //     right: 0,
                              //     // bottom: ,
                              //     child: Text("impression gauge"))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: constraints.maxWidth * 0.8,
                        height: constraints.maxHeight * 0.35,
                        child:
                            OutOfCurrencyDialog(key: _outOfCurrencyDialogKey),
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
            }),
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    spSetup();
  }

  void inputOnLostFocus() {
    print("lost focus");
    if (!_inputFieldFocusNode.hasPrimaryFocus) {
      _inputFieldFocusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    removeInputFocus();
    stopSPBackgroundMusic();
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  void _quitGame() {
    removeInputFocus();
    stopSPBackgroundMusic();

    Get.toNamed("/mainMenu");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app resumed");
        _inputFieldFocusNode.addListener(inputOnLostFocus);
        //inputOnLostFocus();
        playSPBackgroundMusic();
        break;
      case AppLifecycleState.paused:
        print("app paused");
        removeInputFocus();
        stopSPBackgroundMusic();
        break;
      case AppLifecycleState.inactive:
        print("app inactive");
        removeInputFocus();
        stopSPBackgroundMusic();
        break;
      default:
        print("unhandled case ${state.toString()}}");
    }
  }

  void removeInputFocus() {
    _inputFieldFocusNode.removeListener(inputOnLostFocus);
    _inputFieldFocusNode.unfocus();
  }

  Future<void> spSetup() async {
    _inputFieldFocusNode.addListener(inputOnLostFocus);
    playSPBackgroundMusic();
    var loadedAtlas = await FireAtlas.loadAsset('atlases/sp_assets.fa');
    setState(() {
      _atlas = loadedAtlas;
      _loaded = true;
    });
    _spController.reset();

    _animationsController.beforeStart90SecTimerAnimation();
    _animationsController.t90SecTimerAnimation?.onComplete = _onGameOver;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationsController.start90SecTimerAnimation();
    });
  }

  void _autofill() {
    print("try autofill");
    try {
      var word = lifelines.Autofill(
          category: _spController.currentCategory,
          alphabet: _spController.currentAlphabet);
      _textEditingController.text = word;
      _textEditingController.selection =
          TextSelection.collapsed(offset: _textEditingController.text.length);

      _deductPencilsKey.currentState?.triggerAnimation(text: "-$autofillCost");
    } on OutOfPencilsException catch (e) {
      _openCurrencyDialog(
          title: outOfPencilsTitle, message: outOfPencilsMessage);
    } on LifeineCooldownException catch (e) {
      print(e);
    }
  }

  void _timeFreeze() {
    print("try timefreeze");
    try {
      lifelines.TimeFreeze();

      _deductCoinsKey.currentState?.triggerAnimation(text: "-$timeFreezeCost");

      _timerStateKey.currentState?.timeFreeze();
    } on OutOfCoinsException catch (e) {
      _openCurrencyDialog(title: outOfCoinsTitle, message: outOfCoinsMessage);
    } on LifeineCooldownException catch (e) {
      print(e);
    }
  }

  void _timeMachine() {
    print("try timemachine");
    try {
      lifelines.TimeMachine();

      _deductCoinsKey.currentState?.triggerAnimation(text: "-$timeMachineCost");

      _timerStateKey.currentState?.timeMachine();
    } on OutOfCoinsException catch (e) {
      _openCurrencyDialog(title: outOfCoinsTitle, message: outOfCoinsMessage);
    }
  }

  void _onGameOver() {
    //Get.find<TimerController>().reset();
    playTimeUpSound();
    removeInputFocus();
    stopSPBackgroundMusic();
    Get.toNamed("/spGameover");
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
}

import 'dart:math';
import 'dart:core';
import 'dart:convert';
import 'dart:async' as dart_async;
import 'package:flame/game.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nakama/nakama.dart';
import 'package:nouns_flutter/controllers/game_controller.dart';
import 'package:nouns_flutter/controllers/mp_controller.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/controllers/leaderboards_controller.dart';
import 'package:nouns_flutter/controllers/sp_lifelines.dart';
import 'package:nouns_flutter/models/player_round_ranking.dart';
import 'package:nouns_flutter/models/presence_summary.dart';
import 'package:nouns_flutter/utils/op_codes.dart' as op_codes;
import 'package:nouns_flutter/utils/nakama_helpers.dart' as nakama_helpers;
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:flame/widgets.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';
import 'package:intl/intl.dart';

class AnimationsController extends GetxController {
  Logger _logger = Get.find();
  List<Sprite> _90SecTimerSprites = [];
  List<Sprite> _20SecTimerSprites = [];
  List<Sprite> _frozenTimerSprites = [];
  List<Sprite> _autofillSprites = [];
  List<Sprite> _timemachneSprites = [];
  List<Sprite> _timefreezeSprites = [];

  SpriteAnimation? t90SecTimerAnimation;
  SpriteAnimation? t20SecTimerAnimation;
  SpriteAnimation? frozenTimerAnimation;
  SpriteAnimation? autofillAnimation;
  SpriteAnimation? timemachineAnimation;
  SpriteAnimation? timefreezeAnimation;

  final _t90SecTimerAnimationReady = false.obs;
  final _t20SecTimerAnimationReady = false.obs;
  final _frozenTimerAnimationReady = false.obs;
  final _autofillAnimationReady = false.obs;
  final _timemachineAnimationReady = false.obs;
  final _timefreezeAnimationReady = false.obs;

  var _t90SecTimerTotalFrames = 0;
  var _t20SecTimerTotalFrames = 0;
  var _iceEffectTotalFrames = 0;

  // stepTime is the time between each frame in the animation. This calculated by
  // dividing the total duration of the animation by the number of frames in the animation.
  // The value is then multiplied by 1.5 to slow down the animation.
  var t90SecStepTime = 0.0;
  var t20SecStepTime = 0.0;
  var iceEffectStepTime = 0.0;

  final autofillStepTime = 0.1;
  final timefreezeStepTime = 0.1;
  final timemachineStepTime = 0.1;
  var timerPausedAt = 0;

  dart_async.Timer? _90SecTimer;
  dart_async.Timer? _20SecTimer;
  var _90SecStarted = false;
  var _20SecStarted = false;

  final _t90SecCurrentIndex = 0.obs;
  int get t90SecCurrentIndex => _t90SecCurrentIndex.value;
  set t90SecCurrentIndex(int value) {
    _t90SecCurrentIndex.value = value;
    t90SecTimerAnimation?.currentIndex = value;
  }

  final _t20SecCurrentIndex = 0.obs;
  int get t20SecCurrentIndex => _t20SecCurrentIndex.value;
  set t20SecCurrentIndex(int value) {
    _t20SecCurrentIndex.value = value;
    t20SecTimerAnimation?.currentIndex = value;
  }

  AnimationsController() {
    _t90SecTimerTotalFrames = 1256;
    _t20SecTimerTotalFrames = 283;
    _iceEffectTotalFrames = 147;

    // stepTime is the time between each frame in the animation. This calculated by
    // dividing the total duration of the animation by the number of frames in the animation.
    // The value is then multiplied by 1.5 to slow down the animation.
    t90SecStepTime = (90 / _t90SecTimerTotalFrames) * 1.5;
    t20SecStepTime = (20 / _t20SecTimerTotalFrames) * 1.5;
    //t20SecStepTime = (20 / _t20SecTimerTotalFrames) * 10000;
    iceEffectStepTime = (timeFreezeDuration / _iceEffectTotalFrames) * 1.5;

    load90SecTimerAnimation();
    load20SecTimerAnimation();
    loadFrozenTimerAnimation();
    loadAutofillAnimation();
    loadTimemachineAnimation();
    loadTimefreezeAnimation();
  }

  Future<void> load90SecTimerAnimation() async {
    NumberFormat formatter = NumberFormat("00000");

    for (int i = 0; i <= _t90SecTimerTotalFrames; i++) {
      _90SecTimerSprites.add(await Sprite.load(
          "SinglePlayer/timer/Timer_${formatter.format(i)}.png"));
    }

    t90SecTimerAnimation = SpriteAnimation.spriteList(_90SecTimerSprites,
        stepTime: t90SecStepTime, loop: false);
    _t90SecTimerAnimationReady.value = true;
    _logger.i("t90SecTimerAnimation loaded");
  }

  Future<void> beforeStart90SecTimerAnimation() async {
    while (!_90SecStarted) {
      t90SecCurrentIndex = 0;
      t90SecTimerAnimation!.currentIndex = 0;
      await Future.delayed(const Duration(milliseconds: 250));
    }
  }

  void start90SecTimerAnimation() {
    var timeMultiplier = 0.125;
    t90SecCurrentIndex = 0;
    t90SecTimerAnimation!.currentIndex = 0;
    var framesPerSecond = 1 ~/ t90SecStepTime;
    var scaledFramesPerSecond = (framesPerSecond * 0.05 * timeMultiplier).ceil();
    _90SecStarted = true;
    var lastIndex = t90SecTimerAnimation!.frames.length - 1;

    dart_async.Timer.periodic(
        Duration(milliseconds: (500 * timeMultiplier).ceil()), (timer) {
      if ((t90SecTimerAnimation!.currentIndex + scaledFramesPerSecond) >=
          lastIndex - 1) {
        timer.cancel();
        _logger.i("90 sec timer animation finished");
      }
      t90SecCurrentIndex += scaledFramesPerSecond;
      // t90SecTimerAnimation!.currentIndex += scaledFramesPerSecond;
      // t90SecTimerAnimation!.currentIndex = t90SecCurrentIndex;
      print("currentinex: $t90SecCurrentIndex");
      print(
          "updateded 90 sec timer animation ${t90SecTimerAnimation!.currentIndex} / ${lastIndex}");
    });
  }

  Future<void> pause90SecondsAnimation(int seconds) async {
    bool paused = true;

    Future.delayed(Duration(seconds: seconds), () {
      paused = false;
      _logger.i("set paused false");
    });

    var currentIndex = t90SecTimerAnimation!.currentIndex;
    _logger.i("begin timefreeze");
    timerPausedAt = currentIndex;
    while (paused) {
      t90SecCurrentIndex = currentIndex;
      //t90SecTimerAnimation!.currentIndex = currentIndex;
      // t90SecTimerAnimation!.currentIndex = t90SecCurrentIndex;
      await Future.delayed(const Duration(milliseconds: 100));
      print("in pause loop");
    }
    print("outside loop");
    //t90SecTimerAnimation!.update(dt)
  }

  Future<void> rewind90SecAnim(double seconds) async {
    t90SecCurrentIndex -= seconds ~/ t90SecStepTime; //the step time
    // t90SecTimerAnimation!.currentIndex -=
    //     seconds ~/ t90SecStepTime; //the step time
    // t90SecTimerAnimation!.currentIndex = t90SecCurrentIndex; //the step time
  }

  Future<void> load20SecTimerAnimation() async {
    NumberFormat formatter = NumberFormat("00000");

    for (int i = 0; i <= _t20SecTimerTotalFrames; i++) {
      _20SecTimerSprites.add(await Sprite.load(
          "multiplayer/timer/20 sec Timer_${formatter.format(i)}.png"));
    }

    t20SecTimerAnimation = SpriteAnimation.spriteList(_20SecTimerSprites,
        stepTime: t20SecStepTime, loop: false);
    _t20SecTimerAnimationReady.value = true;
    _logger.i("t20SecTimerAnimation loaded");

    t20SecTimerAnimation!.onFrame = (frame) {
      //midframe is 335(totalframes) /2
      //we adjust it by 2 seconds(2 animation seconds is 2 * (1~/t20SecStepTime)
      if (frame == (335 ~/ 2) - (2 * (1 ~/ t20SecStepTime))) {
        _logger.i("20 sec timer animation midway");
        Get.find<MpController>().canStopRoundNow = true;
      }
    };
  }

  Future<void> beforeStart20SecTimerAnimation() async {
    while (!_20SecStarted) {
      t20SecTimerAnimation!.currentIndex = 0;
      await Future.delayed(const Duration(milliseconds: 250));
    }
  }

  void start20SecTimerAnimation() {
    var timeMultiplier = 0.125;
    t20SecCurrentIndex = 0;
    t20SecTimerAnimation!.currentIndex = 0;
    var framesPerSecond = 1 ~/ t20SecStepTime;
    var scaledFramesPerSecond = (framesPerSecond * 0.05 * timeMultiplier).ceil();
    _20SecStarted = true;
    var lastIndex = t20SecTimerAnimation!.frames.length - 1;

    dart_async.Timer.periodic(
        Duration(milliseconds: (500 * timeMultiplier).ceil()), (timer) {
      if ((t20SecTimerAnimation!.currentIndex + scaledFramesPerSecond) >=
          lastIndex - 1) {
        timer.cancel();
        _logger.i("20 sec timer animation finished");
      }
      t20SecCurrentIndex += scaledFramesPerSecond;
      print(
          "updateded 90 sec timer animation ${t20SecTimerAnimation!.currentIndex} / ${lastIndex}");
    });
  }

  Future<void> loadFrozenTimerAnimation() async {
    NumberFormat formatter = NumberFormat("00000");

    for (int i = 28; i <= 174; i++) {
      _frozenTimerSprites.add(await Sprite.load(
          //aassets/images/SinglePlayer/time_freeze_animation/Time freeze vfx_00000_00028.png
          "SinglePlayer/time_freeze_animation/Time freeze vfx_00000_${formatter.format(i)}.png"));
    }

    frozenTimerAnimation = SpriteAnimation.spriteList(_frozenTimerSprites,
        stepTime: iceEffectStepTime, loop: false);
    _frozenTimerAnimationReady.value = true;
    _logger.i("_frozenTimerAnimationReady loaded");
  }

  Future<void> loadAutofillAnimation() async {
    NumberFormat formatter = NumberFormat("00000");

    for (int i = 0; i <= 79; i++) {
      _autofillSprites.add(await Sprite.load(
          "SinglePlayer/lifelines/autofill/AutoFill_${formatter.format(i)}.png"));
    }

    autofillAnimation = SpriteAnimation.spriteList(_autofillSprites,
        stepTime: autofillStepTime);
    _autofillAnimationReady.value = true;
    _logger.i("_autofillAnimationReady loaded");
  }

  Future<void> loadTimemachineAnimation() async {
    NumberFormat formatter = NumberFormat("00000");

    for (int i = 0; i <= 63; i++) {
      _timemachneSprites.add(await Sprite.load(
          //assets/images/SinglePlayer/lifelines/timemachine/Time Machine_00000.png
          "SinglePlayer/lifelines/timemachine/Time Machine_${formatter.format(i)}.png"));
    }

    timemachineAnimation = SpriteAnimation.spriteList(_timemachneSprites,
        stepTime: timemachineStepTime);
    _timemachineAnimationReady.value = true;
    _logger.i("_timemachineAnimationReady loaded");
  }

  Future<void> loadTimefreezeAnimation() async {
    NumberFormat formatter = NumberFormat("00000");

    for (int i = 0; i <= 79; i++) {
      _timefreezeSprites.add(await Sprite.load(
          //assets/images/SinglePlayer/lifelines/timefreeze/Time Freeze_00000.png
          "SinglePlayer/lifelines/timefreeze/Time Freeze_${formatter.format(i)}.png"));
    }

    timefreezeAnimation = SpriteAnimation.spriteList(_timefreezeSprites,
        stepTime: timefreezeStepTime);
    _timefreezeAnimationReady.value = true;
    _logger.i("_timefreezeAnimationReady loaded");
  }

  bool get t90SecTimerAnimationReady => _t90SecTimerAnimationReady.value;
  set t90SecTimerAnimationReady(bool value) {
    _t90SecTimerAnimationReady.value = value;
  }

  bool get t20SecTimerAnimationReady => _t20SecTimerAnimationReady.value;
  set t20SecTimerAnimationReady(bool value) {
    _t20SecTimerAnimationReady.value = value;
  }

  bool get frozenTimerAnimationReady => _frozenTimerAnimationReady.value;
  set frozenTimerAnimationReady(bool value) {
    _frozenTimerAnimationReady.value = value;
  }

  bool get autofillAnimationReady => _autofillAnimationReady.value;
  set autofillAnimationReady(bool value) {
    _autofillAnimationReady.value = value;
  }

  bool get timemachineAnimationReady => _timemachineAnimationReady.value;
  set timemachineAnimationReady(bool value) {
    _timemachineAnimationReady.value = value;
  }

  bool get timefreezeAnimationReady => _timefreezeAnimationReady.value;
  set timefreezeAnimationReady(bool value) {
    _timefreezeAnimationReady.value = value;
  }
}

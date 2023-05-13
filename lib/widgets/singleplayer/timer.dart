//import 'package:flame/animation.dart' as animation; // imports the Animation class under animation.Animation
// imports the Flame helper class
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'package:nouns_flutter/controllers/sp_lifelines.dart' as lifelines;
import 'package:nouns_flutter/controllers/timer.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:flame/widgets.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';
import 'package:intl/intl.dart';
import 'package:nouns_flutter/controllers/animations_controller.dart';

class SpTimerWidget extends StatefulWidget {
  final BoxConstraints constraints;

  const SpTimerWidget({super.key, required this.constraints});

  @override
  State<SpTimerWidget> createState() => SpTimerWidgetState();
}

class SpTimerWidgetState extends State<SpTimerWidget> {
  //final TimerController _timerController = Get.find();
  final AnimationsController _animationsController = Get.find();
  final GlobalKey<FreezeEffectState> freezeEffectStateKey =
      GlobalKey<FreezeEffectState>();
  var _timerOpacity = 1.0;

  @override
  Widget build(BuildContext context) {
    _animationsController.t90SecTimerAnimation?.currentIndex =
        _animationsController.t90SecCurrentIndex;
    return Container(
        // color: Colors.green,
        width: widget.constraints.maxWidth,
        height: widget.constraints.maxHeight,
        // child: Obx(() =>_animationsController.t90SecTimerAnimationReady ?  SpriteAnimationWidget(
        //                 animation: _animationsController.t90SecTimerAnimation! ): Container())
        //   );
        child: Stack(alignment: Alignment.center, children: [
          Positioned.fill(
              child: Opacity(
            opacity: _timerOpacity,
            child: SpriteAnimationWidget(
                playing: true,
                animation: _animationsController.t90SecTimerAnimation!
                  ..currentIndex = _animationsController.t90SecCurrentIndex),
          )),
          Positioned.fill(child: FreezeEffect(key: freezeEffectStateKey))
        ]));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void updateTimerOpacity(double opacity) {
    setState(() {
      _timerOpacity = opacity;
    });
  }

  void timeFreeze() {
    // _animationsController.timefreezeAnimation?.onComplete = () {
    //   updateTimerOpacity(1.0);
    // };

    Future.delayed(Duration(milliseconds: lifelines.timeFreezeDuration), () {
      updateTimerOpacity(1.0);
    });
    updateTimerOpacity(0.0);

    freezeEffectStateKey.currentState?.timeFreeze();
  }

  void timeMachine() {
    //_animationsController.t90SecTimerAnimation?.update(-8);
  }
}

class FreezeEffect extends StatefulWidget {
  const FreezeEffect({super.key});

  @override
  State<FreezeEffect> createState() => FreezeEffectState();
}

class FreezeEffectState extends State<FreezeEffect> {
  var _timeFreezeActive = false;
  final AnimationsController _animationsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: 1.01,
        child: AnimatedOpacity(
          opacity: _timeFreezeActive ? 1 : 0,
          duration: Duration(milliseconds: 100),
          child: SpriteAnimationWidget(
              animation: _animationsController.frozenTimerAnimation!),
        ));
  }

  void timeFreeze() {
    setState(() {
      //todo pause timer
      _animationsController.frozenTimerAnimation?.reset();
      _timeFreezeActive = true;
    });

    Future.delayed(Duration(seconds: lifelines.timeFreezeDuration), () {
      setState(() {
        _timeFreezeActive = false;
      });
    });
  }
}

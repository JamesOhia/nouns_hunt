//import 'package:flame/animation.dart' as animation; // imports the Animation class under animation.Animation
// imports the Flame helper class
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
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

class MpTimerWidget extends StatefulWidget {
  final BoxConstraints constraints;

  const MpTimerWidget({super.key, required this.constraints});

  @override
  State<MpTimerWidget> createState() => _MpTimerWidgetState();
}

class _MpTimerWidgetState extends State<MpTimerWidget> {
 // final TimerController _timerController = Get.find();
  final AnimationsController _animationsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.green,
        width: widget.constraints.maxWidth,
        height: widget.constraints.maxHeight,
        child: SpriteAnimationWidget(
            animation: _animationsController.t20SecTimerAnimation!..currentIndex = _animationsController.t20SecCurrentIndex));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}

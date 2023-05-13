import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class DeductAddAnimation extends StatefulWidget {
  final Color color;

  const DeductAddAnimation({
    super.key,
    required this.color,
  });

  @override
  State<DeductAddAnimation> createState() => DeductAddAnimationState();
}

class DeductAddAnimationState extends State<DeductAddAnimation> {
  var _scale = 0.0;
  var _offset = Offset(0, Get.width * 0.005);
  var _text = '';
  var _scaleDuration = const Duration(milliseconds: 500);
  var _offsetDuration = const Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedScale(
          duration: _scaleDuration,
          scale: _scale,
          child: AnimatedSlide(
            duration: _offsetDuration,
            offset: _offset,
            child: Text(_text,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: widget.color, fontSize: Get.width * 0.015)),
          )),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void triggerAnimation({required String text}) {
    setState(() {
      _text = text;
      _scaleDuration = const Duration(milliseconds: 1000);
      _offsetDuration = const Duration(milliseconds: 1000);
      _scale = 1.0;
      _offset = Offset(Get.width * 0.005, -Get.width * 0.005);
    });

    Future.delayed(const Duration(milliseconds: 1000), resetAnimation);
  }

  void resetAnimation() {
    setState(() {
      _scaleDuration = const Duration(milliseconds: 0);
      _offsetDuration = const Duration(milliseconds: 0);
      _scale = 0.0;
      _offset = Offset(0, Get.width * 0.005);
    });
  }
}

// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/controllers/mp_controller.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/widgets/mainmenu/square_button.dart';
import 'package:nouns_flutter/widgets/multiplayer/mp_input_field.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:nouns_flutter/widgets/multiplayer/round_ranking_popup.dart';
import 'package:nouns_flutter/controllers/timer.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/utils/string_extensions.dart';
import 'package:flutter/animation.dart';

class ScannerWidget extends AnimatedWidget {
  final bool stopped;
  final Animation<double> animation;
  final double maxWidth;
   ScannerWidget(
      {super.key,
      required this.stopped,
      required this.maxWidth,
      required this.animation})
      : super(listenable: animation);
  final Color _color1 = Colors.grey;
  final Color _color2 =  Color.fromARGB(255, 71, 71, 71);

  @override
  Widget build(BuildContext context) {
    final scorePosition = (animation.value * 200) +
        maxWidth; // Here this value can be dynamicallly provided by the widget on top of which its stacked.
    Color color1 = _color1;
    Color color2 = _color2;
    if (animation.status == AnimationStatus.reverse) {
      color1 = _color2;
      color2 = _color1;
    }
    return new Positioned(
        top: 0,
        bottom: 0,
        left: scorePosition,
        child: new LayoutBuilder(
          builder: (context, constraints) {
            return Opacity(
                opacity: (stopped) ? 0.0 : 1.0,
                child: Container(
                  height: constraints.maxHeight, //Gradient Height
                  width: constraints.maxWidth * 0.4,
                  decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    stops: const [0.1, 0.9],
                    colors: [color1, color2],
                  )),
                ));
          },
        ));
  }
}

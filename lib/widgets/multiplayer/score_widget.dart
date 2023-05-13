import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/controllers/mp_controller.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/widgets/mainmenu/square_button.dart';
import 'package:nouns_flutter/widgets/multiplayer/mp_input_field.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:nouns_flutter/widgets/multiplayer/round_ranking_popup.dart';
import 'package:nouns_flutter/controllers/timer.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/utils/string_extensions.dart';

class ScoreWidget extends StatefulWidget {
  final String? score;
  final double fontSizeMultiplier;
  final String category;
  const ScoreWidget(
      {this.score,
      this.category = "",
      super.key,
      required this.fontSizeMultiplier});

  @override
  State<ScoreWidget> createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final MpController _mpController = Get.find();
  final Logger _logger = Get.find();
  var _score = "-";
  var color = primaryColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ScaleTransition(
          scale: _animation,
          child: Container(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(constraints.maxHeight * 0.2),
                    color: color),
                alignment: Alignment.center,
                width: constraints.maxHeight,
                height: constraints.maxHeight,
                padding: EdgeInsets.all(constraints.maxHeight * 0.1),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(widget.score ?? _score,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize:
                              constraints.maxHeight * widget.fontSizeMultiplier,
                          color: whiteColor)),
                ),
              )));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.elasticOut);
    _animationController.animateTo(1,
        duration: const Duration(milliseconds: 0));

    // _mpController.resultsListeners[widget.category] = animateScore;
    //_mpController.roundResultsListenable.stream.takeWhile((element) => element.k).first.then((value) => animateScore());
    _mpController.resultsStreamController.stream.listen((value) {
      if (value.category == widget.category) {
        setState(() {
          _score = value.score.toString();
          color = value.score == 10
              ? Colors.orange
              : value.score == 0
                  ? Colors.red
                  : primaryColor;
          animateScore();
        });
      }
    });
  }

  void animateScore() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _animationController.animateTo(0.2,
          duration: const Duration(milliseconds: 0));
      _animationController.animateTo(1,
          duration: const Duration(milliseconds: 1000));
    });
  }
}

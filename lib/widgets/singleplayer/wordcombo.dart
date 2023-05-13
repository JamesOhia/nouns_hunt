import 'package:flame/widgets.dart';
import 'package:flame_fire_atlas/flame_fire_atlas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/controllers/sp_gameplay.dart';
import 'package:nouns_flutter/utils/audio.dart';

class WordCombo extends StatefulWidget {
  final BoxConstraints constraints;
  FireAtlas spriteAtlas;
  WordCombo({required this.spriteAtlas, required this.constraints, super.key});

  @override
  State<WordCombo> createState() => _WordComboState();
}

class _WordComboState extends State<WordCombo> with TickerProviderStateMixin {
  late AnimationController _wordcomboAnimController;
  late Animation<double> _wordcomboAnimation;

  late AnimationController _wordcomboMultiplierAnimController;
  late Animation<double> _wordcomboMultiplierAnimation;

  Logger logger = Get.find();
  SingleplayerController controller = Get.find();
  var wordComboMultiplier = 'x2';

  @override
  Widget build(BuildContext context) {
    var smallScreen = widget.constraints.maxHeight < 500;

    return Stack(
      alignment: Alignment.topCenter,
      fit: StackFit.expand,
      children: [
        ScaleTransition(
          scale: _wordcomboAnimation,
          child: SpriteWidget(
              anchor: Anchor.center,
              sprite: widget.spriteAtlas.getSprite('wordcombo')),
        ),
        Positioned(
            top: widget.constraints.maxHeight * (smallScreen ? 0.04 : 0.072),
            right: widget.constraints.maxWidth * (smallScreen ? 0.15 : 0.22),
            child: SizedBox(
                width:
                    widget.constraints.maxHeight * (smallScreen ? 0.1 : 0.12),
                height:
                    widget.constraints.maxHeight * (smallScreen ? 0.1 : 0.1),
                child: Container(
                  child: ScaleTransition(
                      scale: _wordcomboMultiplierAnimation,
                      child: SpriteWidget(
                          anchor: Anchor.center,
                          sprite: widget.spriteAtlas
                              .getSprite(wordComboMultiplier))),
                ))),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    //wordcombo sprite
    _wordcomboAnimController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _wordcomboAnimation = CurvedAnimation(
        parent: _wordcomboAnimController, curve: Curves.elasticOut);
    _wordcomboAnimController.animateTo(0,
        duration: const Duration(milliseconds: 2000));

    //multiplier
    _wordcomboMultiplierAnimController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _wordcomboMultiplierAnimation = CurvedAnimation(
        parent: _wordcomboMultiplierAnimController, curve: Curves.elasticOut);
    _wordcomboMultiplierAnimController.animateTo(0,
        duration: const Duration(milliseconds: 2000));

    controller.setWordcomboListener((multiplier) {
      setState(
        () {
          wordComboMultiplier = multiplier > 1 ? "x$multiplier" : "x2";
          if (multiplier > 10) {
            wordComboMultiplier = "x10";
          }
          logger.i("Wordcombo multiplier $wordComboMultiplier");

          switch (multiplier) {
            case 1:
              print("case 1");
              _wordcomboAnimController.animateTo(0,
                  duration: const Duration(milliseconds: 1000));
              _wordcomboMultiplierAnimController.animateTo(0,
                  duration: const Duration(milliseconds: 1000));
              break;
            case 2:
              print("case 2");
              _wordcomboAnimController.animateTo(1,
                  duration: const Duration(milliseconds: 1000));
              _wordcomboMultiplierAnimController.animateTo(1,
                  duration: const Duration(milliseconds: 1000));
              playWordComboSound();
              break;
            default:
              print("case above 2");
              _wordcomboMultiplierAnimController.animateTo(0,
                  duration: const Duration(milliseconds: 0));
              _wordcomboMultiplierAnimController.animateTo(1,
                  duration: const Duration(milliseconds: 500));
              playSustainedComboSound();
          }
        },
      );
    });
  }

  @override
  void dispose() {
    _wordcomboAnimController.dispose();
    super.dispose();
  }
}

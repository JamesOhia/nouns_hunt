import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nouns_flutter/widgets/common/sprite_sheet_widget_flame.dart';
import 'package:nouns_flutter/widgets/common/sprite_sheet_animation.dart';

class LifeLineBtn extends StatefulWidget {
  final SpriteAnimation spriteAnimation;
  final String lifelineIconPath;
  final String currencyIconPath;
  final int currencyAmount;
  final void Function() onPressed;
  final BoxConstraints constraints;

  final int? limit;

  const LifeLineBtn({
    super.key,
    required this.spriteAnimation,
    required this.lifelineIconPath,
    required this.currencyIconPath,
    required this.currencyAmount,
    required this.onPressed,
    required this.constraints,
    this.limit,
  });

  @override
  State<LifeLineBtn> createState() => _LifeLineBtnState();
}

class _LifeLineBtnState extends State<LifeLineBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  var smallScreen = false;

  @override
  Widget build(BuildContext context) {
    smallScreen = widget.constraints.maxHeight < 500;

    return ScaleTransition(
      scale: _animation,
      child: InkWell(
        onTap:
            (widget.limit != null && widget.limit! > 0) || widget.limit == null
                ? () {
                    setState(() {
                      _animationController.animateTo(0.2,
                          duration: const Duration(milliseconds: 0));
                      _animationController.animateTo(1,
                          duration: const Duration(milliseconds: 1000));
                    });

                    widget.onPressed();
                  }
                : null,
        child: Container(
          width: widget.constraints.maxHeight * (smallScreen ? 0.15 : 0.10),
          height: widget.constraints.maxHeight * (smallScreen ? 0.15 : 0.10),
          padding: const EdgeInsets.all(3),
          child: Stack(clipBehavior: Clip.none, children: [
            Positioned.fill(
                child:
                    SpriteAnimationWidget(animation: widget.spriteAnimation)),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                widget.currencyIconPath,
                width: widget.constraints.maxHeight *
                    (smallScreen ? 0.055 : 0.035),
              ),
            ),
            Positioned(
                bottom: 2,
                right: 0,
                child: CircleAvatar(
                  radius: widget.constraints.maxHeight *
                      (smallScreen ? 0.02 : 0.01),
                  backgroundColor: Colors.white,
                  child: Text(
                    widget.currencyAmount.toString(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: widget.constraints.maxHeight *
                            (smallScreen ? 0.02 : 0.01)),
                  ),
                )),
            widget.limit != null
                ? Positioned(
                    top: widget.constraints.maxHeight * 0.005,
                    left: widget.constraints.maxHeight * 0.005,
                    child: CircleAvatar(
                      radius: widget.constraints.maxHeight *
                          (smallScreen ? 0.02 : 0.01),
                      backgroundColor: Colors.red[200],
                      child: Text(
                        widget.limit.toString(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: widget.constraints.maxHeight *
                                (smallScreen ? 0.02 : 0.01)),
                      ),
                    ))
                : Container()
          ]),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.elasticOut);

    _animationController.animateTo(1,
        duration: const Duration(milliseconds: 0));
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/widgets/mainmenu/rectangle_button.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/five_star_input.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/mp_categories_listview.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/mp_waitingroom_listview.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/rounds_input.dart';
import 'package:nouns_flutter/controllers/mp_controller.dart';
import 'package:nouns_flutter/widgets/common/svg_widget.dart';

class LongPressButton extends StatefulWidget {
  final Color color;
  final VoidCallback? onLongpress;
  final VoidCallback? onBeginLongpress;
  final VoidCallback? onCancelLongPress;
  final Widget child;
  final bool disabled;

  LongPressButton(
      {super.key,
      required this.disabled,
      required this.child,
      required this.color,
      this.onLongpress,
      this.onBeginLongpress,
      this.onCancelLongPress});

  @override
  State<LongPressButton> createState() => _LongPressButtonState();
}

class _LongPressButtonState extends State<LongPressButton>
    with SingleTickerProviderStateMixin {
  final int _longpressDuration = 2500; //milliseconds
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
          onTapUp: widget.disabled
              ? null
              : (details) {
                  print("finger up");

                  _controller.reverse();
                  widget.onCancelLongPress?.call();
                },
          onTapDown: widget.disabled
              ? null
              : (details) {
                  print("finger down");

                  _controller.forward();
                  widget.onBeginLongpress?.call();
                },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(child: widget.child),
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      child: CircularProgressIndicator(
                        color: widget.color,
                        value: _animation.value,
                        strokeWidth: 5,
                      ),
                    );
                  },
                ),
              )
            ],
          ));
    });
  }

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: _longpressDuration),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        triggerLongpressAction();
        _controller.reset();
      }
    });
  }

  void triggerLongpressAction() {
    widget.onLongpress?.call();
  }
}

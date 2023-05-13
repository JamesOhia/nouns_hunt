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
import 'package:nouns_flutter/widgets/multiplayer/long_press_button.dart';

class AlphabetSelector extends StatefulWidget {
  final String alphabet;

  const AlphabetSelector({
    super.key,
    required this.alphabet,
  });

  @override
  State<AlphabetSelector> createState() => _AlphabetSelectorState();
}

class _AlphabetSelectorState extends State<AlphabetSelector>
    with SingleTickerProviderStateMixin {
  final MpController _mpController = Get.find();
  final UserController _userController = Get.find();
  var scale = 0.0;
  var animationDuration = const Duration(milliseconds: 1500);
  late Timer _selectAlphabetTimer;
  int durationTapped = 0; //milliseconds
  late Timer _durationHeldTimer;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          var tapped = _mpController.tappedAlphabet == widget.alphabet;
          var disabled = (_mpController.selectedAlphabets
                  .contains(widget.alphabet)) ||
              (_mpController.userSelectingAlphabet != _userController.username);

          return LongPressButton(
            disabled: disabled,
            // GestureDetector(
            //   onTap: disabled
            //       ? null
            //       : () {
            //           _mpController.alphabetRandomizationTimer?.cancel();
            //         },
            //   onTapDown: disabled
            //       ? null
            //       : (details) {
            //           _mpController.tappedAlphabet = widget.alphabet;
            //           _mpController.alphabetRandomizationTimer?.cancel();
            //           print("begin presss");
            //           durationTapped = 0;
            //           _durationHeldTimer =
            //               Timer.periodic(Duration(milliseconds: 100), (timer) {
            //             durationTapped += 100;
            //           });

            //           setState(() {
            //             animationDuration = const Duration(milliseconds: 100);
            //             scale = 1;
            //             _selectAlphabetTimer =
            //                 Timer(const Duration(milliseconds: 1500), () {
            //               _mpController.selectedAlphabet = widget.alphabet;
            //             });

            //             print('just after setstate');
            //           });
            //         },
            //   onTapUp: disabled
            //       ? null
            //       : (details) {
            //           print("tap up");
            //           if (durationTapped < 1500) {
            //             print("cancel lonmg presss");
            //             _selectAlphabetTimer.cancel();
            //             _durationHeldTimer.cancel();

            //             setState(() {
            //               animationDuration = const Duration(milliseconds: 250);
            //               scale = 0;
            //               _selectAlphabetTimer.cancel();
            //             });
            //           }
            //         },
            color: primaryColor,
            onBeginLongpress: () {
              _mpController.tappedAlphabet = widget.alphabet;
            },
            onCancelLongPress: () {
              _mpController.alphabetRandomizationTimer?.cancel();
            },
            onLongpress: () {
              _mpController.alphabetRandomizationTimer?.cancel();
              _mpController.selectedAlphabet = widget.alphabet;
            },
            child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight * 0.07,
                    horizontal: constraints.maxWidth * 0.07),
                alignment: Alignment.center,
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedScale(
                      curve: Curves.bounceIn,
                      duration: animationDuration,
                      scale: 1,
                      child: Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: tapped ? primaryColor : Colors.transparent),
                      ),
                    ),
                    Text(widget.alphabet,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: constraints.maxWidth * 0.4,
                            color: tapped
                                ? whiteColor
                                : disabled
                                    ? Colors.grey[500]!
                                    : primaryColor))
                  ],
                )),
          );
        });
      },
    );
  }

  @override
  initState() {
    super.initState();
  }
}

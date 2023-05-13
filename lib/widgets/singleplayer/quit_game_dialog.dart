import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/widgets/mainmenu/rectangle_button.dart';
import 'package:nouns_flutter/utils/audio.dart';
import 'package:nouns_flutter/controllers/timer.dart';

class QuitGameDialog extends StatefulWidget {
  final void Function() quitGame;
  const QuitGameDialog({super.key, required this.quitGame});

  @override
  State<QuitGameDialog> createState() => QuitGameDialogState();
}

class QuitGameDialogState extends State<QuitGameDialog> {
  var _scale = 0.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AnimatedScale(
          scale: _scale,
          curve: Curves.bounceInOut,
          duration: const Duration(milliseconds: 500),
          child: Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(constraints.maxWidth * 0.05),
              ),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  height: constraints.maxHeight * 0.25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: lightGreyTextColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(constraints.maxWidth * 0.05),
                        topRight: Radius.circular(constraints.maxWidth * 0.05)),
                  ),
                  child: Text(
                    "Quit",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: constraints.maxHeight * 0.06),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.1,
                      horizontal: constraints.maxWidth * 0.1),
                  child: Text(
                      "Are you sure you want to quit? All progress will be lost",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: constraints.maxHeight * 0.06,
                          color: darkGreyTextColor)),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      // vertical: constraints.maxHeight * 0.1,
                      horizontal: constraints.maxWidth * 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RectangleButton(
                          bgImage: "assets/images/MainMenu/red_scaled.png",
                          label: 'Yes',
                          onPressed: widget.quitGame,
                          locked: false,
                          width: constraints.maxWidth * 0.35,
                          height: constraints.maxWidth * 0.15,
                          textColor: redColor),
                      RectangleButton(
                          bgImage: "assets/images/MainMenu/green_scaled.png",
                          label: 'No',
                          onPressed: dismissDialog,
                          locked: false,
                          width: constraints.maxWidth * 0.35,
                          height: constraints.maxWidth * 0.15,
                          textColor: greenColor)
                    ],
                  ),
                )
              ]),
            ),
          ));
    });
  }

  void dismissDialog() {
    setState(() {
      _scale = 0.0;
    });
  }

  void showDialog() {
    setState(() {
      _scale = 1.0;
    });
  }
}

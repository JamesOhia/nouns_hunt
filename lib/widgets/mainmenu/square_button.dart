import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/utils/audio.dart';

class SquareButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final void Function() onPressed;
  final bool locked;

  const SquareButton(
      {super.key,
      required this.label,
      required this.onPressed,
      required this.locked,
      required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
        playButtonClickSound();
      },
      child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            PhysicalModel(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              elevation: 3,
              child: Container(
                width: Get.height * 0.09,
                height: Get.height * 0.09,
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      iconPath,
                      width: Get.height * 0.055,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 7),
                      child: Text(label.toUpperCase(),
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: darkGreyTextColor,
                                    fontSize: Get.height * 0.0075,
                                  )),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                right: -2,
                child: locked
                    ? Image.asset(
                        "assets/images/MainMenu/Icon_ColorIcon_Lock01.png",
                        width: 16,
                      )
                    : Container())
          ]),
    );
  }
}

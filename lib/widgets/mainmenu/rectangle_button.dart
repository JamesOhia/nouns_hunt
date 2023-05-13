import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/utils/audio.dart';

class RectangleButton extends StatelessWidget {
  final String? bgImage;
  final Color? bgColor;
  Color textColor;
  final String? label;
  final Widget? child;
  final void Function()? onPressed;
  final bool locked;
  final double width;
  final double height;
  final bool loading;

  RectangleButton(
      {super.key,
      this.bgColor,
      this.textColor = Colors.grey,
      this.label,
      this.child,
      required this.onPressed,
      required this.locked,
      required this.width,
      required this.height,
      this.loading = false,
      this.bgImage}) {
    if (locked) {
      textColor = darkGreyTextColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        elevation: 6,
        child: InkWell(
          onTap: () {
            if (onPressed != null) {
              onPressed!();
              playButtonClickSound();
            }
          },
          child: Container(
              width: width,
              height: height,
              child: Stack(clipBehavior: Clip.none, children: [
                Positioned.fill(
                    child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Get.width * 0.03),
                    color: bgColor,
                  ),
                  alignment: Alignment.center,
                  child: bgImage == null
                      ? Container()
                      : Image.asset(
                          bgImage!,
                          fit: BoxFit.fill,
                          width: width,
                          height: height,
                        ),
                )),
                Positioned.fill(
                    child: Center(
                        child: loading
                            ? Container(
                                width: height * 0.3,
                                height: height * 0.3,
                                child: const CircularProgressIndicator())
                            : label != null
                                ? Text(label!,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: textColor,
                                          fontSize: width * 0.07,
                                        ))
                                : child)),
                Positioned(
                    bottom: -width * 0.04,
                    right: -width * 0.04,
                    child: locked
                        ? Image.asset(
                            "assets/images/MainMenu/Icon_ColorIcon_Lock01.png",
                            width: width * 0.11,
                          )
                        : Container())
              ])),
        ));
  }
}

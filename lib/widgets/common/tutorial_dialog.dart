import 'package:nouns_flutter/widgets/common/tutorial_dialog_painter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TutorialDialog extends StatefulWidget {
  final String icon;
  final String title;
  final Widget content;
  final double heightMultiplier;
  const TutorialDialog(
      {required this.icon,
      required this.title,
      required this.content,
      required this.heightMultiplier,
      super.key});

  @override
  State<TutorialDialog> createState() => _TutorialDialogState();
}

class _TutorialDialogState extends State<TutorialDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var width = constraints.maxWidth;
      var height = width * widget.heightMultiplier;
      return Container(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Transform.translate(
                offset: Offset(width * 0.03, -width * 0.25),
                child: CustomPaint(
                    size: Size(width, height),
                    painter: TutorialDialogPainter())),
            Container(child: Image.asset(widget.icon, width: 50)),
            Container(
                margin: EdgeInsets.only(top: height * 0.1),
                child: Text(
                  widget.title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: Get.width * 0.04),
                )),
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    margin: EdgeInsets.only(top: height * 0.17),
                    child: widget.content);
              },
            ),
          ],
        ),
      );
    });
  }
}

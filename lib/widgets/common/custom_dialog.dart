import 'package:nouns_flutter/widgets/common/custom_dialog_painter.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final String icon;
  final String title;
  final Widget content;
  final double heightMultiplier;
  final double? titleSize;
  const CustomDialog(
      {required this.icon,
      required this.title,
      required this.content,
      required this.heightMultiplier,
      this.titleSize,
      super.key});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.8;
    var height = width * widget.heightMultiplier;

    return Container(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Transform.translate(
              offset: Offset(-(width / 16), -(height / 4)),
              child: CustomPaint(
                  size: Size(width, height), painter: CustomDialogPainter())),
          Container(child: Image.asset(widget.icon, width: 50)),
          Container(
              margin: EdgeInsets.only(top: 80),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: widget.titleSize ?? height * 0.08),
              )),
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  margin: EdgeInsets.only(top: 130, left: 50, right: 50),
                  child: widget.content);
            },
          ),
        ],
      ),
    );
  }
}

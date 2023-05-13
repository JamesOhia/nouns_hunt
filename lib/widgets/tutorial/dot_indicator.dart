import 'package:flutter/material.dart';
import 'package:nouns_flutter/pallette.dart';

class DotIndicator extends StatefulWidget {
  final bool active;
  final double width;
  const DotIndicator({super.key, required this.active, required this.width});

  @override
  State<DotIndicator> createState() => _DotIndicatorState();
}

class _DotIndicatorState extends State<DotIndicator> {
  @override
  Widget build(BuildContext context) {
    return widget.active
        ? Container(
            width: widget.width,
            height: widget.width,
            decoration: BoxDecoration(
              color: darkGreyTextColor,
              shape: BoxShape.circle,
            ),
          )
        : Container(
            decoration: const BoxDecoration(
                //color: whiteColor,
                shape: BoxShape.circle,
                border: Border.fromBorderSide(BorderSide(color: whiteColor))),
            padding: EdgeInsets.all(widget.width * 0.2),
            child: Container(
              width: widget.width,
              height: widget.width,
              decoration: const BoxDecoration(
                color: whiteColor,
                shape: BoxShape.circle,
              ),
            ),
          );
  }
}

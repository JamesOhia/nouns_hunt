import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jovial_svg/jovial_svg.dart';

class SvgWidget extends StatelessWidget {
  final double width;
  final double height;
  final String image;
  final BoxFit fit;
  const SvgWidget(
      {super.key,
      this.fit = BoxFit.contain,
      required this.width,
      required this.height,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ScalableImageWidget.fromSISource(
          fit: fit,
          background: null,
          si: ScalableImageSource.fromSvg(rootBundle, image)),
    );
  }
}

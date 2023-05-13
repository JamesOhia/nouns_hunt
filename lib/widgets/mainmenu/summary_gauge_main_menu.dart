import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class SummaryGauge extends StatelessWidget {
  final Color color;
  final double width;
  final double height;
  SummaryGauge({
    super.key,
    required this.color,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        size: Size(width, height),
        painter: SummaryGaugePainter(color),
      ),
    );
  }
}

class SummaryGaugePainter extends CustomPainter {
  final Color color;
  SummaryGaugePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.4103774, size.height * 1.327206);
    path_0.cubicTo(
        size.width * 0.4103774,
        size.height * 1.327206,
        size.width * 0.5490145,
        size.height * 1.315059,
        size.width * 0.6172433,
        size.height * 1.358279);
    path_0.cubicTo(
        size.width * 0.6210241,
        size.height * 1.360674,
        size.width * 0.6237504,
        size.height * 1.359907,
        size.width * 0.6273240,
        size.height * 1.365089);
    path_0.cubicTo(
        size.width * 0.6305190,
        size.height * 1.369721,
        size.width * 0.6336248,
        size.height * 1.375166,
        size.width * 0.6367537,
        size.height * 1.380386);
    path_0.cubicTo(
        size.width * 0.6418579,
        size.height * 1.388901,
        size.width * 0.6474275,
        size.height * 1.394500,
        size.width * 0.6519949,
        size.height * 1.406518);
    path_0.cubicTo(
        size.width * 0.6611485,
        size.height * 1.430603,
        size.width * 0.6711325,
        size.height * 1.457721,
        size.width * 0.6754470,
        size.height * 1.496229);
    path_0.cubicTo(
        size.width * 0.6814353,
        size.height * 1.549676,
        size.width * 0.6798121,
        size.height * 1.613501,
        size.width * 0.6763090,
        size.height * 1.669922);
    path_0.cubicTo(
        size.width * 0.6660189,
        size.height * 1.835654,
        size.width * 0.6442884,
        size.height * 1.997256,
        size.width * 0.6138888,
        size.height * 2.124269);
    path_0.cubicTo(
        size.width * 0.5980876,
        size.height * 2.190288,
        size.width * 0.5758204,
        size.height * 2.231716,
        size.width * 0.5545935,
        size.height * 2.271408);
    path_0.cubicTo(
        size.width * 0.5445047,
        size.height * 2.290273,
        size.width * 0.5338314,
        size.height * 2.306873,
        size.width * 0.5226961,
        size.height * 2.313817);
    path_0.cubicTo(
        size.width * 0.4872116,
        size.height * 2.335946,
        size.width * 0.4164164,
        size.height * 2.320204,
        size.width * 0.4164164,
        size.height * 2.320204);
    path_0.lineTo(size.width * -0.3205570, size.height * 2.309865);
    path_0.cubicTo(
        size.width * -0.3173967,
        size.height * 1.978542,
        size.width * -0.3220938,
        size.height * 1.638027,
        size.width * -0.3191956,
        size.height * 1.331283);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xffffffff).withOpacity(1);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

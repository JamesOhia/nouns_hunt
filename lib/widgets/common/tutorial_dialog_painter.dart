import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

//Copy this CustomPainter code to the Bottom of the File
class TutorialDialogPainter extends CustomPainter {
  final Color color;
  TutorialDialogPainter({this.color = Colors.white});

  Logger logger = Get.find();
  @override
  void paint(Canvas canvas, Size size) {
    logger.d("found size", size);
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8890690, size.height * 0.2211556);
    path_0.lineTo(size.width * 0.8901587, size.height * 1.129924);
    path_0.cubicTo(
        size.width * 0.6743404,
        size.height * 1.129585,
        size.width * 0.4400629,
        size.height * 1.130448,
        size.width * 0.05833655,
        size.height * 1.130532);
    path_0.lineTo(size.width * 0.06155368, size.height * 0.2248717);
    path_0.cubicTo(
        size.width * 0.06161875,
        size.height * 0.2065564,
        size.width * 0.09300397,
        size.height * 0.1917245,
        size.width * 0.1317999,
        size.height * 0.1917370);
    path_0.cubicTo(
        size.width * 0.1461851,
        size.height * 0.1917414,
        size.width * 0.1605703,
        size.height * 0.1917459,
        size.width * 0.1749555,
        size.height * 0.1917505);
    path_0.cubicTo(
        size.width * 0.2059180,
        size.height * 0.1567151,
        size.width * 0.3269073,
        size.height * 0.1305320,
        size.width * 0.4714796,
        size.height * 0.1305320);
    path_0.cubicTo(
        size.width * 0.6162236,
        size.height * 0.1305320,
        size.width * 0.7363752,
        size.height * 0.1528882,
        size.width * 0.7667755,
        size.height * 0.1879239);
    path_0.lineTo(size.width * 0.8407922, size.height * 0.1895608);
    path_0.cubicTo(
        size.width * 0.8797610,
        size.height * 0.1904227,
        size.width * 0.8890690,
        size.height * 0.2189995,
        size.width * 0.8890690,
        size.height * 0.2211556);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color;
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


// CustomPaint(
//     size: Size(WIDTH, (WIDTH*2.118211167834647).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
//     painter: TutorialDialogPainter(),
// )
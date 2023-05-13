import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

//Copy this CustomPainter code to the Bottom of the File
class CustomDialogPainter extends CustomPainter {
  final Color color;
  CustomDialogPainter({this.color = Colors.white});

  Logger logger = Get.find();
  @override
  void paint(Canvas canvas, Size size) {
    logger.d("found size", size);
    Path path_0 = Path();
    path_0.moveTo(size.width * 1.074298, size.height * 0.5249382);
    path_0.lineTo(size.width * 1.074298, size.height * 1.231808);
    path_0.arcToPoint(Offset(size.width * 0.9946435, size.height * 1.304478),
        radius: Radius.elliptical(
            size.width * 0.07965465, size.height * 0.07267034),
        rotation: 135,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.1608789, size.height * 1.304478);
    path_0.arcToPoint(Offset(size.width * 0.07429815, size.height * 1.225489),
        radius: Radius.elliptical(
            size.width * 0.08658074, size.height * 0.07898913),
        rotation: 45,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.07429815, size.height * 0.5245346);
    path_0.cubicTo(
        size.width * 0.07429815,
        size.height * 0.4818121,
        size.width * 0.1122601,
        size.height * 0.4472156,
        size.width * 0.1590886,
        size.height * 0.4472446);
    path_0.cubicTo(
        size.width * 0.1764522,
        size.height * 0.4472550,
        size.width * 0.1938158,
        size.height * 0.4472654,
        size.width * 0.2111794,
        size.height * 0.4472763);
    path_0.cubicTo(
        size.width * 0.2485526,
        size.height * 0.3655529,
        size.width * 0.3945922,
        size.height * 0.3044783,
        size.width * 0.5690977,
        size.height * 0.3044783);
    path_0.cubicTo(
        size.width * 0.7438105,
        size.height * 0.3044783,
        size.width * 0.8899897,
        size.height * 0.3656980,
        size.width * 0.9266843,
        size.height * 0.4474221);
    path_0.cubicTo(
        size.width * 0.9474780,
        size.height * 0.4473878,
        size.width * 0.9682717,
        size.height * 0.4473535,
        size.width * 0.9890654,
        size.height * 0.4473193);
    path_0.cubicTo(
        size.width * 1.036138,
        size.height * 0.4472417,
        size.width * 1.074298,
        size.height * 0.4819929,
        size.width * 1.074298,
        size.height * 0.5249382);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color;
    canvas.drawShadow(path_0, Colors.grey.withAlpha(100), 4.0, false);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PlusButton extends StatelessWidget {
  final Color darkColor;
  final Color lightColor;
  final void Function() onPressed;

  const PlusButton(
      {required this.darkColor,
      required this.lightColor,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        //padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: lightColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Icon(
          Icons.add,
          color: darkColor,
          size: 15,
        ),
      ),
    );
  }
}

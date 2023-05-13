import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:nouns_flutter/widgets/common/svg_widget.dart';

class StarInput extends StatelessWidget {
  final int currentValue;
  final int maxValue;
  final void Function(int newValue) updateValue;
  final bool locked;
  const StarInput(
      {super.key,
      required this.currentValue,
      required this.updateValue,
      required this.maxValue,
      required this.locked});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(maxValue, (index) => index + 1)
                  .map((i) => InkWell(
                        onTap: () {
                          if (!locked) {
                            updateValue(i);
                          }
                        },
                        child: Icon(Icons.star,
                            size: constraints.maxHeight * 0.65,
                            color:
                                i <= currentValue ? orangeColor : Colors.grey),
                      ))
                  .toList()));
    });
  }
}

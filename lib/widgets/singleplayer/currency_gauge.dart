import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/widgets/singleplayer/plus_button.dart';

class CurrencyGauge extends StatelessWidget {
  final String imageUrl;
  final int amount;
  final Color darkColor;
  final Color lightColor;
  final void Function() onPressed;
  final double iconSize;
  final Offset currencyIconoffset;
  final bool locked;

  const CurrencyGauge(
      {this.locked = false,
      required this.imageUrl,
      required this.amount,
      required this.darkColor,
      required this.lightColor,
      required this.onPressed,
      required this.currencyIconoffset,
      required this.iconSize,
      super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        alignment: Alignment.centerRight,
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        //color: Colors.yellow,
        child: Stack(children: [
          Card(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2,
            child: Container(
              padding: EdgeInsets.all(constraints.maxHeight * 0.01),
              width: MediaQuery.of(context).size.width * 0.22,
              height: constraints.maxHeight * 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(right: constraints.maxWidth * 0.03),
                    child: Text(
                      amount.toString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: darkColor,
                          fontSize: constraints.maxHeight * 0.28),
                    ),
                  ),
                  locked
                      ? Container()
                      : PlusButton(
                          darkColor: darkColor,
                          lightColor: lightColor,
                          onPressed: onPressed),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: Transform.translate(
              offset: currencyIconoffset,
              child: Image.asset(
                imageUrl,
                width: iconSize,
              ),
            ),
          ),
        ]),
      );
    });
  }
}

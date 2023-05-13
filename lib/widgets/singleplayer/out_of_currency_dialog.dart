import 'package:flutter/material.dart';
import 'package:nouns_flutter/pallette.dart';

class OutOfCurrencyDialog extends StatefulWidget {
  const OutOfCurrencyDialog({
    super.key,
  });

  @override
  State<OutOfCurrencyDialog> createState() => OutOfCurrencyDialogState();
}

class OutOfCurrencyDialogState extends State<OutOfCurrencyDialog> {
  var _title = "";
  var _message = "";
  var _scale = 0.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AnimatedScale(
          scale: _scale,
          curve: Curves.bounceInOut,
          duration: const Duration(milliseconds: 500),
          child: Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(constraints.maxWidth * 0.05),
              ),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  height: constraints.maxHeight * 0.25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: lightGreyTextColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(constraints.maxWidth * 0.05),
                        topRight: Radius.circular(constraints.maxWidth * 0.05)),
                  ),
                  child: Text(
                    _title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: constraints.maxHeight * 0.06),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.1,
                      horizontal: constraints.maxWidth * 0.1),
                  child: Text(_message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: constraints.maxHeight * 0.06,
                          color: darkGreyTextColor)),
                ),
                Container(
                  child: ElevatedButton(
                      onPressed: dismissDialog, child: const Text('OK')),
                )
              ]),
            ),
          ));
    });
  }

  void dismissDialog() {
    setState(() {
      _scale = 0.0;
    });
  }

  void showDialog({required String title, required String message}) {
    print("out of currency dialog");
    setState(() {
      _message = message;
      _title = title;
      _scale = 1;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/controllers/mp_controller.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/widgets/multiplayer/long_press_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/pallette.dart';

class BtnStopRound extends StatefulWidget {
  final void Function() stopRound;
  const BtnStopRound({super.key, required this.stopRound});

  @override
  State<BtnStopRound> createState() => _BtnStopRoundState();
}

class _BtnStopRoundState extends State<BtnStopRound> {
  //final TimerController _timerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          // color: Colors.green,
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Obx(() {
                var isStopEnabled = Get.find<MpController>().canStopRoundNow;
                return Container(
                  width: constraints.maxWidth * 0.8,
                  height: constraints.maxHeight * 0.8,
                  child: LongPressButton(
                    disabled: !isStopEnabled,
                    color: Colors.red,
                    onLongpress:
                        isStopEnabled //todo check currentIndex of timer
                            ? widget.stopRound
                            : null,
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isStopEnabled ? Colors.red : Colors.grey,
                          // borderRadius: BorderRadius.circular(
                          //     constraints.maxHeight * 0.1)
                        ),
                        child: Text('STOP',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: constraints.maxHeight * 0.15,
                                    color: whiteColor))),
                  ),
                );
              }),
              // Obx(() {
              //   var isStopEnabled = Get.find<MpController>().canStopRoundNow;

              //   return Container(
              //     margin: EdgeInsets.only(top: constraints.maxHeight * 0.05),
              //     child: Text(
              //       'Hold to stop',
              //       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              //             fontSize: constraints.maxHeight * 0.1,
              //             color: isStopEnabled ? Colors.red : Colors.grey,
              //           ),
              //     ),
              //   );
              // })
            ],
          ),
        );
      },
    );
  }
}

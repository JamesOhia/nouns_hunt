import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:nouns_flutter/widgets/common/svg_widget.dart';

class MpRoundsInput extends StatelessWidget {
  final bool locked;
  MpRoundsInput({
    super.key,
    required this.locked,
  });

  final MpSetupController _mpSetupController = Get.find();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (cotext, constraints) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.03),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              locked
                  ? Container()
                  : InkWell(
                      onTap: _mpSetupController.roundsMinus,
                      child: SvgWidget(
                          width: constraints.maxHeight * 0.8,
                          height: constraints.maxHeight * 0.8,
                          image: "assets/images/multiplayer/minus_button.svg")),
              Expanded(
                  child: Obx(() => Text(_mpSetupController.rounds.toString(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: primaryColor, fontSize: Get.width * 0.03)))),
              locked
                  ? Container()
                  : InkWell(
                      onTap: _mpSetupController.roundsPlus,
                      child: SvgWidget(
                          width: constraints.maxHeight * 0.8,
                          height: constraints.maxHeight * 0.8,
                          image: "assets/images/multiplayer/plus_button.svg"))
            ]),
      );
    });
  }
}

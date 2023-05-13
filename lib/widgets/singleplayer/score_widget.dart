import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/controllers/mp_controller.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/controllers/sp_gameplay.dart';

class SpScoreWidget extends StatelessWidget {
  final BoxConstraints constraints;
  final bool multiplayer;
  SpScoreWidget(
      {super.key, required this.constraints, this.multiplayer = false});

  SingleplayerController _spController = Get.find();
  MpController _mpController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() => _spController.isHighscore
            ? Transform.translate(
                offset: Offset(-45 / 100 * constraints.maxWidth,
                    -5 / 100 * constraints.maxHeight),
                child: Image.asset(
                  "assets/images/SinglePlayer/high_score_indicator.png",
                  height: 10,
                ))
            : Container(
                height: 10,
              )),
        Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.only(bottom: 10),
          elevation: 3,
          child: Container(
            alignment: Alignment.centerLeft,
            width: constraints.maxWidth * 0.3,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Transform.translate(
                offset: Offset(constraints.maxWidth * 0.1, 0),
                child: Text("Score",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 0.02 * constraints.maxHeight))),
          ),
        ),
        Transform.translate(
          offset: Offset(constraints.maxWidth * 0.0, 0),
          child: Obx(() => Text(
                multiplayer
                    ? (_mpController.score).toString()
                    : _spController.score.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 0.05 * constraints.maxHeight),
              )),
        )
      ],
    );
  }
}

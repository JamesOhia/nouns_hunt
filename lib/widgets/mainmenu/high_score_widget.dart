import 'package:flutter/material.dart';
import 'package:nouns_flutter/controllers/leaderboards_controller.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';

class HighScoreWidget extends StatelessWidget {
  HighScoreWidget({super.key});
  UserController _userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 50,
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          LayoutBuilder(builder: (context, constraints) {
            return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
                width: constraints.maxHeight * 1.1,
                height: constraints.maxHeight,
                child: Image.asset(
                    "assets/images/MainMenu/Icon_ColorIcon_Trophy01.png"));
          }),
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('High Score',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: 9, color: darkGreyTextColor)),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Obx(() => Text(
                              Get.find<LeaderboardsController>()
                                  .currentUserRecord!
                                  .score
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 14,
                                  ))),
                        )
                      ])))
        ]));
  }
}

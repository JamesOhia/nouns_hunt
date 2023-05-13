import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/widgets/mainmenu/summary_gauge_main_menu.dart';
import 'package:nouns_flutter/widgets/mainmenu/avatar_widget.dart';

class UserSummary extends StatelessWidget {
  final double width;
  final double? height;
  UserSummary({required this.width, this.height, super.key});

  final Logger _logger = Get.find();
  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: width * 0.3,
        child: Stack(children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                margin: const EdgeInsets.only(bottom: 2, left: 45),
                padding: const EdgeInsets.all(2),
                width: width,
                height: 12,
                decoration: const BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(20))),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(20))),
                    child: Stack(children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              width: width *
                                  _userController.xp /
                                  _userController.maxXp,
                              height: 10,
                              decoration: const BoxDecoration(
                                  color: greenColor,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(20))))),
                      Align(
                          alignment: Alignment.center,
                          child: Obx(() => Text(
                              "${_userController.xp} / ${_userController.maxXp}",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 6, color: whiteColor))))
                    ]))), //level slider
            Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(20))),
                width: width * 0.7,
                height: 12,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 12),
                  child: Obx(() => Text(_userController.username,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 6))),
                )) //username
          ]),
          AvatarWidget(width: 50, height: 50), //avatar
          //level number
        ]));
  }
}

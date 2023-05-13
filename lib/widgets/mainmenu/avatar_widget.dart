import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/pallette.dart';

class AvatarWidget extends StatelessWidget {
  final double width;
  final double height;

  AvatarWidget({required this.width, required this.height, super.key});
  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        alignment: Alignment.bottomRight,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1, color: whiteColor),
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                    "assets/images/Avatars/${_userController.avatar}.png"))),
        child: Container(
            alignment: Alignment.center,
            width: width * 0.3,
            height: width * 0.3,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: blueColor, borderRadius: BorderRadius.circular(8)),
            child: Text(_userController.level,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: width * 0.1, color: whiteColor))));
  }
}

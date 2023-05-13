import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/controllers/initialize_user.dart';
import 'package:nouns_flutter/pallette.dart';

class AvatarSelector extends StatefulWidget {
  final String avatarKey;
  const AvatarSelector({required this.avatarKey, super.key});

  @override
  State<AvatarSelector> createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  final InitializeUserController _initializeUserController = Get.find();
  var selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _initializeUserController.selectedAvatar = widget.avatarKey;
      },
      child: Obx(() => AnimatedSwitcher(
          duration: const Duration(milliseconds: 2000),
          child: widget.avatarKey == _initializeUserController.selectedAvatar
              ? Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: lightPupleColor, width: 2),
                  ),
                  child: Image.asset(
                      "assets/images/Avatars/${widget.avatarKey}_active.png"))
              : Container(
                  child: Image.asset(
                      "assets/images/Avatars/${widget.avatarKey}.png")))),
    );
  }
}

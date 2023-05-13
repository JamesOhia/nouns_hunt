import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/controllers/initialize_user.dart';
import 'package:nouns_flutter/pallette.dart';

class CharacterSelector extends StatefulWidget {
  final String characterName;
  const CharacterSelector({required this.characterName, super.key});

  @override
  State<CharacterSelector> createState() => _CharacterSelectorState();
}

class _CharacterSelectorState extends State<CharacterSelector> {
  final InitializeUserController _initializeUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _initializeUserController.selectedCharacter = widget.characterName;
        print(
            "selcted charcter: ${_initializeUserController.selectedCharacter} vs this wodget ${widget.characterName}");
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Obx(() => Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: _initializeUserController.selectedCharacter ==
                              widget.characterName
                          ? lightPupleColor
                          : whiteColor,
                      width: 2),
                ),
                width: 100,
                height: 100,
              )),
          Obx(() => AnimatedScale(
              scale: _initializeUserController.selectedCharacter ==
                      widget.characterName
                  ? 1.1
                  : 1,
              duration: Duration(milliseconds: 500),
              child: Image.asset(
                  "assets/images/Avatars/${widget.characterName}.png"))),
        ],
      ),
    );
  }
}

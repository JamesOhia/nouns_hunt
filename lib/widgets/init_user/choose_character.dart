import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/controllers/initialize_user.dart';
import 'package:nouns_flutter/widgets/init_user/avatar_selector.dart';
import 'package:nouns_flutter/widgets/init_user/chracter_selector.dart';

class ChooseCharacter extends StatefulWidget {
  final void Function() goToNext;
  const ChooseCharacter({super.key, required this.goToNext});

  @override
  State<ChooseCharacter> createState() => _ChooseCharacterState();
}

class _ChooseCharacterState extends State<ChooseCharacter> {
  final List _characters = ['dexter', 'lily'];
  final InitializeUserController _initializeUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GridView.count(
            crossAxisCount: _characters.length,
            shrinkWrap: true,
            children: _characters
                .map((character) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CharacterSelector(characterName: character),
                    ))
                .toList(),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Obx(() => ElevatedButton(
                onPressed:
                    _initializeUserController.selectedCharacter.isNotEmpty
                        ? () {
                            widget.goToNext();
                          }
                        : null,
                child: const Text('Ok'))),
          )
        ],
      ),
    );
  }
}

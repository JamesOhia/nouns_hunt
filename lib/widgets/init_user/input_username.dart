import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/controllers/initialize_user.dart';
import 'package:nouns_flutter/pallette.dart';

class InputUsername extends StatefulWidget {
  final void Function() goToNext;
  const InputUsername({required this.goToNext, super.key});

  @override
  State<InputUsername> createState() => _InputUsernameState();
}

class _InputUsernameState extends State<InputUsername> {
  InitializeUserController _initializeUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            textAlign: TextAlign.center,
            onChanged: (value) {
              _initializeUserController.username = value;
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 16),
            child: Text("Username has to be at least 8 characters",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: darkGreyTextColor,
                    fontSize: constraints.maxHeight * 0.08)),
          ),
          Obx(() => ElevatedButton(
              onPressed: _initializeUserController.username.length > 8
                  ? () {
                      widget.goToNext();
                    }
                  : null,
              child: const Text('Ok')))
        ],
      ));
    });
  }
}

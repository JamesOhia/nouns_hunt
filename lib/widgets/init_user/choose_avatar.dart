import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/controllers/initialize_user.dart';
import 'package:nouns_flutter/widgets/init_user/avatar_selector.dart';

class ChooseAvatar extends StatefulWidget {
  final void Function() goToNext;
  const ChooseAvatar({super.key, required this.goToNext});

  @override
  State<ChooseAvatar> createState() => _ChooseAvatarState();
}

class _ChooseAvatarState extends State<ChooseAvatar> {
  final List _avatarOptions = ['1', '2', '3', '4', '5', '6'];
  InitializeUserController _initializeUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        child: Column(
          children: [
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              children: _avatarOptions
                  .map((avatar) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AvatarSelector(avatarKey: avatar),
                      ))
                  .toList(),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Obx(() => ElevatedButton(
                  onPressed: _initializeUserController.selectedAvatar.isNotEmpty
                      ? () {
                          widget.goToNext();
                        }
                      : null,
                  child: const Text('Ok'))),
            )
          ],
        ),
      );
    });
  }
}

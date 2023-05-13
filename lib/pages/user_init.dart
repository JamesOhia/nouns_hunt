import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/controllers/auth_controller.dart';
import 'package:nouns_flutter/controllers/initialize_user.dart';
import 'package:nouns_flutter/widgets/common/custom_dialog.dart';
import 'package:nouns_flutter/widgets/init_user/choose_avatar.dart';
import 'package:nouns_flutter/widgets/init_user/choose_character.dart';
import 'package:nouns_flutter/widgets/init_user/choose_country.dart';
import 'package:nouns_flutter/widgets/init_user/input_username.dart';

class InitializeUser extends StatefulWidget {
  const InitializeUser({super.key});

  @override
  State<InitializeUser> createState() => _InitializeUserState();
}

class _InitializeUserState extends State<InitializeUser> {
  late final List<Widget> _dialogs;
  int _currentDialog = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: Get.width,
          height: Get.height - MediaQuery.of(context).viewInsets.bottom,
          child: LayoutBuilder(builder: (context, constraints) {
            var pageWidth = constraints.maxWidth;
            var pageHeight = constraints.maxHeight;

            return Container(
                alignment: Alignment.center,
                width: pageWidth,
                height: pageHeight,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage("assets/images/Common/letters_bg.png"),
                        fit: BoxFit.cover)),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.black.withAlpha(50),
                  width: pageWidth,
                  height: pageHeight,
                  child: Center(
                      child: Container(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: _dialogs.isNotEmpty
                          ? _dialogs[_currentDialog]
                          : Container(),
                    ),
                  )),
                ));
          }),
        ));
  }

  void switchDialog(int i) {
    setState(() {
      _currentDialog = i;
    });
  }

  @override
  void initState() {
    super.initState();

    _dialogs = List.of([
      CustomDialog(
        key: const ValueKey<int>(1),
        icon: "assets/images/InputUserName/IconGroup_TitleIcon_Pencil.png",
        title: "Username",
        heightMultiplier: 0.85,
        content: InputUsername(goToNext: () {
          switchDialog(1);
        }),
      ),
      CustomDialog(
          key: const ValueKey<int>(2),
          icon: "assets/images/MainMenu/Icon_ColorIcon_Emoji.Png",
          title: "Choose Avatar",
          heightMultiplier: 1.1,
          content: ChooseAvatar(goToNext: () {
            switchDialog(2);
          })),
      // CustomDialog(
      //     key: const ValueKey<int>(3),
      //     icon: "assets/images/MainMenu/Icon_ColorIcon_Emoji.Png",
      //     title: "Character Select",
      //     heightMultiplier: 1,
      //     content: ChooseCharacter(goToNext: () {
      //       switchDialog(3);
      //     })),
      CustomDialog(
          key: const ValueKey<int>(3),
          icon: "assets/images/InputUserName/itemicon_flag_0_red.png",
          title: "Choose Country",
          heightMultiplier: 0.85,
          content: ChooseCountry(goToNext: () async {
            var result =
                await Get.find<InitializeUserController>().registerUser();
            if (result == AuthResult.success) {
              //Named("/mainMenu");
              Navigator.of(context).pushReplacementNamed("mainMenu");
            } else {
              Get.find<Logger>()
                  .d("failed to register user TODO://maybe show dialog");
              Get.snackbar("Error", "Couldn't register user. Try again");
            }
          }))
    ]);
  }
}

//request signin with appropiate provider

//check if user on firebase(now on nakama)
//if registered just go ahead to main menu
//else go to register //choose avatar, country, username etc then save profile, and initialize leaderboard e.t.c

import 'package:countries_utils/countries_utils.dart';
import 'package:flutter/material.dart';
import 'package:nouns_flutter/controllers/main_menu_controller.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/widgets/mainmenu/avatar_widget.dart';
import 'package:nouns_flutter/widgets/mainmenu/high_score_widget.dart';
import 'package:nouns_flutter/widgets/mainmenu/global_ranking_widget.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';

class ProfileDialog extends StatefulWidget {
  final double scale;
  final void Function() closeDialog;
  const ProfileDialog(
      {required this.closeDialog, super.key, required this.scale});

  @override
  State<ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  UserController _userController = Get.find();
  MainMenuController _mainMenuController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black.withOpacity(0.5),
        child: LayoutBuilder(builder: (context, constraints) {
          return AnimatedScale(
              alignment: Alignment.topLeft,
              curve: Curves.elasticInOut,
              duration: const Duration(milliseconds: 500),
              scale: widget.scale,
              child: Container(
                  width: constraints.maxWidth * 0.8,
                  height: constraints.maxHeight * 0.8,
                  child: Stack(clipBehavior: Clip.none, children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TopSection(closeDialog: widget.closeDialog),
                              ProfileHeader(),
                              const Expanded(child: PlayerStats())
                            ])),
                    Positioned(
                      top: -30,
                      left: -15,
                      child: AvatarWidget(width: 70, height: 70),
                    ),
                  ])));
        }));
  }
}

class TopSection extends StatelessWidget {
  final void Function() closeDialog;
  TopSection({
    required this.closeDialog,
    Key? key,
  }) : super(key: key);

  UserController _userController = Get.find();
  MainMenuController _mainMenuController = Get.find();

  @override
  Widget build(BuildContext context) {
    var maxHeight = Get.height * 0.08;

    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        height: maxHeight,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 60, right: 10),
                    alignment: Alignment.centerLeft,
                    height: maxHeight * 0.65,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Obx(() => TextField(
                                    readOnly:
                                        _mainMenuController.usernameEditable,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: darkGreyTextColor,
                                            fontSize: 12),
                                    textAlignVertical: TextAlignVertical.center,
                                    textAlign: TextAlign.left,
                                    onSubmitted: (value) {
                                      _mainMenuController.usernameEditable =
                                          false;
                                      _userController.updateUsername(value);
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: _userController.username,
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: darkGreyTextColor,
                                              fontSize: 12),
                                    ),
                                  ))),
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: InkWell(
                              onTap: () {
                                print('allow edit');
                                _mainMenuController.usernameEditable =
                                    !_mainMenuController.usernameEditable;
                              },
                              child: Image.asset(
                                  "assets/images/MainMenu/Icon_WhiteIcon_Pencil2.png",
                                  width: 20,
                                  height: 20),
                            ),
                          ),
                        ])),
              ),
              InkWell(
                onTap: closeDialog,
                child: Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/MainMenu/Btn_IconButton_Circle_90.png"),
                          fit: BoxFit.fill),
                    ),
                    child: Text('X',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: darkGreyTextColor, fontSize: 14))),
              ),
            ]));
  }
}

class ProfileHeader extends StatelessWidget {
  ProfileHeader({super.key});

  UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'AMATEUR ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 12)),
                      TextSpan(
                          text: Countries.byCode(_userController.country)
                              .flagIcon!)
                    ])),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'LV',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 12)),
                              TextSpan(
                                  text: _userController.level,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 19)),
                            ])),
                            Expanded(
                              child: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(2)),
                                  child: Stack(children: [
                                    LayoutBuilder(
                                        builder: (context, constraints) {
                                      return Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                              width: constraints.maxWidth *
                                                  _userController.xp /
                                                  _userController.maxXp,
                                              //height: 10,
                                              decoration: BoxDecoration(
                                                  color: greenColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2))));
                                    }),
                                    Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                            "${_userController.xp} / ${_userController.maxXp}",
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    fontSize: 6,
                                                    color: whiteColor)))
                                  ])),
                            ),
                          ],
                        ))
                  ],
                )),
          ),
          GestureDetector(
              onTap: () {},
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  width: 100,
                  height: 40,
                  decoration: const BoxDecoration(
                      // color: orangeColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/MainMenu/orange_scaled.png"),
                          fit: BoxFit.fill)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      LayoutBuilder(builder: (context, constraints) {
                        return Container(
                          width: constraints.maxHeight * 0.7,
                          height: constraints.maxHeight * 0.7,
                          child: Image.asset(
                            "assets/images/MainMenu/Icon_ColorIcon_ClanMark.png",
                          ),
                        );
                      }),
                      Expanded(
                        child: Text(
                          'JOIN CLASSROOM',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 7, color: redColor),
                        ),
                      )
                    ],
                  )))
        ]));
  }
}

class PlayerStats extends StatelessWidget {
  const PlayerStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  border: Border.all(color: darkGreyTextColor),
                  borderRadius: BorderRadius.circular(15)),
              child: Text('PLAYER STATS',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 9, color: darkGreyTextColor)),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: darkGreyTextColor, width: 0.5),
                    borderRadius: BorderRadius.circular(15)),
              ),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: HighScoreWidget())),
              Expanded(flex: 2, child: GlobalRankingWidget())
            ],
          ),
        )
      ]),
    );
  }
}

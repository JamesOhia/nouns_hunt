import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/utils/audio.dart';
import 'package:nouns_flutter/widgets/common/svg_widget.dart';
import 'package:nouns_flutter/widgets/mainmenu/rectangle_button.dart';
import 'package:flutter/services.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:nouns_flutter/widgets/common/custom_dialog.dart';

class JoinGameMp extends StatefulWidget {
  const JoinGameMp({super.key});

  @override
  State<JoinGameMp> createState() => _JoinGameMpState();
}

class _JoinGameMpState extends State<JoinGameMp> {
  final MpSetupController _mpSetupController = Get.find();
  final TextEditingController _textEditingController = TextEditingController();
  var _loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(body: LayoutBuilder(builder: (context, constraints) {
          var pageWidth = constraints.maxWidth;
          var pageHeight = constraints.maxHeight;

          return Container(
              alignment: Alignment.center,
              width: pageWidth,
              height: pageHeight,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/Common/letters_bg.png"),
                      fit: BoxFit.cover)),
              child: Container(
                alignment: Alignment.center,
                color: Colors.black.withAlpha(50),
                width: pageWidth,
                height: pageHeight,
                child: Stack(alignment: Alignment.center, children: [
                  Positioned(
                    top: pageHeight * 0.01,
                    left: pageWidth * 0.01,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: pageHeight * 0.05, left: pageWidth * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: pageWidth * 0.07,
                            height: pageWidth * 0.07,
                            margin: EdgeInsets.only(right: pageWidth * 0.03),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: primaryColor),
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                color: Colors.white,
                                style: IconButton.styleFrom(
                                    backgroundColor: darkGreyTextColor),
                                onPressed: () {
                                  Get.back();
                                  playBackButtonClickSound();
                                },
                                icon: Icon(
                                  Icons.chevron_left,
                                  size: pageWidth * 0.06,
                                )),
                          ),
                          Text("Join Game",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: pageWidth * 0.04,
                                      color: primaryColor))
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                      child: Center(
                          child: Container(
                    child: CustomDialog(
                        key: const ValueKey<int>(3),
                        icon: "assets/images/MainMenu/Icon_ColorIcon_Emoji.Png",
                        title: "Join Game",
                        heightMultiplier: 1,
                        content: Container(
                            child: Center(
                                child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Enter the game id',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontSize: pageWidth * 0.04,
                                        color: primaryColor)),
                            Container(
                              width: pageHeight * 0.08 * 3,
                              height: pageHeight * 0.05,
                              margin: EdgeInsets.only(
                                  top: pageHeight * 0.01,
                                  bottom: pageHeight * 0.01),
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: TextField(
                                  controller: _textEditingController,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: pageWidth * 0.03,
                                          color: primaryColor),
                                  enableSuggestions: false,
                                  enableIMEPersonalizedLearning: false,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            RectangleButton(
                              textColor: darkBlueColor,
                              bgImage: "assets/images/MainMenu/blue_scaled.png",
                              loading: _loading,
                              width: pageHeight * 0.08 * 2,
                              height: pageHeight * 0.06,
                              label: 'JOIN',
                              onPressed: () async {
                                setState(() {
                                  _loading = true;
                                });
                                await _mpSetupController
                                    .joinGame(_textEditingController.text);
                                setState(() {
                                  _loading = false;
                                });
                              },
                              locked: false,
                            )
                          ],
                        )))),
                  )))
                ]),
              ));
        })));
  }
}

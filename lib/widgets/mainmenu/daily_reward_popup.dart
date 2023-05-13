import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/controllers/game_controller.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/widgets/common/custom_dialog.dart';
import 'package:nouns_flutter/widgets/common/custom_dialog_painter.dart';
import 'package:nouns_flutter/widgets/mainmenu/rectangle_button.dart';

class DailyRewardPopup extends StatefulWidget {
  final double scale;
  const DailyRewardPopup({super.key, required this.scale});

  @override
  State<DailyRewardPopup> createState() => _DailyRewardPopupState();
}

class _DailyRewardPopupState extends State<DailyRewardPopup> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.8;
    var height = width * 1.25;

    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.black.withOpacity(0.5),
      child: AnimatedScale(
        scale: Get.find<GameController>().showDailyRewardPopup ? 1 : 0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.elasticInOut,
        child: Center(
          child: SizedBox(
            width: width,
            height: height * 1.1,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Transform.translate(
                    offset: Offset(-(width / 16), -(height / 4)),
                    child: CustomPaint(
                        size: Size(width, height),
                        painter:
                            CustomDialogPainter(color: Colors.grey[200]!))),
                Transform.translate(
                    offset: Offset(0, height * 0.03),
                    child: Image.asset(
                        "assets/images/MainMenu/itemicon_hourglass.png",
                        width: width * 0.13)),
                Container(
                    margin: EdgeInsets.only(top: height * 0.25),
                    child: Text(
                      "Daily Reward",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: width * 0.055),
                    )),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      margin: EdgeInsets.only(
                          top: height * 0.22, right: width * 0.01),
                      child: GestureDetector(
                        onTap: () {
                          Get.find<GameController>().showDailyRewardPopup =
                              false;
                        },
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
                                    .copyWith(
                                        color: darkGreyTextColor,
                                        fontSize: 14))),
                      )),
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Transform.translate(
                      offset: Offset(constraints.maxWidth * 0.012, 0),
                      child: Container(
                          padding: EdgeInsets.only(
                              top: width * 0.05,
                              left: width * 0.08,
                              right: width * 0.08,
                              bottom: width * 0.05),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          margin: EdgeInsets.only(top: height * 0.35),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "We got some gifts for you! Keep logging in daily to get a reward.",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: darkGreyTextColor,
                                        fontSize: width * 0.04),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: width * 0.05, bottom: width * 0.1),
                                width: width * 0.55,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    DailyRewardItem(
                                        width: width * 0.25,
                                        height: width * 0.3,
                                        image:
                                            "assets/images/MainMenu/dash_coins.png",
                                        amount: 500),
                                    DailyRewardItem(
                                        width: width * 0.25,
                                        height: width * 0.3,
                                        image:
                                            "assets/images/MainMenu/nouns_pencil.png",
                                        amount: 5)
                                  ],
                                ),
                              ),
                              Container(
                                child: RectangleButton(
                                  bgImage:
                                      'assets/images/MainMenu/blue_scaled.png',
                                  label: 'Collect',
                                  locked: false,
                                  width: width * 0.45,
                                  height: width * 0.18,
                                  onPressed: () {
                                    Get.find<UserController>().coins += 500;
                                    Get.find<UserController>().pencils += 5;
                                    Get.find<GameController>()
                                        .showDailyRewardPopup = false;
                                  },
                                  textColor: darkBlueColor,
                                ),
                              )
                            ],
                          )),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DailyRewardItem extends StatelessWidget {
  final double width;
  final double height;
  final String image;
  final int amount;
  const DailyRewardItem(
      {super.key,
      required this.width,
      required this.height,
      required this.image,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: height * 0.75,
            width: width,
            padding: EdgeInsets.symmetric(
                vertical: height * 0.15, horizontal: width * 0.15),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset(
                image,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: height * 0.25,
            width: width,
            decoration: BoxDecoration(
              color: Colors.grey[300]!,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Text(
              amount.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: orangeColor, fontSize: width * 0.12),
            ),
          )
        ],
      ),
    );
  }
}

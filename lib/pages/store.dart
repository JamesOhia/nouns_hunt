import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/controllers/game_controller.dart';
import 'package:nouns_flutter/controllers/store_controller.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/utils/audio.dart';
import 'package:nouns_flutter/widgets/mainmenu/daily_reward_popup.dart';
import 'package:nouns_flutter/widgets/mainmenu/rectangle_button.dart';
import 'package:nouns_flutter/widgets/mainmenu/square_button.dart';
import 'package:nouns_flutter/widgets/mainmenu/user_summary.dart';
import 'package:nouns_flutter/widgets/mainmenu/profile_dialog.dart';
import 'package:nouns_flutter/widgets/mainmenu/leaderboard_popup.dart';
import 'package:nouns_flutter/widgets/multiplayer/store_item.dart';
import 'package:nouns_flutter/widgets/singleplayer/currency_gauge.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(body: LayoutBuilder(builder: (context, constraints) {
          var pageWidth = constraints.maxWidth;
          var pageHeight = constraints.maxHeight;

          return Container(
              width: pageWidth,
              height: pageHeight,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/MainMenu/main_menu_bg.png'),
                fit: BoxFit.cover,
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      // color: Colors.green,
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // color: Colors.amber,
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
                            Text("Store",
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
                      Container(
                          //color: Colors.blueGrey,
                          margin: EdgeInsets.only(
                              top: pageHeight * 0.05, right: pageWidth * 0.03),
                          width: pageWidth * 0.55,
                          // height: pageHeight * 0.5,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    //color: Colors.yellow,
                                    height: pageHeight * 0.035,
                                    child: Obx(() => CurrencyGauge(
                                        imageUrl:
                                            "assets/images/MainMenu/dash_coins.png",
                                        amount: _userController.coins,
                                        darkColor: orangeColor,
                                        lightColor: lightOrangeColor,
                                        iconSize: 20,
                                        currencyIconoffset: const Offset(5, 2),
                                        onPressed: () {
                                          print("coins passed");
                                        })),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    //color: Colors.yellow,
                                    height: pageHeight * 0.035,
                                    child: Obx(() => CurrencyGauge(
                                        imageUrl:
                                            "assets/images/MainMenu/nouns_pencil.png",
                                        amount: _userController.pencils,
                                        darkColor: blueColor,
                                        lightColor: lightBlueColor,
                                        iconSize: 17,
                                        currencyIconoffset: const Offset(5, 0),
                                        onPressed: () {
                                          print("pencils passed");
                                        })),
                                  ),
                                ),
                              ]))
                    ],
                  )),
                  Expanded(
                    child: Container(
                      //color: Colors.red,
                      padding: EdgeInsets.only(
                          top: pageHeight * 0.03,
                          left: pageWidth * 0.03,
                          right: pageWidth * 0.03,
                          bottom: pageHeight * 0.03),
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: pageWidth * 0.02,
                        mainAxisSpacing: pageHeight * 0.02,
                        childAspectRatio: 0.8,
                        shrinkWrap: true,
                        children: [
                          Container(
                              child: StoreItem(
                            cost: "15",
                            currency: Currencies.pencil,
                            title: "Handful of Coins",
                            description: "1000 coins",
                            image:
                                "assets/images/MainMenu/handful_of_coins.png",
                            item: Currencies.coin,
                            quantity: 1000,
                          )),
                          Container(
                              child: StoreItem(
                            cost: "25",
                            currency: Currencies.pencil,
                            title: "Pile of Coins",
                            description: "3000 coins",
                            image: "assets/images/MainMenu/pile_of_coins.png",
                            item: Currencies.coin,
                            quantity: 3000,
                          )),
                          Container(
                              child: StoreItem(
                            cost: "150",
                            currency: Currencies.pencil,
                            title: "Pirate's Loot",
                            description: "10000 coins",
                            image: "assets/images/MainMenu/pirates_loot.png",
                            item: Currencies.coin,
                            quantity: 10000,
                          )),
                          Container(
                              child: StoreItem(
                            cost: "300",
                            currency: Currencies.pencil,
                            title: "Treasure Chest of Coins",
                            description: "25000 coins",
                            image: "assets/images/MainMenu/chest_of_coins.png",
                            item: Currencies.coin,
                            quantity: 25000,
                          )),
                          Container(
                              child: StoreItem(
                            itemId: "spare_pencils",
                            cost: "\$4.99",
                            title: "Spare Pencils",
                            description: "25 pencils",
                            image: "assets/images/MainMenu/spare_pencils.png",
                            item: Currencies.pencil,
                            quantity: 25,
                          )),
                          Container(
                              child: StoreItem(
                            itemId: "pack_pencils",
                            cost: "\$14.99",
                            title: "Pack of Pencils",
                            description: "100 pencils",
                            image: "assets/images/MainMenu/pack_of_pencils.png",
                            item: Currencies.pencil,
                            quantity: 100,
                          )),
                          Container(
                              child: StoreItem(
                            itemId: "carton_pencils",
                            cost: "\$49.99",
                            title: "Carton of Pencils",
                            description: "350 pencils",
                            image:
                                "assets/images/MainMenu/carton_of_pencils.png",
                            item: Currencies.pencil,
                            quantity: 350,
                          )),
                          Container(
                              child: StoreItem(
                            itemId: "stationery",
                            cost: "\$99.99",
                            title: "Stationery",
                            description: "750 pencils",
                            image: "assets/images/MainMenu/stationery.png",
                            item: Currencies.pencil,
                            quantity: 750,
                          )),
                        ],
                      ),
                    ),
                  )
                ],
              ));
        })));
  }
}

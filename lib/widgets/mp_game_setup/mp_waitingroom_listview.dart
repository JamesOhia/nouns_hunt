import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/utils/string_extensions.dart';
import 'package:nouns_flutter/widgets/mainmenu/rectangle_button.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/custom_checkbox.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/five_star_input.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/rounds_input.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/data/categories.dart';
import 'package:countries_utils/countries_utils.dart';

class WaitingRoomListView extends StatelessWidget {
  WaitingRoomListView({super.key});
  final MpSetupController _mpSetupController = Get.find();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scrollbar(
        thumbVisibility: true,
        child: Container(
          padding: EdgeInsets.only(right: constraints.maxWidth * 0.035),
          child: Obx(() => ListView.builder(
                itemBuilder: (context, index) {
                  var player = _mpSetupController.playersInWaitingRoom
                      .elementAt(index)
                      .value;
                  var isCurrentPlayer =
                      player.userId == Get.find<UserController>().id;

                  return Container(
                    clipBehavior: Clip.hardEdge,
                    margin: EdgeInsets.symmetric(
                        vertical: constraints.maxWidth * 0.005),
                    padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.01,
                        vertical: constraints.maxWidth * 0.005),
                    height: constraints.maxWidth * 0.145,
                    decoration: BoxDecoration(
                        color: isCurrentPlayer
                            ? primaryColor.withOpacity(0.5)
                            : Colors.transparent,
                        borderRadius:
                            BorderRadius.circular(constraints.maxWidth * 0.01)),
                    child: Container(
                        clipBehavior: Clip.hardEdge,
                        margin: EdgeInsets.symmetric(
                            vertical: constraints.maxWidth * 0.01),
                        // height: constraints.maxWidth * 0.135,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(
                                constraints.maxWidth * 0.01)),
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: constraints.maxHeight,
                                width: constraints.maxHeight * 1.1,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(
                                            constraints.maxWidth * 0.05))),
                                child: Text((index + 1).toString(),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontSize:
                                                constraints.maxWidth * 0.035,
                                            color: primaryColor)),
                              ),
                              Container(
                                  // color: Colors.green,
                                  height: constraints.maxHeight,
                                  width: constraints.maxHeight * 1.2,
                                  padding: EdgeInsets.symmetric(
                                      vertical: constraints.maxHeight * 0.03,
                                      horizontal: constraints.maxWidth * 0.03),
                                  child: Image.asset(
                                    "assets/images/Avatars/2.png",
                                    height: constraints.maxHeight * 0.8,
                                    width: constraints.maxHeight * 0.8,
                                  )),
                              Text(player.username,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize:
                                              constraints.maxWidth * 0.035,
                                          color: Colors.grey[600])),
                              Spacer(),
                              Container(
                                alignment: Alignment.center,
                                //color: Colors.green,
                                height: constraints.maxHeight,
                                width: constraints.maxHeight * 1.2,
                                child: player.userId == _mpSetupController.host
                                    ? Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.circular(
                                                constraints.maxWidth * 0.02)),
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                constraints.maxHeight * 0.15,
                                            horizontal:
                                                constraints.maxHeight * 0.15),
                                        child: Text(
                                          'HOST',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                fontSize:
                                                    constraints.maxHeight *
                                                        0.18,
                                              ),
                                        ),
                                      )
                                    : Container(),
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  //color: Colors.green,
                                  height: constraints.maxHeight,
                                  width: constraints.maxHeight * 1.2,
                                  child: Text(
                                      Countries.byCode(player.country)
                                          .flagIcon!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontSize: constraints.maxHeight *
                                                  0.35)))
                            ],
                          );
                        })),
                  );
                  //return Text(categoriesList[index]);
                },
                itemCount: _mpSetupController.playersInWaitingRoom.length,
              )),
        ),
      );
    });
  }
}

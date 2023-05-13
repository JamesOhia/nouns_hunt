import 'package:flutter/material.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/controllers/leaderboards_controller.dart';
import 'package:nouns_flutter/utils/string_extensions.dart';

class GlobalRankingWidget extends StatelessWidget {
  GlobalRankingWidget({super.key});
  UserController _userController = Get.find();
  LeaderboardsController _leaderboardsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(6),
        height: 50,
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Global Ranking',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 8, color: darkGreyTextColor)),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Obx(() {
                        var rank = _leaderboardsController
                            .currentUserRecord?.rank
                            .toString();
                        return RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: rank!.isEmpty || rank == '0' ? '-' : rank,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 14,
                                  )),
                          TextSpan(
                              text: rank!.isEmpty || rank == '0'
                                  ? ''
                                  : rank.getRankSuffix(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 10,
                                  )),
                        ]));
                      })),
                      LayoutBuilder(builder: (context, constraints) {
                        return Container(
                            alignment: Alignment.center,
                            width: constraints.maxHeight * 0.7,
                            height: constraints.maxHeight * 0.7,
                            child: Image.asset(
                                "assets/images/Common/rank_same.png"));
                      }),
                    ]),
              ),
            ),
          ],
        ));
  }
}

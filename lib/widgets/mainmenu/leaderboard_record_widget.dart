import 'package:countries_utils/countries.dart';
import 'package:countries_utils/countries_data.dart';
import 'package:flutter/material.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/controllers/leaderboards_controller.dart';

class LeaderboardRecordWidget extends StatelessWidget {
  final String userId;
  final int rank;
  final String username;
  final String avatar;
  final String country;
  final int score;
  final String movement;
  final double sizeMultiplier;

  LeaderboardRecordWidget(
      {super.key,
      required this.userId,
      required this.rank,
      required this.username,
      required this.avatar,
      required this.country,
      required this.score,
      required this.movement,
      this.sizeMultiplier = 1});

  UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Obx(() {
        var isCurrentPlayer = userId == Get.find<UserController>().id;
        return Container(
          height: constraints.maxWidth * 0.22 * sizeMultiplier,
          padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.01,
              vertical: constraints.maxWidth * 0.01),
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            color: isCurrentPlayer
                ? primaryColor.withOpacity(0.5)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(constraints.maxHeight * 0.1),
          ),
          child: Container(
              //height: constraints.maxWidth * 0.2 * sizeMultiplier,
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius:
                    BorderRadius.circular(constraints.maxHeight * 0.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LayoutBuilder(builder: (context, constraints) {
                    return Container(
                      decoration: BoxDecoration(
                          color: rank == 1
                              ? Colors.orange[100]
                              : rank == 2
                                  ? Colors.blue[100]
                                  : rank == 3
                                      ? Colors.red[100]
                                      : Colors.grey[200],
                          borderRadius: BorderRadius.only(
                              topRight:
                                  Radius.circular(constraints.maxHeight * 0.3),
                              topLeft:
                                  Radius.circular(constraints.maxHeight * 0.2),
                              bottomLeft: Radius.circular(
                                  constraints.maxHeight * 0.2))),
                      alignment: Alignment.center,
                      width: constraints.maxHeight * 1.1,
                      child: Center(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: rank == 1
                            ? MedalWidget(
                                rank: rank,
                                constraints: constraints,
                                image:
                                    "assets/images/MainMenu/Icon_GroupIcon_Medal_Gold.png",
                                textColor: orangeColor,
                              )
                            : rank == 2
                                ? MedalWidget(
                                    rank: rank,
                                    constraints: constraints,
                                    image:
                                        "assets/images/MainMenu/Icon_GroupIcon_Medal_Silver.png",
                                    textColor: darkBlueColor,
                                  )
                                : rank == 3
                                    ? MedalWidget(
                                        rank: rank,
                                        constraints: constraints,
                                        image:
                                            "assets/images/MainMenu/Icon_GroupIcon_Medal_Bronze.png",
                                        textColor: redColor,
                                      )
                                    : Container(
                                        //color: Colors.yellow,
                                        alignment: Alignment.center,
                                        child: Text(rank.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    color: blueColor,
                                                    fontSize:
                                                        constraints.maxHeight *
                                                            (rank > 3
                                                                ? 0.33
                                                                : 0.3))),
                                      ),
                      ),
                    );
                  }),
                  Container(
                      width: constraints.maxHeight * 0.7,
                      height: constraints.maxHeight * 0.7,
                      margin: EdgeInsets.symmetric(
                          horizontal: constraints.maxHeight * 0.12),
                      child:
                          Image.asset("assets/images/Avatars/${avatar}.png")),
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: Text(
                        Countries.byCode(country.toUpperCase()).flagIcon!,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: constraints.maxHeight * 0.25,
                            )),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(username,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: constraints.maxHeight * 0.2,
                                  color: Colors.grey[600])),
                    ),
                  ),
                  LayoutBuilder(builder: (context, constraints) {
                    return Container(
                      padding: EdgeInsets.only(right: 12),
                      alignment: Alignment.centerRight,
                      width: constraints.maxHeight * 1,
                      child: Text(
                        score.toString(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: constraints.maxHeight * 0.21,
                            ),
                      ),
                    );
                  }),
                ],
              )),
        );
      });
    });
  }
}

class MedalWidget extends StatelessWidget {
  const MedalWidget({
    Key? key,
    required this.rank,
    required this.constraints,
    required this.image,
    required this.textColor,
  }) : super(key: key);

  final int rank;
  final BoxConstraints constraints;
  final String image;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: constraints.maxHeight * 0.7,
        height: constraints.maxHeight * 0.7,
        decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.contain, image: AssetImage(image)),
        ),
        child: Center(
          child: Transform.translate(
            offset: Offset(0, constraints.maxHeight * 0.065),
            child: Text(rank.toString(),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: textColor, fontSize: constraints.maxHeight * 0.3)),
          ),
        ));
  }
}

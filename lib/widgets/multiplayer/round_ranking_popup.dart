import 'package:flutter/material.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/controllers/mp_controller.dart';
import 'package:nouns_flutter/widgets/mainmenu/leaderboard_record_widget.dart';
import 'package:logger/logger.dart';

class RoundRankingPopup extends StatefulWidget {
  final void Function() back;
  final bool inset;
  final double sizeMultiplier;
  const RoundRankingPopup(
      {super.key,
      required this.back,
      this.inset = false,
      this.sizeMultiplier = 1});

  @override
  State<RoundRankingPopup> createState() => _RoundRankingPopupState();
}

class _RoundRankingPopupState extends State<RoundRankingPopup> {
  UserController _userController = Get.find();
  MpController _mpController = Get.find();
  Logger _logger = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: LayoutBuilder(builder: (context, constraints) {
        var pageWidth = constraints.maxWidth;
        var pageHeight = constraints.maxHeight;

        return Container(
            width: pageWidth,
            height: pageHeight,
            //padding: EdgeInsets.all(1),
            color: Colors.grey[300],
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.inset
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: widget.back,
                              color: blueColor,
                              icon: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryColor,
                                ),
                                child: const Icon(Icons.chevron_left,
                                    color: whiteColor),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 1),
                                child: Text('Ranking',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: primaryColor,
                                            fontSize: pageWidth * 0.05))),
                          ],
                        ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(
                        left: constraints.maxHeight *
                            0.01 *
                            widget.sizeMultiplier,
                        right: constraints.maxHeight *
                            0.01 *
                            widget.sizeMultiplier,
                        bottom: constraints.maxHeight * 0.01),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Scrollbar(
                              thumbVisibility: widget.inset,
                              child: Container(
                                  child: Obx(() => ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            _mpController.roundRanking.length,
                                        itemBuilder: ((context, index) {
                                          var entry =
                                              _mpController.roundRanking[index];

                                          return Container(
                                            height: pageHeight *
                                                0.07 *
                                                widget.sizeMultiplier,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: LeaderboardRecordWidget(
                                              avatar: entry.user.avatar,
                                              country: entry.user.country,
                                              movement: "entry.value.movement",
                                              rank: entry.ranking,
                                              score: entry.score,
                                              userId: entry.user.userId,
                                              username: entry.user.username,
                                              sizeMultiplier:
                                                  widget.sizeMultiplier,
                                            ),
                                          );
                                        }),
                                      )))),
                        )
                      ],
                    ),
                  ))
                ]));
      }),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

import 'package:flutter/material.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/controllers/leaderboards_controller.dart';
import 'package:nouns_flutter/utils/audio.dart';
import 'package:nouns_flutter/widgets/mainmenu/leaderboard_record_widget.dart';

class LeaderboardPopup extends StatefulWidget {
  final void Function() back;
  const LeaderboardPopup({super.key, required this.back});

  @override
  State<LeaderboardPopup> createState() => _LeaderboardPopupState();
}

class _LeaderboardPopupState extends State<LeaderboardPopup>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  UserController _userController = Get.find();
  LeaderboardsController _leaderboardsController = Get.find();
  var indicatorColor = darkBlueColor2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Container(
          width: Get.width,
          height: Get.height,
          //padding: EdgeInsets.all(1),
          color: Colors.grey[100],
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.back();
                        playBackButtonClickSound();
                      },
                      color: darkBlueColor2,
                      icon: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: darkBlueColor2,
                        ),
                        child:
                            const Icon(Icons.chevron_left, color: whiteColor),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 1),
                        child: Text('Ranking',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: darkBlueColor2, fontSize: 12))),
                  ],
                ),
                Expanded(
                    child: Container(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: TabBar(
                            controller: _tabController,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                              color: indicatorColor,
                            ),
                            labelColor: Colors.white,
                            unselectedLabelColor: darkGreyTextColor,
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: whiteColor, fontSize: 10),
                            tabs: [
                              Tab(
                                child: TabButton(
                                  text: 'Global',
                                  active: _tabController.index == 0,
                                ),
                              ),
                              Tab(
                                child: TabButton(
                                  text: 'Country',
                                  active: _tabController.index == 1,
                                ),
                              ),
                              Tab(child: LayoutBuilder(
                                  builder: (context, constraints) {
                                return Container(
                                    width: constraints.maxWidth,
                                    height: constraints.maxHeight,
                                    decoration: const BoxDecoration(
                                        //color: lightGreyTextColor,
                                        ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      clipBehavior: Clip.none,
                                      children: [
                                        Text('Classroom',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    color: darkGreyTextColor,
                                                    fontSize:
                                                        constraints.maxHeight *
                                                            0.2)),
                                        Positioned(
                                          bottom: -5,
                                          right: -15,
                                          child: Image.asset(
                                              'assets/images/MainMenu/Icon_ColorIcon_Lock01.png',
                                              width: 15),
                                        )
                                      ],
                                    ));
                              })),
                            ]),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: Get.height * 0.01,
                              horizontal: Get.width * 0.03),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)),
                          child:
                              TabBarView(controller: _tabController, children: [
                            Obx(() => ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _leaderboardsController
                                      .globalLeaderboard.length,
                                  itemBuilder: ((context, index) {
                                    var entry = _leaderboardsController
                                        .globalLeaderboard[index];
                                    return Container(
                                      height: Get.height * 0.065,
                                      margin: EdgeInsets.symmetric(vertical: 4),
                                      child: LeaderboardRecordWidget(
                                        avatar: entry.value.avatar,
                                        country: entry.value.country,
                                        movement: entry.value.movement,
                                        rank: entry.value.rank,
                                        score: entry.value.score,
                                        userId: entry.value.userId,
                                        username: entry.value.username,
                                      ),
                                    );
                                  }),
                                )),
                            Obx(() {
                              Get.find<Logger>().i(
                                  "about to render country leaderbiard",
                                  _leaderboardsController.countryLeaderboard);
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: _leaderboardsController
                                    .countryLeaderboard.length,
                                itemBuilder: ((context, index) {
                                  var entry = _leaderboardsController
                                      .countryLeaderboard[index];
                                  return Container(
                                    height: Get.height * 0.065,
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    child: LeaderboardRecordWidget(
                                      avatar: entry.value.avatar,
                                      country: entry.value.country,
                                      movement: entry.value.movement,
                                      rank: entry.value.rank,
                                      score: entry.value.score,
                                      userId: entry.value.userId,
                                      username: entry.value.username,
                                    ),
                                  );
                                }),
                              );
                            }),
                            Container(
                                child: const Center(
                                    child: Text('Not available yet'))),
                          ]),
                        ),
                      )
                    ],
                  ),
                ))
              ])),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _leaderboardsController.fecthGlobalLeaderbaord();
    _leaderboardsController.fecthCountryLeaderbaord();

    _tabController.addListener(() {
      if (_tabController.index == 2) {
        indicatorColor = Colors.grey[400]!;
      } else {
        indicatorColor = darkBlueColor2;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}

class TabButton extends StatelessWidget {
  final String text;
  final bool active;

  const TabButton({super.key, required this.text, required this.active});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          alignment: Alignment.center,
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10.0,
            ),
            color: active ? darkBlueColor2 : whiteColor,
          ),
          child: Text(text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: active ? whiteColor : darkGreyTextColor,
                  fontSize: constraints.maxHeight * 0.2)));
    });
  }
}

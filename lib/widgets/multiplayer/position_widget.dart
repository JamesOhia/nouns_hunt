import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/widgets/multiplayer/selected_alphabet.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/widgets/mainmenu/rectangle_button.dart';
import 'package:nouns_flutter/widgets/mainmenu/square_button.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/five_star_input.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/mp_categories_listview.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/mp_waitingroom_listview.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/rounds_input.dart';
import 'package:nouns_flutter/controllers/mp_controller.dart';
import 'package:nouns_flutter/widgets/common/svg_widget.dart';
import 'package:nouns_flutter/widgets/multiplayer/alphabet_selector.dart';

class PositionWidet extends StatelessWidget {
  final int position;
  const PositionWidet(this.position, {super.key});

  @override
  Widget build(BuildContext context) {
    var superScript = position == 1
        ? "st"
        : position == 2
            ? "nd"
            : position == 3
                ? "rd"
                : "th";
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
                child: SvgWidget(
                    width: constraints.maxWidth * 0.8,
                    height: constraints.maxWidth * 0.8,
                    image: "assets/images/multiplayer/letter_bg.svg")),
            Positioned.fill(
                child: Container(
                    padding: EdgeInsets.all(constraints.maxWidth * 0.01),
                    alignment: Alignment.center,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  bottom: constraints.maxHeight * 0.08),
                              child: Text("Position",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: constraints.maxWidth * 0.16,
                                          color: whiteColor))),
                          Container(
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontSize:
                                                  constraints.maxWidth * 0.4,
                                              color: whiteColor),
                                      children: [
                                        TextSpan(
                                          text: position.toString(),
                                        ),
                                        WidgetSpan(
                                            child: Transform.translate(
                                                offset: Offset(
                                                    0.0,
                                                    -constraints.maxHeight *
                                                        0.25),
                                                child: Text(superScript,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                            fontSize: constraints
                                                                    .maxWidth *
                                                                0.2,
                                                            color:
                                                                whiteColor)))),
                                      ])))
                        ]))),
          ],
        ),
      );
    });
  }
}

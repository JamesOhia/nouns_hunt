import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/utils/string_extensions.dart';
import 'package:nouns_flutter/widgets/mainmenu/rectangle_button.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/custom_checkbox.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/five_star_input.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/rounds_input.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/data/categories.dart';

class MpCategoriesListView extends StatelessWidget {
  MpCategoriesListView({super.key});
  List<String> categoriesList = Categories.mpCategories.keys.toList()..sort();
  MpSetupController _mpSetupController = Get.find();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scrollbar(
        thumbVisibility: true,
        child: Container(
          padding: EdgeInsets.only(right: constraints.maxWidth * 0.035),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.symmetric(
                      vertical: constraints.maxWidth * 0.01),
                  height: constraints.maxWidth * 0.135,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius:
                          BorderRadius.circular(constraints.maxWidth * 0.01)),
                  child: Stack(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Obx(() => CategoryCheckbox(
                            isChecked: _mpSetupController
                                .isCategorySelected(categoriesList[index]),
                            width: constraints.maxWidth * 0.15,
                            onChanged: (isChecked) {
                              if (isChecked) {
                                _mpSetupController
                                    .addCategory(categoriesList[index]);
                              } else {
                                _mpSetupController
                                    .removeCategory(categoriesList[index]);
                              }
                            },
                          )),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(categoriesList[index].formatAsCategory(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: primaryColor,
                                  fontSize: constraints.maxWidth * 0.03)),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: orangeColor,
                              size: constraints.maxWidth * 0.06,
                            ),
                            Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                    left: constraints.maxWidth * 0.01,
                                    right: constraints.maxWidth * 0.03),
                                child: Text(
                                  Categories.mpCategories[
                                          categoriesList[index]]!["difficulty"]
                                      .toString(),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: darkGreyTextColor,
                                          fontSize:
                                              constraints.maxWidth * 0.03),
                                ))
                          ],
                        ))
                  ]));
              //return Text(categoriesList[index]);
            },
            itemCount: categoriesList.length,
          ),
        ),
      );
    });
  }
}

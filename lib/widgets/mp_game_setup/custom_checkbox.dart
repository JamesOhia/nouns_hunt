import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/widgets/mainmenu/rectangle_button.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/five_star_input.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/rounds_input.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/data/categories.dart';
import 'package:nouns_flutter/widgets/common/svg_widget.dart';

class CategoryCheckbox extends StatefulWidget {
  final double width;
  final void Function(bool) onChanged;
  final bool isChecked;
  const CategoryCheckbox(
      {super.key,
      this.isChecked = false,
      required this.width,
      required this.onChanged});

  @override
  State<CategoryCheckbox> createState() => _CategoryCheckboxState();
}

class _CategoryCheckboxState extends State<CategoryCheckbox> {
  final MpSetupController _mpSetupController = Get.find();
  //var _isChecked = false;

  @override
  Widget build(BuildContext context) {
    //_isChecked = widget.isChecked;

    return SizedBox(
        width: widget.width,
        height: widget.width,
        child: InkWell(
            onTap: () {
              // if (!_mpSetupController.createEnabled ||
              //     (_mpSetupController.createEnabled && _isChecked)) {
              //   setState(() {
              //     _isChecked = !_isChecked;
              //     widget.onChanged(_isChecked);
              //   });
              // }
              if (!_mpSetupController.createGameEnabled ||
                  (_mpSetupController.createGameEnabled && widget.isChecked)) {
                widget.onChanged(!widget.isChecked);
              }
            },
            child: Stack(alignment: Alignment.center, children: [
              Container(
                child: SvgWidget(
                    width: widget.width * 0.9,
                    height: widget.width * 0.31,
                    image: "assets/images/multiplayer/Checkbox.svg"),
              ),
              Container(
                  child: AnimatedScale(
                      curve: Curves.bounceInOut,
                      scale: widget.isChecked ? 1 : 0,
                      duration: const Duration(milliseconds: 100),
                      child: SvgWidget(
                          width: widget.width * 0.9,
                          height: widget.width * 0.31,
                          image: "assets/images/multiplayer/Check.svg")))
            ])));
  }
}

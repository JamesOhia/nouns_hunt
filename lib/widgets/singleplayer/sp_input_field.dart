import 'package:flame/image_composition.dart';
import 'package:flame/widgets.dart';
import 'package:flame_fire_atlas/flame_fire_atlas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/controllers/sp_gameplay.dart';
import 'package:nouns_flutter/utils/uppercase_text_formatter.dart';

class SpInputField extends StatefulWidget {
  final BoxConstraints constraints;
  final FireAtlas spriteAtlas;
  final FocusNode inputFieldFocusNode;
  final TextEditingController textEditingController;
  const SpInputField(
      {required this.spriteAtlas,
      required this.textEditingController,
      super.key,
      required this.constraints,
      required this.inputFieldFocusNode});

  @override
  State<SpInputField> createState() => _SpInputFieldState();
}

class _SpInputFieldState extends State<SpInputField> {
  final SingleplayerController _spController = Get.find();
  final String _answer = '';

  @override
  Widget build(BuildContext context) {
    var smallScreen = widget.constraints.maxHeight < 500;
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
              bottom: -Get.width * 0.02,
              right: -Get.width * 0.02,
              child: Obx(() => _spController.repeatedAlphabetCategory
                  ? Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: Text(
                        _spController.categoryRepeatedTimes.toString(),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: whiteColor,
                              fontSize: 0.02 * widget.constraints.maxHeight,
                            ),
                      ))
                  : Container())),
          Row(
            children: [
              Obx(() => Container(
                  alignment: Alignment.center,
                  height: 0.09 * widget.constraints.maxHeight,
                  decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(20))),
                  padding: EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 0.01 * widget.constraints.maxHeight),
                  child: Text(
                    _spController.currentAlphabet.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: whiteColor,
                        fontSize: 0.04 * widget.constraints.maxHeight),
                  ))),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 9 / 100 * widget.constraints.maxHeight,
                  decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(15))),
                  padding: EdgeInsets.only(
                      left: 12,
                      right: widget.constraints.maxWidth *
                          ((smallScreen ? 0.14 : 0.15))),
                  child: TextField(
                    onSubmitted: (_) {
                      nextRound();
                    },
                    autofocus: true,
                    showCursor: true,
                    cursorColor: primaryColor,
                    focusNode: widget.inputFieldFocusNode,
                    controller: widget.textEditingController,
                    textCapitalization: TextCapitalization.characters,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: widget.constraints.maxHeight *
                              (smallScreen ? 0.02 : 0.035),
                        ),
                    autocorrect: false,
                    // toolbarOptions: const ToolbarOptions(
                    //   copy: true,
                    //   cut: true,
                    //   paste: false,
                    //   selectAll: false,
                    // ),
                    contextMenuBuilder: (context, editableTextState) =>
                        AdaptiveTextSelectionToolbar.buttonItems(
                      anchors: editableTextState.contextMenuAnchors,
                      buttonItems: [],
                    ),
                    inputFormatters: [UppercaseTextFormatter()],
                    enableSuggestions: false,
                    enableIMEPersonalizedLearning: false,
                    textDirection: TextDirection.ltr,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Transform.translate(
              offset: const Offset(10, 0),
              child: GestureDetector(
                onTap: nextRound,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: (smallScreen ? 17 : 13.5) /
                      100 *
                      widget.constraints.maxHeight,
                  height: (smallScreen ? 17 : 13.5) /
                      100 *
                      widget.constraints.maxHeight,
                  child: Obx(() => SpriteWidget(
                      //srcSize: Vector2(80, 80),
                      anchor: Anchor.center,
                      sprite: widget.spriteAtlas
                          .getSprite(_spController.btnNextImage))),
                  // style: ElevatedButton.styleFrom(fixedSize: Size.fromWidth(200)),
                ),
              ),
            ),
          ),
        ]);
  }

  @override
  void initState() {
    super.initState();
  }

  void nextRound() {
    _spController.nextRound(widget.textEditingController.text);
    widget.textEditingController.text = '';
  }
}

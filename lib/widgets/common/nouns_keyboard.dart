import 'package:flutter/material.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:get/get.dart';

class NounsKeyboard extends StatefulWidget {
  final double width;
  final double height;
  final TextEditingController textEditingController;
  const NounsKeyboard({
    super.key,
    required this.width,
    required this.height,
    required this.textEditingController,
  });

  @override
  State<NounsKeyboard> createState() => _NounsKeyboardState();
}

class _NounsKeyboardState extends State<NounsKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        width: widget.width,
        height: widget.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  KeyboardCharacter(
                      value: "Q",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "W",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "E",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "R",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "T",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "Y",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "U",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "I",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "O",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "P",
                      textEditingController: widget.textEditingController),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  KeyboardCharacter(
                      value: "A",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "S",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "D",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "F",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "G",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "H",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "J",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "K",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "L",
                      textEditingController: widget.textEditingController),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 5,
                left: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  KeyboardCharacter(
                      value: "Z",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "X",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "C",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "V",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "B",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "N",
                      textEditingController: widget.textEditingController),
                  KeyboardCharacter(
                      value: "M",
                      textEditingController: widget.textEditingController),
                  Container(
                    width: Get.width / 12 * 1.4,
                    child: KeyboardCharacter(
                        value: "<-",
                        textEditingController: widget.textEditingController),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Expanded(
                  //     child: Container(
                  //   height: Get.width / 12,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(5),
                  //   ),
                  // )),
                  Container(
                    width: Get.width / 2,
                    height: Get.width / 12,
                    child: KeyboardCharacter(
                        value: " ",
                        textEditingController: widget.textEditingController),
                  ),
                  // Expanded(
                  //     child: Container(
                  //   height: Get.width / 12,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(5),
                  //   ),
                  // )),
                ],
              ),
            )
          ],
        ));
  }
}

class KeyboardCharacter extends StatefulWidget {
  const KeyboardCharacter(
      {super.key, required this.value, required this.textEditingController});
  final String value;
  final TextEditingController textEditingController;

  @override
  State<KeyboardCharacter> createState() => _KeyboardCharacterState();
}

class _KeyboardCharacterState extends State<KeyboardCharacter> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var cursorPosition = widget.textEditingController.selection.base.offset;
        var prefix =
            widget.textEditingController.text.substring(0, cursorPosition);
        var suffix =
            widget.textEditingController.text.substring(cursorPosition);

        if (widget.value == '<-') {
          widget.textEditingController.text =
              prefix.substring(0, prefix.length - 1) + suffix;
        } else {
          widget.textEditingController.text =
              widget.textEditingController.text + widget.value;

          widget.textEditingController.text = prefix + widget.value + suffix;
        }
      },
      child: Container(
        width: Get.width / 12,
        height: Get.width / 12,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(widget.value,
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 8)),
      ),
    );
  }
}

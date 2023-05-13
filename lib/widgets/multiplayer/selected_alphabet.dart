import 'package:flutter/material.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/widgets/common/svg_widget.dart';

class SelectedAlphabet extends StatelessWidget {
  final String alphabet;
  const SelectedAlphabet(this.alphabet, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constarints) {
      return Container(
        width: constarints.maxWidth,
        height: constarints.maxHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
                child: SvgWidget(
                    width: constarints.maxWidth * 0.8,
                    height: constarints.maxWidth * 0.8,
                    image: "assets/images/multiplayer/letter_bg.svg")),
            Positioned.fill(
                child: Container(
                    alignment: Alignment.center,
                    child: Text(alphabet,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: constarints.maxWidth * 0.4,
                            color: whiteColor)))),
          ],
        ),
      );
    });
  }
}

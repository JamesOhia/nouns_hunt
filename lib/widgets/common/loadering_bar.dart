import 'package:flutter/material.dart';
import 'package:nouns_flutter/pallette.dart';

class LoadingBar extends StatefulWidget {
  final int milliseconds;
  final void Function() onFinished;
  const LoadingBar(
      {super.key, required this.milliseconds, required this.onFinished});

  @override
  State<LoadingBar> createState() => _LoadingBarState();
}

class _LoadingBarState extends State<LoadingBar> {
  double fraction = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 20,
        decoration: BoxDecoration(
            color: Color.fromARGB(113, 0, 0, 0),
            borderRadius: BorderRadius.circular(10)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: LayoutBuilder(builder: (builder, constraints) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: widget.milliseconds),
                    width: fraction * constraints.maxWidth / 100,
                    height: constraints.maxHeight,
                    decoration: BoxDecoration(
                        color: orangeColor,
                        borderRadius: BorderRadius.circular(10)),
                  );
                  //return Container();
                })),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Loading...$fraction%",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: whiteColor, fontSize: 12),
              ),
            )
          ],
        ));
  }

  @override
  void initState() {
    super.initState();

    countProgress();
  }

  Future<void> countProgress() async {
    while (fraction < 100) {
      await Future.delayed(Duration(milliseconds: widget.milliseconds ~/ 100));
      setState(() {
        fraction++;
      });
    }

    widget.onFinished();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:logger/logger.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/utils/string_extensions.dart';
import 'package:nouns_flutter/widgets/mainmenu/rectangle_button.dart';
import 'package:nouns_flutter/widgets/multiplayer/scanner_widget.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/five_star_input.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/mp_categories_listview.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/mp_waitingroom_listview.dart';
import 'package:nouns_flutter/widgets/mp_game_setup/rounds_input.dart';
import 'package:nouns_flutter/controllers/mp_setup_controller.dart';
import 'package:nouns_flutter/pages/select_alphabet.dart';
import 'package:nouns_flutter/utils/uppercase_text_formatter.dart';
import 'package:nouns_flutter/controllers/mp_controller.dart';

class MpInputField extends StatefulWidget {
  final bool readOnly;
  final String category;
  final String? value;
  final FocusNode? focusNode;
  TextEditingController? controller;
  final void Function()? onSubmit;
  double? sizeOverride;
  bool scanAnimation;
  MpInputField(
      {super.key,
      this.readOnly = false,
      this.controller,
      this.value,
      this.sizeOverride,
      required this.category,
      this.scanAnimation = false,
      this.focusNode,
      this.onSubmit});
  @override
  State<MpInputField> createState() => _MpInputFieldState();
}

class _MpInputFieldState extends State<MpInputField>
    with SingleTickerProviderStateMixin {
  final MpController _mpController = Get.find();
  final Logger _logger = Get.find();
  AnimationController? _animationController;
  Animation<double>? _animation;
  bool _animationStopped = false;
  String scanText = "Scan";
  bool scanning = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var smallScreen = constraints.maxHeight < 500;
        return Container(
            clipBehavior: Clip.hardEdge,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(constraints.maxWidth * 0.3),
                color: primaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(widget.category.formatAsCategory(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: constraints.maxWidth * 0.05,
                                    color: whiteColor)))),
                Expanded(
                    child: Container(
                        decoration: const BoxDecoration(color: whiteColor),
                        alignment: Alignment.center,
                        child: Stack(alignment: Alignment.center, children: [
                          TextField(
                            onSubmitted: (_) {
                              widget.onSubmit?.call();
                            },
                            onChanged: (value) {
                              _mpController.updateAnswer(
                                  category: widget.category, answer: value);
                              _logger.i(
                                  "updated answer", _mpController.answers);
                            },
                            contextMenuBuilder: (context, editableTextState) =>
                                AdaptiveTextSelectionToolbar.buttonItems(
                              anchors: editableTextState.contextMenuAnchors,
                              buttonItems: [],
                            ),
                            readOnly: widget.readOnly,
                            enabled: !widget.readOnly,
                            autofocus: true,
                            showCursor: !widget.readOnly,
                            cursorColor: primaryColor,
                            focusNode: widget.focusNode,
                            controller: widget.controller,
                            textCapitalization: TextCapitalization.characters,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: (smallScreen ? 0.25 : 0.15) *
                                        constraints.maxHeight,
                                    //fontSize: 34,
                                    color: primaryColor),
                            autocorrect: false,
                            inputFormatters: [UppercaseTextFormatter()],
                            enableSuggestions: false,
                            enableIMEPersonalizedLearning: false,
                            textDirection: TextDirection.ltr,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: widget.value,
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: (smallScreen ? 0.25 : 0.15) *
                                            constraints.maxHeight,
                                        //fontSize: 34,
                                        color: primaryColor)),
                          ),
                          widget.scanAnimation
                              ? LayoutBuilder(builder: (context, constraints) {
                                  return Container(
                                      width: constraints.maxWidth,
                                      height: constraints.maxHeight,
                                      //color: Colors.red[200],
                                      child: ScannerWidget(
                                          stopped: _animationStopped,
                                          maxWidth: constraints.maxWidth,
                                          animation: CurvedAnimation(
                                              parent: _animationController
                                                  as Animation<double>,
                                              curve: Curves.easeInOut)));
                                })
                              : Container(),
                        ]))),
              ],
            ));
      },
    );
  }

  @override
  initState() {
    if (!widget.readOnly) {
      _mpController.updateAnswer(category: widget.category, answer: "");
    }
    Get.find<Logger>().i("answers from input filed", _mpController.answers);
    print(
        "value passed to input field value ${widget.value} from answers ${_mpController.answers[widget.category]}");
    if (widget.value != null) {
      print("value for ${widget.category} is ${widget.value}");
      widget.controller!.text = widget.value!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          //widget.controller!.text = widget.value!;
          widget.controller!.text = widget.value!;
        });
      });
    }

    //inside initState()
    _animationController = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    _animationController?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animateScanAnimation(true);
      } else if (status == AnimationStatus.dismissed) {
        animateScanAnimation(false);
      }
    });

    if (!scanning) {
      animateScanAnimation(false); // Starts the animation.
      setState(() {
        _animationStopped = false;
        scanning = true;
      });
    } else {
      setState(() {
        _animationStopped = true;
        scanning = false;
      });
    }

    _animationController?.forward(from: 0.0);
    // if (_mpController.roundResultsListenable[widget.category.obs] == null) {
    //   _mpController.roundResultsListenable[widget.category.obs] = 0.obs;
    // }
    // _mpController.roundResultsListenable[widget.category.obs]?.listen((result) {
    //   _logger.i("round results received stop animation for ${widget.category}",
    //       result);
    //   setState(() {
    //     _animationStopped = true;
    //   });
    // });
  }

  void animateScanAnimation(bool reverse) {
    if (reverse) {
      _animationController?.reverse(from: 1.0);
    } else {
      _animationController?.forward(from: 0.0);
    }
  }
}

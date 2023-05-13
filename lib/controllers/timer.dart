// import 'dart:async';
// import 'package:nouns_flutter/controllers/animations_controller.dart';
// import 'package:get/get.dart';

// class TimerController extends GetxController {
//   final _maxTime = 90.obs;
//   final _timeRemaining = 90.obs;
//   late Timer? timer;
//   final _timePaused = false.obs;

//   void startTimer(int maxValue, {void Function()? onComplete}) {
//     AnimationsController _animationsController = Get.find();
//     _animationsController.t90SecTimerAnimation?.currentIndex = 0;
//     _maxTime.value = maxValue;
//     _timeRemaining.value = maxValue;

//     // Timer syncTimer = Timer.periodic(const Duration(milliseconds:100), (timer){
//     //    _animationsController.t90SecTimerAnimation?.currentIndex == (_timeRemaining.value == 90) ? 0 :
//     //        (90 - _timeRemaining.value) ~/ _animationsController.t90SecStepTime;
//     // });

//     timer = Timer.periodic( Duration(seconds:1), (timer) {
//       if (_timeRemaining.value > 0 && !_timePaused.value) {
//         _timeRemaining.value--;
//         print("time remining ${_timeRemaining.value}");
//             } else if (_timeRemaining.value == 0) {
//         _stopTimer();
//         onComplete?.call();
//       }
//     });
//   }

//   void pauseTimer(int seconds, {void Function()? onComplete}) {
//     _togglePauseTimer();
//     Future.delayed(Duration(seconds: seconds), () {
//       _togglePauseTimer();
//       onComplete?.call();
//     });
//   }

//   void _togglePauseTimer() {
//     _timePaused.value = !(_timePaused.value);
//   }

//   void _stopTimer() {
//     timer?.cancel();
//   }

//   void rewindTimer(int seconds) {
//     if (_timeRemaining.value + seconds >= _maxTime.value) {
//       _timeRemaining.value = _maxTime.value;
//     } else {
//       _timeRemaining.value += seconds;
//     }
//   }

//   void reset() {
//     _timeRemaining.value = 90;
//     _stopTimer();
//   }

//   set timeRemaining(int value) => _timeRemaining.value = value;
//   int get timeRemaining => _timeRemaining.value;
// }

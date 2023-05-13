import 'package:flame_audio/flame_audio.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:logger/logger.dart';

Logger logger = Get.find();

void playButtonClickSound() {
  //FlameAudio.play('Button_click_and_Keyboard.mp3');
}
void playBackButtonClickSound() {
  // FlameAudio.play('Back_button.mp3');
}

// void playWrongAnswerSound() {
//   FlameAudio.play('wrong_answer.mp3');
// }

// void playRejectAnswerSound() {
//   FlameAudio.play('reject_answer.mp3');
// }

// void playCorrectAnswerSound() {
//   FlameAudio.play('correct_answer.wav');
// }

// void playAutofillSound() {
//   FlameAudio.play('autofill.wav');
// }

// void playTimeMachineSound() {
//   FlameAudio.play('timemachine.wav');
// }

// void playTimeFreezeSound() {
//   FlameAudio.play('timefreeze.mp3');
// }

void playHeartbeatSound() {
  //FlameAudio.play('Heart_beat.mp3');
}

void playPerfectScoreSound() {
  // FlameAudio.play('Perfect_score_&_Winner.mp3');
}

void playWinnerSound() {
  // FlameAudio.play('Perfect_score_&_Winner.mp3');
}

void playTikTokSound() {
  // FlameAudio.play('Tick_tock.mp3');
}

void playSustainedComboSound() {
  // FlameAudio.play('Sustained_Combo.mp3');
}

void playWordComboSound() {
  // FlameAudio.play('Word_Combo.mp3');
}

void playTimeUpSound() {
  //FlameAudio.play('Time_Up_SP.mp3');
}

void playSPBackgroundMusic() {
  //stopSPBackgroundMusic();
  // FlameAudio.bgm.play('Background_Music_SP_Loop.mp3', volume: 0.3);
}

void stopSPBackgroundMusic() {
  // logger.i('stopping background music');
  // FlameAudio.bgm.stop();
}

void cacheSounds() async {
  // await FlameAudio.audioCache.loadAll([
  //   'Back_button.mp3',
  //   'Background_Music_SP_Loop.mp3',
  //   'Button_click_and_Keyboard.mp3',
  //   'Heart_beat.mp3',
  //   'Perfect_score_&_Winner.mp3',
  //   'Sustained_Combo.mp3',
  //   'Tick_tock.mp3',
  //   'Time_Up_SP.mp3',
  //   'Word_Combo.mp3',
  // ]);

  // FlameAudio.bgm.initialize();
}

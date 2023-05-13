import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';


class SpriteSheetWidget extends FlameGame with TapDetector {
  final void Function()? onPressed;
  final String spritesheet;
  final int frameCount;
  final Vector2 textureSize;
  final Vector2 animationSize;
  final double stepTime;

  SpriteSheetWidget(
      {this.onPressed,
      required this.frameCount,
      required this.spritesheet,
      required this.stepTime,
      required this.animationSize,
      required this.textureSize});

  SpriteAnimation? _animation;

  SpriteAnimation get animation => _animation!;

  @override
  void onTapDown(TapDownInfo info) {
    print(info.eventPosition.game);
    onPressed?.call();
  }

  @override
  Future<void> onLoad() async {
    final spriteSheet = SpriteSheet(
      image: await images.load('SinglePlayer/$spritesheet'),
      srcSize: textureSize,
    );
    final spriteSize = textureSize;

    final animation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, to: 60);
      

    final component1 = SpriteAnimationComponent(
      animation: animation,
      // scale: Vector2(0.4, 0.4),
      // position: Vector2(160, -5),
      size: spriteSize,
    );

    add(
      component1
        
    );
  }

  // @override
  // Future<void> onLoad() async {
  //   super.onLoad();
  //   _animation = await loadSpriteAnimation(
  //     'SinglePlayer/$spritesheet',
  //     SpriteAnimationData.sequenced(
  //       amount: frameCount,
  //       textureSize: textureSize,
  //       stepTime: stepTime,
  //       loop: true,
  //     ),
  //   );

  //   final animationComponent = SpriteAnimationComponent(
  //     animation: animation,
  //     size: animationSize,
  //     removeOnFinish: false,
  //     playing: true,
  //   );

  //   resetAnimation();
  //   animation.onComplete = resetAnimation;

  //   await add(animationComponent);
  // }

  // /// Set the animation to the first frame by tricking the animation
  // /// into thinking it finished the last frame.
  // void resetAnimation() {
  //   animation
  //     ..currentIndex = _animation!.frames.length - 1
  //     ..update(0.1)
  //     ..currentIndex = 0;
  // }

  // /// Plays the animation.
  // void playAnimation() => animation.reset();

  // /// Returns whether the animation is playing or not.
  // bool isAnimationPlaying() => !animation.isFirstFrame;
}

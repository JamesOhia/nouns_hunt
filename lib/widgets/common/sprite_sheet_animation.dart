import 'package:flame/game.dart';
import 'package:flame_fire_atlas/flame_fire_atlas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/controllers/sp_lifelines.dart';
import 'package:nouns_flutter/utils/audio.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:nouns_flutter/controllers/sp_gameplay.dart';
import 'package:nouns_flutter/controllers/sp_lifelines.dart' as lifelines;
import 'package:nouns_flutter/controllers/timer.dart';
import 'package:nouns_flutter/controllers/user_controller.dart';
import 'package:nouns_flutter/utils/string_extensions.dart';
import 'package:flutter_sprite/flutter_sprite.dart';



class SpritesheetAnimation extends StatefulWidget {
  final String spritesheet;
  const SpritesheetAnimation({required this.spritesheet, super.key});

  @override
  State<SpritesheetAnimation> createState() => _SpritesheetAnimationState();
}

class _SpritesheetAnimationState extends State<SpritesheetAnimation>{
  Future<Sprite?> _sprite = Future.value(null);

  @override
  Widget build(BuildContext context){
      return LayoutBuilder(builder: (context, constraints){
        return Container(width: constraints.maxWidth, height: constraints.maxHeight, child: FutureBuilder<Sprite?>(
        future: _sprite, 
        builder: (BuildContext context, AsyncSnapshot<Sprite?> snapshot) {
          print("sprite future resolved");          return snapshot.hasData && snapshot.data != null ? SpriteWidget(snapshot.data!) : Container();
        }));
      });
  }

  initState(){
    super.initState();
    _sprite = Sprite.load('assets/images/SinglePlayer/lifelines/${widget.spritesheet}.json');
  }
}
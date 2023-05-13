// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_match_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NewMatchState _$$_NewMatchStateFromJson(Map<String, dynamic> json) =>
    _$_NewMatchState(
      alias: json['alias'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      rounds: json['rounds'] as int,
      difficulty: json['difficulty'] as int,
      host: json['host'] as String,
      presencesSummary: (json['presencesSummary'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, PresenceSummary.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$_NewMatchStateToJson(_$_NewMatchState instance) =>
    <String, dynamic>{
      'alias': instance.alias,
      'categories': instance.categories,
      'rounds': instance.rounds,
      'difficulty': instance.difficulty,
      'host': instance.host,
      'presencesSummary':
          instance.presencesSummary.map((k, e) => MapEntry(k, e.toJson())),
    };

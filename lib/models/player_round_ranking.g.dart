// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_round_ranking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlayerRoundRanking _$$_PlayerRoundRankingFromJson(
        Map<String, dynamic> json) =>
    _$_PlayerRoundRanking(
      score: json['score'] as int,
      ranking: json['ranking'] as int,
      user: PresenceSummary.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PlayerRoundRankingToJson(
        _$_PlayerRoundRanking instance) =>
    <String, dynamic>{
      'score': instance.score,
      'ranking': instance.ranking,
      'user': instance.user.toJson(),
    };

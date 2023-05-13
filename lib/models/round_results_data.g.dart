// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round_results_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RoundResultsData _$$_RoundResultsDataFromJson(Map<String, dynamic> json) =>
    _$_RoundResultsData(
      results: Map<String, int>.from(json['results'] as Map),
      ranking: (json['ranking'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$$_RoundResultsDataToJson(_$_RoundResultsData instance) =>
    <String, dynamic>{
      'results': instance.results,
      'ranking': instance.ranking,
    };

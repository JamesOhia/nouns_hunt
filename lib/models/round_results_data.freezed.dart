// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'round_results_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RoundResultsData _$RoundResultsDataFromJson(Map<String, dynamic> json) {
  return _RoundResultsData.fromJson(json);
}

/// @nodoc
mixin _$RoundResultsData {
  Map<String, int> get results => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get ranking => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoundResultsDataCopyWith<RoundResultsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoundResultsDataCopyWith<$Res> {
  factory $RoundResultsDataCopyWith(
          RoundResultsData value, $Res Function(RoundResultsData) then) =
      _$RoundResultsDataCopyWithImpl<$Res, RoundResultsData>;
  @useResult
  $Res call({Map<String, int> results, List<Map<String, dynamic>> ranking});
}

/// @nodoc
class _$RoundResultsDataCopyWithImpl<$Res, $Val extends RoundResultsData>
    implements $RoundResultsDataCopyWith<$Res> {
  _$RoundResultsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
    Object? ranking = null,
  }) {
    return _then(_value.copyWith(
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      ranking: null == ranking
          ? _value.ranking
          : ranking // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RoundResultsDataCopyWith<$Res>
    implements $RoundResultsDataCopyWith<$Res> {
  factory _$$_RoundResultsDataCopyWith(
          _$_RoundResultsData value, $Res Function(_$_RoundResultsData) then) =
      __$$_RoundResultsDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, int> results, List<Map<String, dynamic>> ranking});
}

/// @nodoc
class __$$_RoundResultsDataCopyWithImpl<$Res>
    extends _$RoundResultsDataCopyWithImpl<$Res, _$_RoundResultsData>
    implements _$$_RoundResultsDataCopyWith<$Res> {
  __$$_RoundResultsDataCopyWithImpl(
      _$_RoundResultsData _value, $Res Function(_$_RoundResultsData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
    Object? ranking = null,
  }) {
    return _then(_$_RoundResultsData(
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      ranking: null == ranking
          ? _value._ranking
          : ranking // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RoundResultsData
    with DiagnosticableTreeMixin
    implements _RoundResultsData {
  const _$_RoundResultsData(
      {required final Map<String, int> results,
      required final List<Map<String, dynamic>> ranking})
      : _results = results,
        _ranking = ranking;

  factory _$_RoundResultsData.fromJson(Map<String, dynamic> json) =>
      _$$_RoundResultsDataFromJson(json);

  final Map<String, int> _results;
  @override
  Map<String, int> get results {
    if (_results is EqualUnmodifiableMapView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_results);
  }

  final List<Map<String, dynamic>> _ranking;
  @override
  List<Map<String, dynamic>> get ranking {
    if (_ranking is EqualUnmodifiableListView) return _ranking;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ranking);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RoundResultsData(results: $results, ranking: $ranking)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RoundResultsData'))
      ..add(DiagnosticsProperty('results', results))
      ..add(DiagnosticsProperty('ranking', ranking));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RoundResultsData &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            const DeepCollectionEquality().equals(other._ranking, _ranking));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_results),
      const DeepCollectionEquality().hash(_ranking));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RoundResultsDataCopyWith<_$_RoundResultsData> get copyWith =>
      __$$_RoundResultsDataCopyWithImpl<_$_RoundResultsData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RoundResultsDataToJson(
      this,
    );
  }
}

abstract class _RoundResultsData implements RoundResultsData {
  const factory _RoundResultsData(
      {required final Map<String, int> results,
      required final List<Map<String, dynamic>> ranking}) = _$_RoundResultsData;

  factory _RoundResultsData.fromJson(Map<String, dynamic> json) =
      _$_RoundResultsData.fromJson;

  @override
  Map<String, int> get results;
  @override
  List<Map<String, dynamic>> get ranking;
  @override
  @JsonKey(ignore: true)
  _$$_RoundResultsDataCopyWith<_$_RoundResultsData> get copyWith =>
      throw _privateConstructorUsedError;
}

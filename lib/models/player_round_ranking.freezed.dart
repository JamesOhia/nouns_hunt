// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_round_ranking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlayerRoundRanking _$PlayerRoundRankingFromJson(Map<String, dynamic> json) {
  return _PlayerRoundRanking.fromJson(json);
}

/// @nodoc
mixin _$PlayerRoundRanking {
  int get score => throw _privateConstructorUsedError;
  int get ranking => throw _privateConstructorUsedError;
  PresenceSummary get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerRoundRankingCopyWith<PlayerRoundRanking> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerRoundRankingCopyWith<$Res> {
  factory $PlayerRoundRankingCopyWith(
          PlayerRoundRanking value, $Res Function(PlayerRoundRanking) then) =
      _$PlayerRoundRankingCopyWithImpl<$Res, PlayerRoundRanking>;
  @useResult
  $Res call({int score, int ranking, PresenceSummary user});

  $PresenceSummaryCopyWith<$Res> get user;
}

/// @nodoc
class _$PlayerRoundRankingCopyWithImpl<$Res, $Val extends PlayerRoundRanking>
    implements $PlayerRoundRankingCopyWith<$Res> {
  _$PlayerRoundRankingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
    Object? ranking = null,
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      ranking: null == ranking
          ? _value.ranking
          : ranking // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as PresenceSummary,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PresenceSummaryCopyWith<$Res> get user {
    return $PresenceSummaryCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PlayerRoundRankingCopyWith<$Res>
    implements $PlayerRoundRankingCopyWith<$Res> {
  factory _$$_PlayerRoundRankingCopyWith(_$_PlayerRoundRanking value,
          $Res Function(_$_PlayerRoundRanking) then) =
      __$$_PlayerRoundRankingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int score, int ranking, PresenceSummary user});

  @override
  $PresenceSummaryCopyWith<$Res> get user;
}

/// @nodoc
class __$$_PlayerRoundRankingCopyWithImpl<$Res>
    extends _$PlayerRoundRankingCopyWithImpl<$Res, _$_PlayerRoundRanking>
    implements _$$_PlayerRoundRankingCopyWith<$Res> {
  __$$_PlayerRoundRankingCopyWithImpl(
      _$_PlayerRoundRanking _value, $Res Function(_$_PlayerRoundRanking) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
    Object? ranking = null,
    Object? user = null,
  }) {
    return _then(_$_PlayerRoundRanking(
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      ranking: null == ranking
          ? _value.ranking
          : ranking // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as PresenceSummary,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlayerRoundRanking
    with DiagnosticableTreeMixin
    implements _PlayerRoundRanking {
  const _$_PlayerRoundRanking(
      {required this.score, required this.ranking, required this.user});

  factory _$_PlayerRoundRanking.fromJson(Map<String, dynamic> json) =>
      _$$_PlayerRoundRankingFromJson(json);

  @override
  final int score;
  @override
  final int ranking;
  @override
  final PresenceSummary user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PlayerRoundRanking(score: $score, ranking: $ranking, user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PlayerRoundRanking'))
      ..add(DiagnosticsProperty('score', score))
      ..add(DiagnosticsProperty('ranking', ranking))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlayerRoundRanking &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.ranking, ranking) || other.ranking == ranking) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, score, ranking, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlayerRoundRankingCopyWith<_$_PlayerRoundRanking> get copyWith =>
      __$$_PlayerRoundRankingCopyWithImpl<_$_PlayerRoundRanking>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlayerRoundRankingToJson(
      this,
    );
  }
}

abstract class _PlayerRoundRanking implements PlayerRoundRanking {
  const factory _PlayerRoundRanking(
      {required final int score,
      required final int ranking,
      required final PresenceSummary user}) = _$_PlayerRoundRanking;

  factory _PlayerRoundRanking.fromJson(Map<String, dynamic> json) =
      _$_PlayerRoundRanking.fromJson;

  @override
  int get score;
  @override
  int get ranking;
  @override
  PresenceSummary get user;
  @override
  @JsonKey(ignore: true)
  _$$_PlayerRoundRankingCopyWith<_$_PlayerRoundRanking> get copyWith =>
      throw _privateConstructorUsedError;
}

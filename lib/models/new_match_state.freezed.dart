// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_match_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NewMatchState _$NewMatchStateFromJson(Map<String, dynamic> json) {
  return _NewMatchState.fromJson(json);
}

/// @nodoc
mixin _$NewMatchState {
  String get alias => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;
  int get rounds => throw _privateConstructorUsedError;
  int get difficulty => throw _privateConstructorUsedError;
  String get host => throw _privateConstructorUsedError;
  Map<String, PresenceSummary> get presencesSummary =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NewMatchStateCopyWith<NewMatchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewMatchStateCopyWith<$Res> {
  factory $NewMatchStateCopyWith(
          NewMatchState value, $Res Function(NewMatchState) then) =
      _$NewMatchStateCopyWithImpl<$Res, NewMatchState>;
  @useResult
  $Res call(
      {String alias,
      List<String> categories,
      int rounds,
      int difficulty,
      String host,
      Map<String, PresenceSummary> presencesSummary});
}

/// @nodoc
class _$NewMatchStateCopyWithImpl<$Res, $Val extends NewMatchState>
    implements $NewMatchStateCopyWith<$Res> {
  _$NewMatchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alias = null,
    Object? categories = null,
    Object? rounds = null,
    Object? difficulty = null,
    Object? host = null,
    Object? presencesSummary = null,
  }) {
    return _then(_value.copyWith(
      alias: null == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rounds: null == rounds
          ? _value.rounds
          : rounds // ignore: cast_nullable_to_non_nullable
              as int,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as int,
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
      presencesSummary: null == presencesSummary
          ? _value.presencesSummary
          : presencesSummary // ignore: cast_nullable_to_non_nullable
              as Map<String, PresenceSummary>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NewMatchStateCopyWith<$Res>
    implements $NewMatchStateCopyWith<$Res> {
  factory _$$_NewMatchStateCopyWith(
          _$_NewMatchState value, $Res Function(_$_NewMatchState) then) =
      __$$_NewMatchStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String alias,
      List<String> categories,
      int rounds,
      int difficulty,
      String host,
      Map<String, PresenceSummary> presencesSummary});
}

/// @nodoc
class __$$_NewMatchStateCopyWithImpl<$Res>
    extends _$NewMatchStateCopyWithImpl<$Res, _$_NewMatchState>
    implements _$$_NewMatchStateCopyWith<$Res> {
  __$$_NewMatchStateCopyWithImpl(
      _$_NewMatchState _value, $Res Function(_$_NewMatchState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alias = null,
    Object? categories = null,
    Object? rounds = null,
    Object? difficulty = null,
    Object? host = null,
    Object? presencesSummary = null,
  }) {
    return _then(_$_NewMatchState(
      alias: null == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rounds: null == rounds
          ? _value.rounds
          : rounds // ignore: cast_nullable_to_non_nullable
              as int,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as int,
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
      presencesSummary: null == presencesSummary
          ? _value._presencesSummary
          : presencesSummary // ignore: cast_nullable_to_non_nullable
              as Map<String, PresenceSummary>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NewMatchState with DiagnosticableTreeMixin implements _NewMatchState {
  const _$_NewMatchState(
      {required this.alias,
      required final List<String> categories,
      required this.rounds,
      required this.difficulty,
      required this.host,
      required final Map<String, PresenceSummary> presencesSummary})
      : _categories = categories,
        _presencesSummary = presencesSummary;

  factory _$_NewMatchState.fromJson(Map<String, dynamic> json) =>
      _$$_NewMatchStateFromJson(json);

  @override
  final String alias;
  final List<String> _categories;
  @override
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  final int rounds;
  @override
  final int difficulty;
  @override
  final String host;
  final Map<String, PresenceSummary> _presencesSummary;
  @override
  Map<String, PresenceSummary> get presencesSummary {
    if (_presencesSummary is EqualUnmodifiableMapView) return _presencesSummary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_presencesSummary);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NewMatchState(alias: $alias, categories: $categories, rounds: $rounds, difficulty: $difficulty, host: $host, presencesSummary: $presencesSummary)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NewMatchState'))
      ..add(DiagnosticsProperty('alias', alias))
      ..add(DiagnosticsProperty('categories', categories))
      ..add(DiagnosticsProperty('rounds', rounds))
      ..add(DiagnosticsProperty('difficulty', difficulty))
      ..add(DiagnosticsProperty('host', host))
      ..add(DiagnosticsProperty('presencesSummary', presencesSummary));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewMatchState &&
            (identical(other.alias, alias) || other.alias == alias) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.rounds, rounds) || other.rounds == rounds) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.host, host) || other.host == host) &&
            const DeepCollectionEquality()
                .equals(other._presencesSummary, _presencesSummary));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      alias,
      const DeepCollectionEquality().hash(_categories),
      rounds,
      difficulty,
      host,
      const DeepCollectionEquality().hash(_presencesSummary));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewMatchStateCopyWith<_$_NewMatchState> get copyWith =>
      __$$_NewMatchStateCopyWithImpl<_$_NewMatchState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NewMatchStateToJson(
      this,
    );
  }
}

abstract class _NewMatchState implements NewMatchState {
  const factory _NewMatchState(
          {required final String alias,
          required final List<String> categories,
          required final int rounds,
          required final int difficulty,
          required final String host,
          required final Map<String, PresenceSummary> presencesSummary}) =
      _$_NewMatchState;

  factory _NewMatchState.fromJson(Map<String, dynamic> json) =
      _$_NewMatchState.fromJson;

  @override
  String get alias;
  @override
  List<String> get categories;
  @override
  int get rounds;
  @override
  int get difficulty;
  @override
  String get host;
  @override
  Map<String, PresenceSummary> get presencesSummary;
  @override
  @JsonKey(ignore: true)
  _$$_NewMatchStateCopyWith<_$_NewMatchState> get copyWith =>
      throw _privateConstructorUsedError;
}

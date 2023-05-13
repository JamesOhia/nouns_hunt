// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'presence_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PresenceSummary _$PresenceSummaryFromJson(Map<String, dynamic> json) {
  return _PresenceSummary.fromJson(json);
}

/// @nodoc
mixin _$PresenceSummary {
  String get avatar => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PresenceSummaryCopyWith<PresenceSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresenceSummaryCopyWith<$Res> {
  factory $PresenceSummaryCopyWith(
          PresenceSummary value, $Res Function(PresenceSummary) then) =
      _$PresenceSummaryCopyWithImpl<$Res, PresenceSummary>;
  @useResult
  $Res call({String avatar, String country, String userId, String username});
}

/// @nodoc
class _$PresenceSummaryCopyWithImpl<$Res, $Val extends PresenceSummary>
    implements $PresenceSummaryCopyWith<$Res> {
  _$PresenceSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? avatar = null,
    Object? country = null,
    Object? userId = null,
    Object? username = null,
  }) {
    return _then(_value.copyWith(
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PresenceSummaryCopyWith<$Res>
    implements $PresenceSummaryCopyWith<$Res> {
  factory _$$_PresenceSummaryCopyWith(
          _$_PresenceSummary value, $Res Function(_$_PresenceSummary) then) =
      __$$_PresenceSummaryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String avatar, String country, String userId, String username});
}

/// @nodoc
class __$$_PresenceSummaryCopyWithImpl<$Res>
    extends _$PresenceSummaryCopyWithImpl<$Res, _$_PresenceSummary>
    implements _$$_PresenceSummaryCopyWith<$Res> {
  __$$_PresenceSummaryCopyWithImpl(
      _$_PresenceSummary _value, $Res Function(_$_PresenceSummary) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? avatar = null,
    Object? country = null,
    Object? userId = null,
    Object? username = null,
  }) {
    return _then(_$_PresenceSummary(
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PresenceSummary
    with DiagnosticableTreeMixin
    implements _PresenceSummary {
  const _$_PresenceSummary(
      {required this.avatar,
      required this.country,
      required this.userId,
      required this.username});

  factory _$_PresenceSummary.fromJson(Map<String, dynamic> json) =>
      _$$_PresenceSummaryFromJson(json);

  @override
  final String avatar;
  @override
  final String country;
  @override
  final String userId;
  @override
  final String username;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PresenceSummary(avatar: $avatar, country: $country, userId: $userId, username: $username)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PresenceSummary'))
      ..add(DiagnosticsProperty('avatar', avatar))
      ..add(DiagnosticsProperty('country', country))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('username', username));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PresenceSummary &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, avatar, country, userId, username);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PresenceSummaryCopyWith<_$_PresenceSummary> get copyWith =>
      __$$_PresenceSummaryCopyWithImpl<_$_PresenceSummary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PresenceSummaryToJson(
      this,
    );
  }
}

abstract class _PresenceSummary implements PresenceSummary {
  const factory _PresenceSummary(
      {required final String avatar,
      required final String country,
      required final String userId,
      required final String username}) = _$_PresenceSummary;

  factory _PresenceSummary.fromJson(Map<String, dynamic> json) =
      _$_PresenceSummary.fromJson;

  @override
  String get avatar;
  @override
  String get country;
  @override
  String get userId;
  @override
  String get username;
  @override
  @JsonKey(ignore: true)
  _$$_PresenceSummaryCopyWith<_$_PresenceSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

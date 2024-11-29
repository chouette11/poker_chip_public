// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GameEntity _$GameEntityFromJson(Map<String, dynamic> json) {
  return _GameEntity.fromJson(json);
}

/// @nodoc
mixin _$GameEntity {
  String get uid => throw _privateConstructorUsedError;
  GameTypeEnum get type => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameEntityCopyWith<GameEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameEntityCopyWith<$Res> {
  factory $GameEntityCopyWith(
          GameEntity value, $Res Function(GameEntity) then) =
      _$GameEntityCopyWithImpl<$Res, GameEntity>;
  @useResult
  $Res call({String uid, GameTypeEnum type, int score});
}

/// @nodoc
class _$GameEntityCopyWithImpl<$Res, $Val extends GameEntity>
    implements $GameEntityCopyWith<$Res> {
  _$GameEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? type = null,
    Object? score = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as GameTypeEnum,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameEntityImplCopyWith<$Res>
    implements $GameEntityCopyWith<$Res> {
  factory _$$GameEntityImplCopyWith(
          _$GameEntityImpl value, $Res Function(_$GameEntityImpl) then) =
      __$$GameEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uid, GameTypeEnum type, int score});
}

/// @nodoc
class __$$GameEntityImplCopyWithImpl<$Res>
    extends _$GameEntityCopyWithImpl<$Res, _$GameEntityImpl>
    implements _$$GameEntityImplCopyWith<$Res> {
  __$$GameEntityImplCopyWithImpl(
      _$GameEntityImpl _value, $Res Function(_$GameEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? type = null,
    Object? score = null,
  }) {
    return _then(_$GameEntityImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as GameTypeEnum,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameEntityImpl extends _GameEntity {
  const _$GameEntityImpl(
      {required this.uid, required this.type, required this.score})
      : super._();

  factory _$GameEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameEntityImplFromJson(json);

  @override
  final String uid;
  @override
  final GameTypeEnum type;
  @override
  final int score;

  @override
  String toString() {
    return 'GameEntity(uid: $uid, type: $type, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameEntityImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, uid, type, score);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameEntityImplCopyWith<_$GameEntityImpl> get copyWith =>
      __$$GameEntityImplCopyWithImpl<_$GameEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameEntityImplToJson(
      this,
    );
  }
}

abstract class _GameEntity extends GameEntity {
  const factory _GameEntity(
      {required final String uid,
      required final GameTypeEnum type,
      required final int score}) = _$GameEntityImpl;
  const _GameEntity._() : super._();

  factory _GameEntity.fromJson(Map<String, dynamic> json) =
      _$GameEntityImpl.fromJson;

  @override
  String get uid;
  @override
  GameTypeEnum get type;
  @override
  int get score;
  @override
  @JsonKey(ignore: true)
  _$$GameEntityImplCopyWith<_$GameEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

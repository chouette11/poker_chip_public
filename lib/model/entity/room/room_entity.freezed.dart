// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RoomEntity _$RoomEntityFromJson(Map<String, dynamic> json) {
  return _RoomEntity.fromJson(json);
}

/// @nodoc
mixin _$RoomEntity {
  int get id => throw _privateConstructorUsedError;
  int get stack => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoomEntityCopyWith<RoomEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomEntityCopyWith<$Res> {
  factory $RoomEntityCopyWith(
          RoomEntity value, $Res Function(RoomEntity) then) =
      _$RoomEntityCopyWithImpl<$Res, RoomEntity>;
  @useResult
  $Res call({int id, int stack, DateTime createdAt});
}

/// @nodoc
class _$RoomEntityCopyWithImpl<$Res, $Val extends RoomEntity>
    implements $RoomEntityCopyWith<$Res> {
  _$RoomEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? stack = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      stack: null == stack
          ? _value.stack
          : stack // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoomEntityImplCopyWith<$Res>
    implements $RoomEntityCopyWith<$Res> {
  factory _$$RoomEntityImplCopyWith(
          _$RoomEntityImpl value, $Res Function(_$RoomEntityImpl) then) =
      __$$RoomEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int stack, DateTime createdAt});
}

/// @nodoc
class __$$RoomEntityImplCopyWithImpl<$Res>
    extends _$RoomEntityCopyWithImpl<$Res, _$RoomEntityImpl>
    implements _$$RoomEntityImplCopyWith<$Res> {
  __$$RoomEntityImplCopyWithImpl(
      _$RoomEntityImpl _value, $Res Function(_$RoomEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? stack = null,
    Object? createdAt = null,
  }) {
    return _then(_$RoomEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      stack: null == stack
          ? _value.stack
          : stack // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomEntityImpl extends _RoomEntity {
  const _$RoomEntityImpl(
      {required this.id, required this.stack, required this.createdAt})
      : super._();

  factory _$RoomEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomEntityImplFromJson(json);

  @override
  final int id;
  @override
  final int stack;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'RoomEntity(id: $id, stack: $stack, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.stack, stack) || other.stack == stack) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, stack, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomEntityImplCopyWith<_$RoomEntityImpl> get copyWith =>
      __$$RoomEntityImplCopyWithImpl<_$RoomEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomEntityImplToJson(
      this,
    );
  }
}

abstract class _RoomEntity extends RoomEntity {
  const factory _RoomEntity(
      {required final int id,
      required final int stack,
      required final DateTime createdAt}) = _$RoomEntityImpl;
  const _RoomEntity._() : super._();

  factory _RoomEntity.fromJson(Map<String, dynamic> json) =
      _$RoomEntityImpl.fromJson;

  @override
  int get id;
  @override
  int get stack;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$RoomEntityImplCopyWith<_$RoomEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

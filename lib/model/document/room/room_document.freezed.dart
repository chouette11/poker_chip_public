// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RoomDocument _$RoomDocumentFromJson(Map<String, dynamic> json) {
  return _RoomDocument.fromJson(json);
}

/// @nodoc
mixin _$RoomDocument {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'stack')
  int get stack => throw _privateConstructorUsedError;
  @TimestampConverter()
  @JsonKey(name: 'createdAt')
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoomDocumentCopyWith<RoomDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomDocumentCopyWith<$Res> {
  factory $RoomDocumentCopyWith(
          RoomDocument value, $Res Function(RoomDocument) then) =
      _$RoomDocumentCopyWithImpl<$Res, RoomDocument>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'stack') int stack,
      @TimestampConverter() @JsonKey(name: 'createdAt') DateTime createdAt});
}

/// @nodoc
class _$RoomDocumentCopyWithImpl<$Res, $Val extends RoomDocument>
    implements $RoomDocumentCopyWith<$Res> {
  _$RoomDocumentCopyWithImpl(this._value, this._then);

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
abstract class _$$RoomDocumentImplCopyWith<$Res>
    implements $RoomDocumentCopyWith<$Res> {
  factory _$$RoomDocumentImplCopyWith(
          _$RoomDocumentImpl value, $Res Function(_$RoomDocumentImpl) then) =
      __$$RoomDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'stack') int stack,
      @TimestampConverter() @JsonKey(name: 'createdAt') DateTime createdAt});
}

/// @nodoc
class __$$RoomDocumentImplCopyWithImpl<$Res>
    extends _$RoomDocumentCopyWithImpl<$Res, _$RoomDocumentImpl>
    implements _$$RoomDocumentImplCopyWith<$Res> {
  __$$RoomDocumentImplCopyWithImpl(
      _$RoomDocumentImpl _value, $Res Function(_$RoomDocumentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? stack = null,
    Object? createdAt = null,
  }) {
    return _then(_$RoomDocumentImpl(
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
class _$RoomDocumentImpl extends _RoomDocument {
  const _$RoomDocumentImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'stack') required this.stack,
      @TimestampConverter()
      @JsonKey(name: 'createdAt')
      required this.createdAt})
      : super._();

  factory _$RoomDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomDocumentImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'stack')
  final int stack;
  @override
  @TimestampConverter()
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @override
  String toString() {
    return 'RoomDocument(id: $id, stack: $stack, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomDocumentImpl &&
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
  _$$RoomDocumentImplCopyWith<_$RoomDocumentImpl> get copyWith =>
      __$$RoomDocumentImplCopyWithImpl<_$RoomDocumentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomDocumentImplToJson(
      this,
    );
  }
}

abstract class _RoomDocument extends RoomDocument {
  const factory _RoomDocument(
      {@JsonKey(name: 'id') required final int id,
      @JsonKey(name: 'stack') required final int stack,
      @TimestampConverter()
      @JsonKey(name: 'createdAt')
      required final DateTime createdAt}) = _$RoomDocumentImpl;
  const _RoomDocument._() : super._();

  factory _RoomDocument.fromJson(Map<String, dynamic> json) =
      _$RoomDocumentImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'stack')
  int get stack;
  @override
  @TimestampConverter()
  @JsonKey(name: 'createdAt')
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$RoomDocumentImplCopyWith<_$RoomDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

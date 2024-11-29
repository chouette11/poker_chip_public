// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'side_pot_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SidePotEntity _$SidePotEntityFromJson(Map<String, dynamic> json) {
  return _SidePotEntity.fromJson(json);
}

/// @nodoc
mixin _$SidePotEntity {
  List<String> get uids => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  List<String> get allinUids => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SidePotEntityCopyWith<SidePotEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SidePotEntityCopyWith<$Res> {
  factory $SidePotEntityCopyWith(
          SidePotEntity value, $Res Function(SidePotEntity) then) =
      _$SidePotEntityCopyWithImpl<$Res, SidePotEntity>;
  @useResult
  $Res call({List<String> uids, int size, List<String> allinUids});
}

/// @nodoc
class _$SidePotEntityCopyWithImpl<$Res, $Val extends SidePotEntity>
    implements $SidePotEntityCopyWith<$Res> {
  _$SidePotEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uids = null,
    Object? size = null,
    Object? allinUids = null,
  }) {
    return _then(_value.copyWith(
      uids: null == uids
          ? _value.uids
          : uids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      allinUids: null == allinUids
          ? _value.allinUids
          : allinUids // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SidePotEntityImplCopyWith<$Res>
    implements $SidePotEntityCopyWith<$Res> {
  factory _$$SidePotEntityImplCopyWith(
          _$SidePotEntityImpl value, $Res Function(_$SidePotEntityImpl) then) =
      __$$SidePotEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> uids, int size, List<String> allinUids});
}

/// @nodoc
class __$$SidePotEntityImplCopyWithImpl<$Res>
    extends _$SidePotEntityCopyWithImpl<$Res, _$SidePotEntityImpl>
    implements _$$SidePotEntityImplCopyWith<$Res> {
  __$$SidePotEntityImplCopyWithImpl(
      _$SidePotEntityImpl _value, $Res Function(_$SidePotEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uids = null,
    Object? size = null,
    Object? allinUids = null,
  }) {
    return _then(_$SidePotEntityImpl(
      uids: null == uids
          ? _value._uids
          : uids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      allinUids: null == allinUids
          ? _value._allinUids
          : allinUids // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SidePotEntityImpl extends _SidePotEntity {
  const _$SidePotEntityImpl(
      {required final List<String> uids,
      required this.size,
      required final List<String> allinUids})
      : _uids = uids,
        _allinUids = allinUids,
        super._();

  factory _$SidePotEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$SidePotEntityImplFromJson(json);

  final List<String> _uids;
  @override
  List<String> get uids {
    if (_uids is EqualUnmodifiableListView) return _uids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_uids);
  }

  @override
  final int size;
  final List<String> _allinUids;
  @override
  List<String> get allinUids {
    if (_allinUids is EqualUnmodifiableListView) return _allinUids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allinUids);
  }

  @override
  String toString() {
    return 'SidePotEntity(uids: $uids, size: $size, allinUids: $allinUids)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SidePotEntityImpl &&
            const DeepCollectionEquality().equals(other._uids, _uids) &&
            (identical(other.size, size) || other.size == size) &&
            const DeepCollectionEquality()
                .equals(other._allinUids, _allinUids));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_uids),
      size,
      const DeepCollectionEquality().hash(_allinUids));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SidePotEntityImplCopyWith<_$SidePotEntityImpl> get copyWith =>
      __$$SidePotEntityImplCopyWithImpl<_$SidePotEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SidePotEntityImplToJson(
      this,
    );
  }
}

abstract class _SidePotEntity extends SidePotEntity {
  const factory _SidePotEntity(
      {required final List<String> uids,
      required final int size,
      required final List<String> allinUids}) = _$SidePotEntityImpl;
  const _SidePotEntity._() : super._();

  factory _SidePotEntity.fromJson(Map<String, dynamic> json) =
      _$SidePotEntityImpl.fromJson;

  @override
  List<String> get uids;
  @override
  int get size;
  @override
  List<String> get allinUids;
  @override
  @JsonKey(ignore: true)
  _$$SidePotEntityImplCopyWith<_$SidePotEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

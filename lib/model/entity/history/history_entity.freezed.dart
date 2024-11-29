// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HistoryEntity _$HistoryEntityFromJson(Map<String, dynamic> json) {
  return _HistoryEntity.fromJson(json);
}

/// @nodoc
mixin _$HistoryEntity {
  DateTime get dateTime => throw _privateConstructorUsedError;
  GameTypeEnum get round => throw _privateConstructorUsedError;
  List<UserEntity> get players => throw _privateConstructorUsedError;
  int get pot => throw _privateConstructorUsedError;
  List<SidePotEntity> get sidePots => throw _privateConstructorUsedError;
  int get assignedId => throw _privateConstructorUsedError;
  ActionEntity? get action => throw _privateConstructorUsedError;
  GameEntity? get game => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HistoryEntityCopyWith<HistoryEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryEntityCopyWith<$Res> {
  factory $HistoryEntityCopyWith(
          HistoryEntity value, $Res Function(HistoryEntity) then) =
      _$HistoryEntityCopyWithImpl<$Res, HistoryEntity>;
  @useResult
  $Res call(
      {DateTime dateTime,
      GameTypeEnum round,
      List<UserEntity> players,
      int pot,
      List<SidePotEntity> sidePots,
      int assignedId,
      ActionEntity? action,
      GameEntity? game});

  $ActionEntityCopyWith<$Res>? get action;
  $GameEntityCopyWith<$Res>? get game;
}

/// @nodoc
class _$HistoryEntityCopyWithImpl<$Res, $Val extends HistoryEntity>
    implements $HistoryEntityCopyWith<$Res> {
  _$HistoryEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateTime = null,
    Object? round = null,
    Object? players = null,
    Object? pot = null,
    Object? sidePots = null,
    Object? assignedId = null,
    Object? action = freezed,
    Object? game = freezed,
  }) {
    return _then(_value.copyWith(
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      round: null == round
          ? _value.round
          : round // ignore: cast_nullable_to_non_nullable
              as GameTypeEnum,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<UserEntity>,
      pot: null == pot
          ? _value.pot
          : pot // ignore: cast_nullable_to_non_nullable
              as int,
      sidePots: null == sidePots
          ? _value.sidePots
          : sidePots // ignore: cast_nullable_to_non_nullable
              as List<SidePotEntity>,
      assignedId: null == assignedId
          ? _value.assignedId
          : assignedId // ignore: cast_nullable_to_non_nullable
              as int,
      action: freezed == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as ActionEntity?,
      game: freezed == game
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as GameEntity?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ActionEntityCopyWith<$Res>? get action {
    if (_value.action == null) {
      return null;
    }

    return $ActionEntityCopyWith<$Res>(_value.action!, (value) {
      return _then(_value.copyWith(action: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GameEntityCopyWith<$Res>? get game {
    if (_value.game == null) {
      return null;
    }

    return $GameEntityCopyWith<$Res>(_value.game!, (value) {
      return _then(_value.copyWith(game: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HistoryEntityImplCopyWith<$Res>
    implements $HistoryEntityCopyWith<$Res> {
  factory _$$HistoryEntityImplCopyWith(
          _$HistoryEntityImpl value, $Res Function(_$HistoryEntityImpl) then) =
      __$$HistoryEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime dateTime,
      GameTypeEnum round,
      List<UserEntity> players,
      int pot,
      List<SidePotEntity> sidePots,
      int assignedId,
      ActionEntity? action,
      GameEntity? game});

  @override
  $ActionEntityCopyWith<$Res>? get action;
  @override
  $GameEntityCopyWith<$Res>? get game;
}

/// @nodoc
class __$$HistoryEntityImplCopyWithImpl<$Res>
    extends _$HistoryEntityCopyWithImpl<$Res, _$HistoryEntityImpl>
    implements _$$HistoryEntityImplCopyWith<$Res> {
  __$$HistoryEntityImplCopyWithImpl(
      _$HistoryEntityImpl _value, $Res Function(_$HistoryEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateTime = null,
    Object? round = null,
    Object? players = null,
    Object? pot = null,
    Object? sidePots = null,
    Object? assignedId = null,
    Object? action = freezed,
    Object? game = freezed,
  }) {
    return _then(_$HistoryEntityImpl(
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      round: null == round
          ? _value.round
          : round // ignore: cast_nullable_to_non_nullable
              as GameTypeEnum,
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<UserEntity>,
      pot: null == pot
          ? _value.pot
          : pot // ignore: cast_nullable_to_non_nullable
              as int,
      sidePots: null == sidePots
          ? _value._sidePots
          : sidePots // ignore: cast_nullable_to_non_nullable
              as List<SidePotEntity>,
      assignedId: null == assignedId
          ? _value.assignedId
          : assignedId // ignore: cast_nullable_to_non_nullable
              as int,
      action: freezed == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as ActionEntity?,
      game: freezed == game
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as GameEntity?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HistoryEntityImpl extends _HistoryEntity {
  const _$HistoryEntityImpl(
      {required this.dateTime,
      required this.round,
      required final List<UserEntity> players,
      required this.pot,
      required final List<SidePotEntity> sidePots,
      required this.assignedId,
      this.action,
      this.game})
      : _players = players,
        _sidePots = sidePots,
        super._();

  factory _$HistoryEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryEntityImplFromJson(json);

  @override
  final DateTime dateTime;
  @override
  final GameTypeEnum round;
  final List<UserEntity> _players;
  @override
  List<UserEntity> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  @override
  final int pot;
  final List<SidePotEntity> _sidePots;
  @override
  List<SidePotEntity> get sidePots {
    if (_sidePots is EqualUnmodifiableListView) return _sidePots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sidePots);
  }

  @override
  final int assignedId;
  @override
  final ActionEntity? action;
  @override
  final GameEntity? game;

  @override
  String toString() {
    return 'HistoryEntity(dateTime: $dateTime, round: $round, players: $players, pot: $pot, sidePots: $sidePots, assignedId: $assignedId, action: $action, game: $game)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryEntityImpl &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.round, round) || other.round == round) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            (identical(other.pot, pot) || other.pot == pot) &&
            const DeepCollectionEquality().equals(other._sidePots, _sidePots) &&
            (identical(other.assignedId, assignedId) ||
                other.assignedId == assignedId) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.game, game) || other.game == game));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      dateTime,
      round,
      const DeepCollectionEquality().hash(_players),
      pot,
      const DeepCollectionEquality().hash(_sidePots),
      assignedId,
      action,
      game);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryEntityImplCopyWith<_$HistoryEntityImpl> get copyWith =>
      __$$HistoryEntityImplCopyWithImpl<_$HistoryEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryEntityImplToJson(
      this,
    );
  }
}

abstract class _HistoryEntity extends HistoryEntity {
  const factory _HistoryEntity(
      {required final DateTime dateTime,
      required final GameTypeEnum round,
      required final List<UserEntity> players,
      required final int pot,
      required final List<SidePotEntity> sidePots,
      required final int assignedId,
      final ActionEntity? action,
      final GameEntity? game}) = _$HistoryEntityImpl;
  const _HistoryEntity._() : super._();

  factory _HistoryEntity.fromJson(Map<String, dynamic> json) =
      _$HistoryEntityImpl.fromJson;

  @override
  DateTime get dateTime;
  @override
  GameTypeEnum get round;
  @override
  List<UserEntity> get players;
  @override
  int get pot;
  @override
  List<SidePotEntity> get sidePots;
  @override
  int get assignedId;
  @override
  ActionEntity? get action;
  @override
  GameEntity? get game;
  @override
  @JsonKey(ignore: true)
  _$$HistoryEntityImplCopyWith<_$HistoryEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

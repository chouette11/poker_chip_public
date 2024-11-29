// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HistoryEntityImpl _$$HistoryEntityImplFromJson(Map<String, dynamic> json) =>
    _$HistoryEntityImpl(
      dateTime: DateTime.parse(json['dateTime'] as String),
      round: $enumDecode(_$GameTypeEnumEnumMap, json['round']),
      players: (json['players'] as List<dynamic>)
          .map((e) => UserEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      pot: json['pot'] as int,
      sidePots: (json['sidePots'] as List<dynamic>)
          .map((e) => SidePotEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      assignedId: json['assignedId'] as int,
      action: json['action'] == null
          ? null
          : ActionEntity.fromJson(json['action'] as Map<String, dynamic>),
      game: json['game'] == null
          ? null
          : GameEntity.fromJson(json['game'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$HistoryEntityImplToJson(_$HistoryEntityImpl instance) =>
    <String, dynamic>{
      'dateTime': instance.dateTime.toIso8601String(),
      'round': _$GameTypeEnumEnumMap[instance.round]!,
      'players': instance.players,
      'pot': instance.pot,
      'sidePots': instance.sidePots,
      'assignedId': instance.assignedId,
      'action': instance.action,
      'game': instance.game,
    };

const _$GameTypeEnumEnumMap = {
  GameTypeEnum.sidePot: 'sidePot',
  GameTypeEnum.anty: 'anty',
  GameTypeEnum.btn: 'btn',
  GameTypeEnum.blind: 'blind',
  GameTypeEnum.preFlop: 'preFlop',
  GameTypeEnum.flop: 'flop',
  GameTypeEnum.turn: 'turn',
  GameTypeEnum.river: 'river',
  GameTypeEnum.foldout: 'foldout',
  GameTypeEnum.showdown: 'showdown',
  GameTypeEnum.ranking: 'ranking',
};

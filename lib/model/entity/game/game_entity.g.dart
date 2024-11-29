// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameEntityImpl _$$GameEntityImplFromJson(Map<String, dynamic> json) =>
    _$GameEntityImpl(
      uid: json['uid'] as String,
      type: $enumDecode(_$GameTypeEnumEnumMap, json['type']),
      score: json['score'] as int,
    );

Map<String, dynamic> _$$GameEntityImplToJson(_$GameEntityImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'type': _$GameTypeEnumEnumMap[instance.type]!,
      'score': instance.score,
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

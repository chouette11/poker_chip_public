// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActionEntityImpl _$$ActionEntityImplFromJson(Map<String, dynamic> json) =>
    _$ActionEntityImpl(
      uid: json['uid'] as String,
      type: $enumDecode(_$ActionTypeEnumEnumMap, json['type']),
      optId: json['optId'] as int?,
      score: json['score'] as int,
    );

Map<String, dynamic> _$$ActionEntityImplToJson(_$ActionEntityImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'type': _$ActionTypeEnumEnumMap[instance.type]!,
      'optId': instance.optId,
      'score': instance.score,
    };

const _$ActionTypeEnumEnumMap = {
  ActionTypeEnum.call: 'call',
  ActionTypeEnum.raise: 'raise',
  ActionTypeEnum.fold: 'fold',
  ActionTypeEnum.check: 'check',
  ActionTypeEnum.bet: 'bet',
};

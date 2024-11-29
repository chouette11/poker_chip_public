// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageEntityImpl _$$MessageEntityImplFromJson(Map<String, dynamic> json) =>
    _$MessageEntityImpl(
      type: $enumDecode(_$MessageTypeEnumEnumMap, json['type']),
      content: json['content'],
    );

Map<String, dynamic> _$$MessageEntityImplToJson(_$MessageEntityImpl instance) =>
    <String, dynamic>{
      'type': _$MessageTypeEnumEnumMap[instance.type]!,
      'content': instance.content,
    };

const _$MessageTypeEnumEnumMap = {
  MessageTypeEnum.sit: 'sit',
  MessageTypeEnum.userSetting: 'userSetting',
  MessageTypeEnum.history: 'history',
  MessageTypeEnum.game: 'game',
  MessageTypeEnum.action: 'action',
  MessageTypeEnum.res: 'res',
  MessageTypeEnum.reconnect: 'reconnect',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomEntityImpl _$$RoomEntityImplFromJson(Map<String, dynamic> json) =>
    _$RoomEntityImpl(
      id: json['id'] as int,
      stack: json['stack'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$RoomEntityImplToJson(_$RoomEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stack': instance.stack,
      'createdAt': instance.createdAt.toIso8601String(),
    };

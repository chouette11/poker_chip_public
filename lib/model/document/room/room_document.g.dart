// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomDocumentImpl _$$RoomDocumentImplFromJson(Map<String, dynamic> json) =>
    _$RoomDocumentImpl(
      id: json['id'] as int,
      stack: json['stack'] as int,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$$RoomDocumentImplToJson(_$RoomDocumentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stack': instance.stack,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };

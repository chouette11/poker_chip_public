// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserEntityImpl _$$UserEntityImplFromJson(Map<String, dynamic> json) =>
    _$UserEntityImpl(
      uid: json['uid'] as String,
      assignedId: json['assignedId'] as int,
      name: json['name'] as String?,
      stack: json['stack'] as int,
      isBtn: json['isBtn'] as bool,
      isAction: json['isAction'] as bool,
      isCheck: json['isCheck'] as bool,
      isFold: json['isFold'] as bool,
      isSitOut: json['isSitOut'] as bool,
      score: json['score'] as int,
    );

Map<String, dynamic> _$$UserEntityImplToJson(_$UserEntityImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'assignedId': instance.assignedId,
      'name': instance.name,
      'stack': instance.stack,
      'isBtn': instance.isBtn,
      'isAction': instance.isAction,
      'isCheck': instance.isCheck,
      'isFold': instance.isFold,
      'isSitOut': instance.isSitOut,
      'score': instance.score,
    };

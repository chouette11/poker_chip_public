// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'side_pot_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SidePotEntityImpl _$$SidePotEntityImplFromJson(Map<String, dynamic> json) =>
    _$SidePotEntityImpl(
      uids: (json['uids'] as List<dynamic>).map((e) => e as String).toList(),
      size: json['size'] as int,
      allinUids:
          (json['allinUids'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$SidePotEntityImplToJson(_$SidePotEntityImpl instance) =>
    <String, dynamic>{
      'uids': instance.uids,
      'size': instance.size,
      'allinUids': instance.allinUids,
    };

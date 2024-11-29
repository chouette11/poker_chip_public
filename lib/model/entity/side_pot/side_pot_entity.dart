import 'package:freezed_annotation/freezed_annotation.dart';

part 'side_pot_entity.freezed.dart';

part 'side_pot_entity.g.dart';


@freezed
class SidePotEntity with _$SidePotEntity {
  const SidePotEntity._();

  const factory SidePotEntity({
    required List<String> uids,
    required int size,
    required List<String> allinUids,
  }) = _SidePotEntity;

  factory SidePotEntity.fromJson(Map<String, dynamic> json) =>
      _$SidePotEntityFromJson(json);
}

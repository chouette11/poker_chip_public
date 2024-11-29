import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poker_chip/util/enum/action.dart';

part 'action_entity.freezed.dart';

part 'action_entity.g.dart';

@freezed
class ActionEntity with _$ActionEntity {
  const ActionEntity._();

  const factory ActionEntity({
    required String uid,
    required ActionTypeEnum type,
    int? optId,
    required int score,
  }) = _ActionEntity;

  factory ActionEntity.fromJson(Map<String, dynamic> json) =>
      _$ActionEntityFromJson(json);

}

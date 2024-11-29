import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poker_chip/model/entity/action/action_entity.dart';
import 'package:poker_chip/model/entity/game/game_entity.dart';
import 'package:poker_chip/model/entity/side_pot/side_pot_entity.dart';
import 'package:poker_chip/model/entity/user/user_entity.dart';
import 'package:poker_chip/util/enum/game.dart';

part 'history_entity.freezed.dart';

part 'history_entity.g.dart';

@freezed
class HistoryEntity with _$HistoryEntity {
  const HistoryEntity._();

  const factory HistoryEntity({
    required DateTime dateTime,
    required GameTypeEnum round,
    required List<UserEntity> players,
    required int pot,
    required List<SidePotEntity> sidePots,
    required int assignedId,
    ActionEntity? action,
    GameEntity? game,
  }) = _HistoryEntity;

  factory HistoryEntity.fromJson(Map<String, dynamic> json) =>
      _$HistoryEntityFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poker_chip/util/enum/game.dart';

part 'game_entity.freezed.dart';

part 'game_entity.g.dart';

@freezed
class GameEntity with _$GameEntity {
  const GameEntity._();

  const factory GameEntity({
    required String uid,
    required GameTypeEnum type,
    required int score,
  }) = _GameEntity;

  factory GameEntity.fromJson(Map<String, dynamic> json) =>
      _$GameEntityFromJson(json);

}

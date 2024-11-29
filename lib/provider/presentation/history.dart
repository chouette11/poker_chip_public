import 'package:poker_chip/model/entity/action/action_entity.dart';
import 'package:poker_chip/model/entity/history/history_entity.dart';
import 'package:poker_chip/provider/presentation/opt_id.dart';
import 'package:poker_chip/provider/presentation/player.dart';
import 'package:poker_chip/provider/presentation/pot.dart';
import 'package:poker_chip/provider/presentation/round.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history.g.dart';

@Riverpod(keepAlive: true)
@riverpod
class History extends _$History {
  @override
  List<HistoryEntity> build() {
    return [];
  }

  void add(ActionEntity action) {
    final round = ref.read(roundProvider);
    final players = ref.read(playerDataProvider);
    final pot = ref.read(potProvider);
    final sidePots = ref.read(hostSidePotsProvider);
    final assignedId = ref.read(optionAssignedIdProvider);
    final history = HistoryEntity(
      dateTime: DateTime.now(),
      action: action,
      round: round,
      players: players,
      pot: pot,
      sidePots: sidePots,
      assignedId: assignedId,
    );
    state = [...state, history];
  }

  void apply(HistoryEntity history) {
    ref.read(playerDataProvider.notifier).restore(history.players);
    ref.read(roundProvider.notifier).restore(history.round);
    ref.read(potProvider.notifier).restore(history.pot);
    ref.read(hostSidePotsProvider.notifier).restore(history.sidePots);
    ref.read(optionAssignedIdProvider.notifier).restore(history.assignedId);
  }
}

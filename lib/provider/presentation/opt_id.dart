import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poker_chip/provider/presentation/player.dart';
import 'package:poker_chip/provider/presentation_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'opt_id.g.dart';

final participantOptIdProvider = StateProvider((ref) => 2);

@riverpod
class OptionAssignedId extends _$OptionAssignedId {
  @override
  int build() {
    return 2;
  }

  void updateId() {
    final actPlayers = ref.read(playerDataProvider.notifier).activePlayers();
    actPlayers.removeWhere((e) => e.stack == 0);
    final activeIds = actPlayers.map((e) => e.assignedId).toList();
    activeIds.sort();
    int? firstLargerNumber;
    int smallestNumber = activeIds[0];
    for (int id in activeIds) {
      if (id > state) {
        firstLargerNumber = id;
        break;
      }
      if (id < smallestNumber) {
        smallestNumber = id;
      }
    }
    state = firstLargerNumber ?? smallestNumber;
  }

  void updatePreFlopId() {
    final big = ref.read(bigIdProvider);
    final actPlayers = ref.read(playerDataProvider.notifier).activePlayers();
    final activeIds = actPlayers.map((e) => e.assignedId).toList();
    activeIds.sort();
    int? firstLargerNumber;
    int smallestNumber = activeIds[0];
    for (int id in activeIds) {
      if (id > big) {
        firstLargerNumber = id;
        break;
      }
      if (id < smallestNumber) {
        smallestNumber = id;
      }
    }
    state = firstLargerNumber ?? smallestNumber;
  }

  void updatePostFlopId() {
    final btn = ref.read(bigIdProvider.notifier).btnId();
    final actPlayers = ref.read(playerDataProvider.notifier).activePlayers();
    actPlayers.removeWhere((e) => e.stack == 0);
    final activeIds = actPlayers.map((e) => e.assignedId).toList();
    activeIds.sort();
    int? firstLargerNumber;
    int smallestNumber = activeIds[0];
    for (int id in activeIds) {
      if (id > btn) {
        firstLargerNumber = id;
        break;
      }
      if (id < smallestNumber) {
        smallestNumber = id;
      }
    }
    state = firstLargerNumber ?? smallestNumber;
  }

  void restore(int id) {
    state = id;
  }
}

import 'package:poker_chip/model/entity/side_pot/side_pot_entity.dart';
import 'package:poker_chip/provider/presentation/player.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pot.g.dart';

@riverpod
class HostSidePots extends _$HostSidePots {
  @override
  List<SidePotEntity> build() {
    return [];
  }

  void addSidePots(List<SidePotEntity> sidePots) {
    state = [...state, ...sidePots];
  }

  int totalValue() {
    int value = 0;
    for (final pot in state) {
      value += pot.size;
    }
    return value;
  }

  List<String> finalistUids() {
    final actPlayers = ref.read(playerDataProvider.notifier).activePlayers();
    final uids = actPlayers.map((e) => e.uid).toList();
    List<String> allinUsers = [];
    for (final sidePot in state) {
      allinUsers = [...allinUsers, ...sidePot.allinUids];
    }
    uids.removeWhere((e) => allinUsers.contains(e));
    return uids;
  }

  void clear() {
    state = [];
  }

  void restore(List<SidePotEntity> sidePots) {
    state = sidePots;
  }
}

@riverpod
class SidePots extends _$SidePots {
  @override
  List<int> build() {
    return [];
  }

  void addSidePot(int sidePotValue) {
    state = [...state, sidePotValue];
  }

  int totalValue() {
    int value = 0;
    for (final pot in state) {
      value += pot;
    }
    return value;
  }

  void clear() {
    state = [];
  }

  void restore(List<int> sidePots) {
    state = sidePots;
  }
}

@riverpod
class Pot extends _$Pot {
  @override
  int build() {
    return 0;
  }

  void potUpdate(int score) {
    state = state + score;
  }

  int currentSize(bool isHost) {
    final sidePotsSize = isHost
        ? ref.read(hostSidePotsProvider.notifier).totalValue()
        : ref.read(sidePotsProvider.notifier).totalValue();
    return state - sidePotsSize;
  }

  void clear() {
    state = 0;
  }

  void restore(int pot) {
    state = pot;
  }
}

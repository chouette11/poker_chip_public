import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:poker_chip/model/entity/user/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poker_chip/provider/presentation/player.dart';
import 'package:poker_chip/util/constant/context_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'presentation_providers.g.dart';

final uidProvider = StateProvider<String>((ref) => '');

final flavorProvider =
    Provider((ref) => const String.fromEnvironment('flavor'));

final idTextFieldControllerProvider = Provider((_) => TextEditingController());

final isSittingButtonProvider = StateProvider((ref) => true);

final nameProvider = StateProvider<String?>((ref) => null);

@Riverpod(keepAlive: true)
class SittingUids extends _$SittingUids {
  @override
  List<String> build() {
    return [];
  }

  void add(String uid) {
    if (state.where((e) => e == uid).isEmpty) {
      state = [...state, uid];
    }
  }

  void clear() {
    state = [];
  }
}

@riverpod
class ErrorText extends _$ErrorText {
  @override
  String build() {
    return '';
  }

  void viewCheckNetwork(BuildContext context) {
    state = context.l10n.checkNetworkMessage;
    Future.delayed(const Duration(seconds: 8), () {
      state = '';
    });
  }

  void viewCheckNumber(BuildContext context) {
    state = context.l10n.checkNumberMessage;
    Future.delayed(const Duration(seconds: 4), () {
      state = '';
    });
  }
}

final roomIdProvider =
    StateProvider((ref) => Random().nextInt(99999 - 10000 + 1) + 10000);

final isStartProvider = StateProvider((ref) => false);

final isJoinProvider = StateProvider((ref) => false);

final isReviewDialogProvider = StateProvider((ref) => false);

final raiseBetProvider = StateProvider((ref) => 0);

final initStackProvider = StateProvider((ref) => 1000);

final sbProvider = StateProvider((ref) => 10);

final bbProvider = StateProvider((ref) => 20);

final playersExProvider = StateProvider((ref) => []);

final isSelectedProvider =
    StateProvider.family((ref, UserEntity user) => false);

final rankingProvider = StateProvider.family((ref, UserEntity _) => 1);

///
/// position
///

@Riverpod(keepAlive: true)
class BigId extends _$BigId {
  @override
  int build() {
    return 1;
  }

  void updateId() {
    final players = ref.read(playerDataProvider);
    final len = players.length;
    state = state + 1;
    if (state > len) {
      state = 1;
    }
    if (isAllSitOut()) {
      return;
    }
    while (ref
        .read(playerDataProvider)
        .firstWhere((e) => e.uid == _assignedIdToUid2(state, ref))
        .isSitOut) {
      state = state + 1;
      if (state > len) {
        state = 1;
      }
    }
  }

  int smallId() {
    final players = ref.read(playerDataProvider);
    int id = state - 1;
    if (id == 0) {
      id = players.length;
    }
    if (isAllSitOut()) {
      return id;
    }
    while (ref
        .read(playerDataProvider)
        .firstWhere((e) => e.uid == _assignedIdToUid2(id, ref))
        .isSitOut) {
      final len = players.length;
      id = id - 1;
      if (id == 0) {
        id = len;
      }
    }
    return id;
  }

  int btnId() {
    final players = ref.read(playerDataProvider);
    final len = players.length;
    if (ref.read(playerDataProvider.notifier).activePlayers().length == 2) {
      return smallId();
    }
    int id = smallId() - 1;
    if (id == 0) {
      id = len;
    }
    if (isAllSitOut()) {
      return id;
    }
    while (ref
        .read(playerDataProvider)
        .firstWhere((e) => e.uid == _assignedIdToUid2(id, ref))
        .isSitOut) {
      id = id - 1;
      if (id == 0) {
        id = len;
      }
    }
    return id;
  }

  bool isAllSitOut() {
    final players = ref.read(playerDataProvider);
    final sitOuts = players.map((e) => e.isSitOut).toList();
    if (sitOuts.where((e) => false).toList().isEmpty) {
      return true;
    }
    return false;
  }
}

String _assignedIdToUid2(int assignedId, NotifierProviderRef<int> ref) {
  final players = ref.read(playerDataProvider);
  print('$assignedId');
  if (!players.map((e) => e.assignedId).toList().contains(assignedId)) {
    return '';
  }
  return players.firstWhere((e) => e.assignedId == assignedId).uid;
}

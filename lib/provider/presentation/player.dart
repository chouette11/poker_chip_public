import 'dart:math';

import 'package:poker_chip/model/entity/side_pot/side_pot_entity.dart';
import 'package:poker_chip/model/entity/user/user_entity.dart';
import 'package:poker_chip/provider/presentation/pot.dart';
import 'package:poker_chip/provider/presentation_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player.g.dart';

@riverpod
class PlayerData extends _$PlayerData {
  @override
  List<UserEntity> build() {
    return [
      UserEntity(
        uid: ref.watch(uidProvider),
        name: ref.watch(nameProvider),
        stack: ref.read(initStackProvider),
        assignedId: 1,
        score: 0,
        isBtn: false,
        isAction: false,
        isFold: false,
        isCheck: false,
        isSitOut: false,
      )
    ];
  }

  void restore(List<UserEntity> players) {
    state = players;
  }

  void add(UserEntity user) {
    if (state.where((e) => e.uid == user.uid).isEmpty) {
      state = [...state, user];
    }
  }

  void update(UserEntity user) {
    state = [
      for (final e in state)
        if (e.uid == user.uid) user else e,
    ];
  }

  void updateName(String uid, String playername) {
    state = [
      for (final user in state)
        if (user.uid == uid) user.copyWith(name: playername) else user
    ];
  }

  void upDateAssignedId(String uid, int assignedId) {
    state = [
      for (final user in state)
        if (user.uid == uid)
          user.copyWith(assignedId: assignedId)
        else
          user,
    ];
  }

  void updateStack(String uid, int? score) {
    state = [
      for (final user in state)
        if (user.uid == uid)
          user.copyWith(stack: user.stack + (score ?? 0))
        else
          user,
    ];
  }

  void changeStack(String uid, int stack) {
    state = [
      for (final user in state)
        if (user.uid == uid)
          user.copyWith(stack: stack)
        else
          user,
    ];
  }

  void updateScore(String uid, int score) {
    state = [
      for (final user in state)
        if (user.uid == uid) user.copyWith(score: score) else user,
    ];
  }

  void updateBtn(String uid) {
    state = [
      for (final user in state)
        if (user.uid == uid)
          user.copyWith(isBtn: true)
        else
          user.copyWith(isBtn: false),
    ];
  }

  void updateAction(String uid) {
    state = [
      for (final user in state)
        if (user.uid == uid) user.copyWith(isAction: true) else user
    ];
  }

  void updateFold(String uid) {
    state = [
      for (final user in state)
        if (user.uid == uid) user.copyWith(isFold: true) else user
    ];
  }

  void updateCheck(String uid) {
    state = [
      for (final user in state)
        if (user.uid == uid) user.copyWith(isCheck: true) else user
    ];
  }

  void updateSitOut(String uid, bool value) {
    state = [
      for (final user in state)
        if (user.uid == uid) user.copyWith(isSitOut: value) else user
    ];
  }

  void clearScore() {
    state = [
      for (final user in state) user.copyWith(score: 0),
    ];
  }

  void clearIsAction() {
    state = [
      for (final user in state) user.copyWith(isAction: false),
    ];
  }

  void clearIsFold() {
    state = [
      for (final user in state) user.copyWith(isFold: false),
    ];
  }

  void clearIsCheck() {
    state = [
      for (final user in state) user.copyWith(isCheck: false),
    ];
  }

  UserEntity specificPlayer(String uid) {
    List<UserEntity> players = List.from(state);
    return players.firstWhere((e) => e.uid == uid);
  }

  int totalScore() {
    int total = 0;
    for (final user in state) {
      total += user.score;
    }
    return total;
  }

  bool isAllAction() {
    final actPlayers = ref.read(playerDataProvider.notifier).activePlayers();
    actPlayers.removeWhere((e) => e.stack == 0);
    final values = actPlayers.map((e) => e.isAction).toList();
    return !values.contains(false);
  }

  bool isSameScore() {
    final actPlayers = activePlayers();
    final maxScore = actPlayers.map((e) => e.score).toList().reduce(max);
    actPlayers.removeWhere((e) => e.stack == 0 && e.score < maxScore);
    final values = actPlayers.map((e) => e.score).toList();
    if (values.isEmpty) return true;

    final first = values.first;
    for (final value in values) {
      if (value != first) {
        return false;
      }
    }
    return true;
  }

  bool isFoldout() {
    final actPlayers = activePlayers();
    return actPlayers.length == 1;
  }

  bool isAllinShowDown() {
    final actPlayers = activePlayers();
    if (actPlayers.where((e) => e.stack == 0).toList().isEmpty) {
      return false;
    }
    final stackNoneMaxScore = actPlayers
        .where((e) => e.stack == 0)
        .toList()
        .map((e) => e.score)
        .reduce(max);
    actPlayers.removeWhere((e) => e.stack == 0);
    return actPlayers.isEmpty ||
        (actPlayers.length == 1 && actPlayers.first.score >= stackNoneMaxScore);
  }

  bool isStackNone() {
    final actPlayers = activePlayers();
    final result = actPlayers.indexWhere((e) => e.stack == 0 && e.score != 0);
    return result != -1;
  }

  List<String> stackNoneUids() {
    final actPlayers = ref.read(playerDataProvider.notifier).activePlayers();
    actPlayers.removeWhere((e) => e.stack != 0);
    return actPlayers.map((e) => e.uid).toList();
  }

  List<UserEntity> activePlayers() {
    List<UserEntity> player = List.from(state);
    player.removeWhere((e) => e.isFold == true);
    player.removeWhere((e) => e.isSitOut == true);
    return player;
  }

  List<SidePotEntity> calculateSidePots() {
    List<UserEntity> users = List.from(state);

    // allin userが前のラウンドと変わっていない場合サイドポットを作成しない
    final noneUids = stackNoneUids();
    final prevSidePots = ref.read(hostSidePotsProvider);
    if (prevSidePots.isNotEmpty) {
      final lastSidePot = prevSidePots[prevSidePots.length - 1];
      if (!_hasUniqueElements(lastSidePot.allinUids, noneUids)) {
        return [];
      }
    }

    final pot = ref.read(potProvider);
    int count = 0;
    final prevPot = pot -
        ref.read(hostSidePotsProvider.notifier).totalValue() -
        ref.read(playerDataProvider.notifier).totalScore();

    print(prevPot);

    // ユーザーをベット額の昇順にソート
    users.sort((a, b) => a.score.compareTo(b.score));

    List<SidePotEntity> sidePots = [];
    int previousScore = 0;

    for (var i = 0; i < users.length; i++) {
      int contribution = users[i].score - previousScore;

      // 各ユーザーが作るサイドポットの計算
      if (contribution > 0) {
        int sidePotValue = 0;
        List<String> involvedUsers = [];

        for (var j = i; j < users.length; j++) {
          sidePotValue += contribution; // 各ユーザーの寄与額を加算
          involvedUsers.add(users[j].uid);
        }

        if (count == 0) {
          sidePotValue += prevPot;
        }

        final sidePot = SidePotEntity(
            uids: involvedUsers, size: sidePotValue, allinUids: noneUids);
        sidePots.add(sidePot);
        print(sidePot);
        count++;

        previousScore = users[i].score;
      }
    }

    return sidePots;
  }

  int curScore(String uid) {
    final player = state.firstWhere((e) => e.uid == uid);
    return player.score;
  }

  int curStack(String uid) {
    final player = state.firstWhere((e) => e.uid == uid);
    return player.stack;
  }
}

bool _hasUniqueElements(List<String> a, List<String> b) {
  // Aの要素を簡単に検索できるようにSetに変換
  var setA = a.toSet();

  // Bの各要素に対して、それがAに含まれていないかどうかをチェック
  for (var element in b) {
    if (!setA.contains(element)) {
      return true; // Aに含まれていない要素が見つかった
    }
  }
  return false; // すべてのBの要素がAに含まれている
}

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peerdart/peerdart.dart';
import 'package:poker_chip/model/entity/action/action_entity.dart';
import 'package:poker_chip/model/entity/game/game_entity.dart';
import 'package:poker_chip/model/entity/message/message_entity.dart';
import 'package:poker_chip/model/entity/user/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:poker_chip/page/game/host/component/host_ranking_button.dart';
import 'package:poker_chip/provider/presentation/history.dart';
import 'package:poker_chip/provider/presentation/opt_id.dart';
import 'package:poker_chip/provider/presentation/player.dart';
import 'package:poker_chip/provider/presentation/pot.dart';
import 'package:poker_chip/provider/presentation/round.dart';
import 'package:poker_chip/provider/presentation_providers.dart';
import 'package:poker_chip/util/enum/action.dart';
import 'package:poker_chip/util/enum/game.dart';
import 'package:poker_chip/util/enum/message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'peer.g.dart';

// Provider定義を整理
final peerProvider = ProviderFamily((ref, String id) => Peer(id: id));
final participantConProvider = StateProvider<DataConnection?>((ref) => null);

// ホストの接続管理用クラス
@riverpod
class HostCons extends _$HostCons {
  @override
  List<DataConnection> build() {
    return [];
  }

  // 接続を追加
  void add(DataConnection conn) {
    if (state.any((e) => e.label == conn.label)) {
      return;
    }
    state = [...state, conn];
  }

  // メッセージを全ての接続に送信
  Future<void> send(MessageEntity mes) async {
    await Future.wait(state.map((conn) => conn.send(mes.toJson())));
  }
}

// 接続オープンの管理をするクラス
@Riverpod(keepAlive: true)
@riverpod
class HostConnOpen extends _$HostConnOpen {
  @override
  bool build(Peer peer) {
    return false;
  }

  // 接続を開き、リスナーを設定
  void open(BuildContext context) {
    peer.on("open").listen((id) {
      print(peer.id);
      print('open!');
    });

    peer.on<DataConnection>("connection").listen((event) async {
      final conn = event;
      print('Connection established!');
      ref.read(hostConsProvider.notifier).add(conn);

      // 接続で受信するデータのリスナーを設定
      conn.on("data").listen((data) async {
        await _handleReceivedData(data);
      });

      conn.on("close").listen((event) {
        print('Connection closed');
      });

      state = true;
    });
  }

  // 受信したデータを処理
  Future<void> _handleReceivedData(dynamic data) async {
    final mes = MessageEntity.fromJson(data);
    print('Host received: $mes');

    switch (mes.type) {
      case MessageTypeEnum.reconnect:
        await _handleReconnect();
        break;
      case MessageTypeEnum.sit:
        await _handleSit(mes.content);
        break;
      case MessageTypeEnum.userSetting:
        await _handleUserSetting(mes.content);
        break;
      case MessageTypeEnum.action:
        await _handleAction(mes.content);
        break;
      case MessageTypeEnum.game:
        await _handleGame(mes.content);
        break;
      case MessageTypeEnum.history:
        break;
      case MessageTypeEnum.res:
        break;
    }
  }

  Future<void> _handleReconnect() async {
    final playersAndOptId = [
      ref.read(playerDataProvider),
      ref.read(optionAssignedIdProvider)
    ];
    final mes = MessageEntity(
        type: MessageTypeEnum.reconnect, content: playersAndOptId);
    await ref.read(hostConsProvider.notifier).send(mes);
  }

  Future<void> _handleSit(dynamic content) async {
    final uid = content as String;
    ref.read(sittingUidsProvider.notifier).add(uid);
    final players = ref.read(playerDataProvider);
    final actPlayers = players.where((e) => !e.isSitOut).toList();

    if (!ref.read(isStartProvider) || actPlayers.length < 2) {
      ref.read(playerDataProvider.notifier).updateSitOut(uid, false);
    }
  }

  Future<void> _handleUserSetting(dynamic content) async {
    UserEntity user = UserEntity.fromJson(content);
    final notifier = ref.read(playerDataProvider.notifier);

    notifier.update(user);

    final res = MessageEntity(type: MessageTypeEnum.userSetting, content: user);
    await ref.read(hostConsProvider.notifier).send(res);
  }

  Future<void> _handleAction(dynamic content) async {
    ActionEntity action = ActionEntity.fromJson(content);
    final notifier = ref.read(playerDataProvider.notifier);

    _actionStackMethod(action, ref);

    if (notifier.isFoldout()) {
      await _handleFoldout();
      await _broadcastActionUpdate(action);
      await _broadcastFold();
    } else if (notifier.isAllinShowDown()) {
      await _handleAllinShowDown();
      await _broadcastActionUpdate(action);
      await _broadcastChangeRound();
    } else if (notifier.isAllAction() && notifier.isSameScore()) {
      await _handleChangeRound();
      await _broadcastActionUpdate(action);
      await _broadcastChangeRound();
    } else {
      ref.read(optionAssignedIdProvider.notifier).updateId();
      await _broadcastActionUpdate(action);
    }

    ref.read(historyProvider.notifier).add(action);
  }

  Future<void> _handleGame(dynamic content) async {
    GameEntity game = GameEntity.fromJson(content);
    print(game);

    if (game.type == GameTypeEnum.showdown) {
      await _handleShowdown(game);
    } else if (game.type == GameTypeEnum.ranking) {
      await _handleRanking(game);
    }

    ref.read(roundProvider.notifier).updatePreFlop();
    await _broadcastPreFlopOption();
  }

  Future<void> _broadcastFold() async {
    final optId = ref.read(optionAssignedIdProvider);
    final game =
    GameEntity(uid: '', type: GameTypeEnum.preFlop, score: optId);
    final mes = MessageEntity(type: MessageTypeEnum.game, content: game);
    await ref.read(hostConsProvider.notifier).send(mes);
  }

  Future<void> _broadcastChangeRound() async {
    final round = ref.read(roundProvider);
    final game = GameEntity(uid: '', type: round, score: 0);
    final mes =
    MessageEntity(type: MessageTypeEnum.game, content: game);
    await ref.read(hostConsProvider.notifier).send(mes);
  }

  Future<void> _broadcastActionUpdate(ActionEntity action) async {
    final optId = ref.read(optionAssignedIdProvider);
    final updatedAction = action.copyWith.call(optId: optId);
    final mes =
        MessageEntity(type: MessageTypeEnum.action, content: updatedAction);
    await ref.read(hostConsProvider.notifier).send(mes);
  }

  Future<void> _broadcastPreFlopOption() async {
    final optId = ref.read(optionAssignedIdProvider);
    final game = GameEntity(uid: '', type: GameTypeEnum.preFlop, score: optId);
    final mes = MessageEntity(type: MessageTypeEnum.game, content: game);
    await ref.read(hostConsProvider.notifier).send(mes);
  }

// 各状態に応じた処理を行う関数
  Future<void> _handleFoldout() async {
    final playerNotifier = ref.read(playerDataProvider.notifier);
    final winner = playerNotifier.activePlayers().first;

    ref.read(roundProvider.notifier).update(GameTypeEnum.foldout);
    playerNotifier.clearScore();
    playerNotifier.clearIsAction();
    playerNotifier.clearIsCheck();

    final pot = ref.read(potProvider);
    playerNotifier.updateStack(winner.uid, pot);

    final cons = ref.read(hostConsProvider);

    for (final conn in cons) {
      final uids = playerNotifier.activePlayers().map((e) => e.uid).toList();
      final game =
          GameEntity(uid: uids.first, type: GameTypeEnum.foldout, score: pot);
      final mes = MessageEntity(type: MessageTypeEnum.game, content: game);
      conn.send(mes.toJson());
    }

    // 次のラウンド準備
    ref.read(roundProvider.notifier).updatePreFlop();
  }

  Future<void> _handleAllinShowDown() async {
    final playerNotifier = ref.read(playerDataProvider.notifier);

    if (playerNotifier.isStackNone()) {
      final sidePots = playerNotifier.calculateSidePots();
      ref.read(hostSidePotsProvider.notifier).addSidePots(sidePots);

      final cons = ref.read(hostConsProvider);
      for (final conn in cons) {
        for (final sidePot in sidePots) {
          final game = GameEntity(
              uid: '', type: GameTypeEnum.sidePot, score: sidePot.size);
          final mes = MessageEntity(type: MessageTypeEnum.game, content: game);
          conn.send(mes.toJson());
        }
      }
    }

    playerNotifier.clearScore();
    ref.read(roundProvider.notifier).update(GameTypeEnum.showdown);
    playerNotifier.clearIsAction();
    playerNotifier.clearIsCheck();
  }

  Future<void> _handleChangeRound() async {
    final playerNotifier = ref.read(playerDataProvider.notifier);

    if (playerNotifier.isStackNone()) {
      final sidePots = playerNotifier.calculateSidePots();
      ref.read(hostSidePotsProvider.notifier).addSidePots(sidePots);

      final cons = ref.read(hostConsProvider);
      for (final conn in cons) {
        for (final sidePot in sidePots) {
          final game = GameEntity(
              uid: '', type: GameTypeEnum.sidePot, score: sidePot.size);
          final mes = MessageEntity(type: MessageTypeEnum.game, content: game);
          conn.send(mes.toJson());
        }
      }
    }

    playerNotifier.clearScore();
    ref.read(optionAssignedIdProvider.notifier).updatePostFlopId();
    ref.read(roundProvider.notifier).nextRound();
    playerNotifier.clearIsAction();
    playerNotifier.clearIsCheck();
  }

  Future<void> _handleShowdown(GameEntity game) async {
    final uid = game.uid;
    final score = game.score;

    // HostのStack状態変更
    ref.read(playerDataProvider.notifier).updateStack(uid, score);

    final cons = ref.read(hostConsProvider);

    // 参加者にstack状態を更新するメッセージを送信
    for (final conn in cons) {
      final gameUpdate =
          GameEntity(uid: uid, type: GameTypeEnum.showdown, score: score);
      final mes =
          MessageEntity(type: MessageTypeEnum.game, content: gameUpdate);
      conn.send(mes.toJson());
    }
  }

  Future<void> _handleRanking(GameEntity game) async {
    final rankingMap = jsonDecode(game.uid) as Map<String, dynamic>;
    final sidePots = ref.read(hostSidePotsProvider);
    final curPotSize = ref.read(potProvider.notifier).currentSize(true);
    final finalUids = ref.read(hostSidePotsProvider.notifier).finalistUids();
    final distributionMap =
        distributeSidePots(sidePots, curPotSize, finalUids, rankingMap);

    final uids = distributionMap.keys.toList();
    final cons = ref.read(hostConsProvider);

    for (final uid in uids) {
      final score = distributionMap[uid] ?? 0;

      // HostのStack状態変更
      ref.read(playerDataProvider.notifier).updateStack(uid, score);

      // 参加者のstack状態更新を通知
      for (final conn in cons) {
        final gameUpdate =
            GameEntity(uid: uid, type: GameTypeEnum.showdown, score: score);
        final mes =
            MessageEntity(type: MessageTypeEnum.game, content: gameUpdate);
        conn.send(mes.toJson());
      }
    }
  }
}

// スタック変更メソッド
void _actionStackMethod(ActionEntity action, NotifierProviderRef<bool> ref) {
  final type = action.type;
  final uid = action.uid;
  final score = action.score;

  final playerNotifier = ref.read(playerDataProvider.notifier);
  playerNotifier.updateAction(uid);

  switch (type) {
    case ActionTypeEnum.fold:
      playerNotifier.updateFold(uid);
      break;
    case ActionTypeEnum.call:
      final curScore = playerNotifier.curScore(uid);
      final fixScore = score - curScore;
      playerNotifier.updateStack(uid, -fixScore);
      playerNotifier.updateScore(uid, score);
      ref.read(potProvider.notifier).potUpdate(fixScore);
      break;
    case ActionTypeEnum.raise:
    case ActionTypeEnum.bet:
      playerNotifier.updateStack(uid, -score);
      playerNotifier.updateScore(uid, score);
      ref.read(potProvider.notifier).potUpdate(score);
      break;
    case ActionTypeEnum.check:
      playerNotifier.updateCheck(uid);
      break;
  }
}

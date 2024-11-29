import 'package:peerdart/peerdart.dart';
import 'package:poker_chip/model/entity/game/game_entity.dart';
import 'package:poker_chip/model/entity/message/message_entity.dart';
import 'package:poker_chip/provider/presentation/opt_id.dart';
import 'package:poker_chip/provider/presentation/peer.dart';
import 'package:poker_chip/provider/presentation/player.dart';
import 'package:poker_chip/provider/presentation/pot.dart';
import 'package:poker_chip/provider/presentation_providers.dart';
import 'package:poker_chip/util/enum/game.dart';
import 'package:poker_chip/util/enum/message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'round.g.dart';

@riverpod
class Round extends _$Round {
  @override
  GameTypeEnum build() {
    return GameTypeEnum.preFlop;
  }

  void nextRound() {
    switch (state) {
      case GameTypeEnum.preFlop:
        state = GameTypeEnum.flop;
      case GameTypeEnum.flop:
        state = GameTypeEnum.turn;
      case GameTypeEnum.turn:
        state = GameTypeEnum.river;
      case GameTypeEnum.river:
        state = GameTypeEnum.showdown;
      case GameTypeEnum.showdown:
        break;
      case GameTypeEnum.foldout:
        break;
      case GameTypeEnum.blind:
        break;
      case GameTypeEnum.anty:
        break;
      case GameTypeEnum.btn:
        break;
      case GameTypeEnum.sidePot:
        break;
      case GameTypeEnum.ranking:
        break;
    }
  }

  void update(GameTypeEnum gameTypeEnum) {
    state = gameTypeEnum;
  }

  void updatePreFlop() {
    /// foldを初期化
    ref.read(playerDataProvider.notifier).clearIsFold();

    /// potを初期化
    ref.read(potProvider.notifier).clear();
    ref.read(hostSidePotsProvider.notifier).clear();

    final noneUsers =
    ref.read(playerDataProvider).where((e) => e.stack == 0).toList();
    for (final user in noneUsers) {
      /// HostのsitOutを更新
      ref.read(playerDataProvider.notifier).updateSitOut(user.uid, true);

      /// ParticipantのsitOutを更新
      final mes = MessageEntity(
          type: MessageTypeEnum.userSetting,
          content: user.copyWith.call(isSitOut: true));
      ref.read(hostConsProvider.notifier).send(mes);
    }

    /// sitOutから復帰したユーザーを更新
    final sittingUids = ref.read(sittingUidsProvider);
    for (final uid in sittingUids) {
      /// Hostの状態変更
      ref.read(playerDataProvider.notifier).updateSitOut(uid, false);

      /// Participantの状態変更
      final player = ref.read(playerDataProvider.notifier).specificPlayer(uid);
      final mes = MessageEntity(
          type: MessageTypeEnum.userSetting,
          content: player.copyWith.call(isSitOut: false));
      ref.read(hostConsProvider.notifier).send(mes);
    }
    ref.read(sittingUidsProvider.notifier).clear();

    /// bigBlindを更新
    ref.read(bigIdProvider.notifier).updateId();

    /// optionIdを更新
    ref.read(optionAssignedIdProvider.notifier).updatePreFlopId();

    state = GameTypeEnum.preFlop;

    Future.delayed(const Duration(seconds: 2), () {
      final cons = ref.read(hostConsProvider);
      _game(cons, ref);
    });
  }

  void restore(GameTypeEnum round) {
    state = round;
  }
}

void _game(List<DataConnection> cons,
    AutoDisposeNotifierProviderRef<GameTypeEnum> ref) {
  /// アクティブプレイヤーが一人の場合終了
  final actPlayers = ref.read(playerDataProvider.notifier).activePlayers();
  if (actPlayers.length == 1) {
    final user = actPlayers.first;

    ///Hostの状態変更
    ref.read(playerDataProvider.notifier).updateSitOut(user.uid, true);
    ref.read(isStartProvider.notifier).update((state) => false);

    /// Participantの状態変更
    final mes = MessageEntity(
        type: MessageTypeEnum.userSetting,
        content: user.copyWith.call(isSitOut: true));
    ref.read(hostConsProvider.notifier).send(mes);
    return;
  }

  final bigId = ref.read(bigIdProvider);
  final smallId = ref.read(bigIdProvider.notifier).smallId();
  final btnId = ref.read(bigIdProvider.notifier).btnId();
  final big = ref.watch(bbProvider);
  final small = ref.watch(sbProvider);
  final smallBlind = MessageEntity(
    type: MessageTypeEnum.game,
    content: GameEntity(
      uid: _assignedIdToUid(smallId, ref),
      type: GameTypeEnum.blind,
      score: small,
    ),
  );
  final bigBlind = MessageEntity(
    type: MessageTypeEnum.game,
    content: GameEntity(
      uid: _assignedIdToUid(bigId, ref),
      type: GameTypeEnum.blind,
      score: big,
    ),
  );
  final btn = MessageEntity(
    type: MessageTypeEnum.game,
    content: GameEntity(
        uid: _assignedIdToUid(btnId, ref), type: GameTypeEnum.btn, score: 0),
  );

  /// Participantの状態変更
  for (var conn in cons) {
    conn.send(smallBlind.toJson());
    conn.send(bigBlind.toJson());
    conn.send(btn.toJson());
  }

  /// Hostの状態変更
  ref
      .read(playerDataProvider.notifier)
      .updateStack(_assignedIdToUid(smallId, ref), -small);
  ref
      .read(playerDataProvider.notifier)
      .updateScore(_assignedIdToUid(smallId, ref), small);
  ref
      .read(playerDataProvider.notifier)
      .updateStack(_assignedIdToUid(bigId, ref), -big);
  ref
      .read(playerDataProvider.notifier)
      .updateScore(_assignedIdToUid(bigId, ref), big);
  ref.read(playerDataProvider.notifier).updateBtn(_assignedIdToUid(btnId, ref));
  ref.read(potProvider.notifier).potUpdate(small + big);
}

String _assignedIdToUid(
    int assignedId, AutoDisposeNotifierProviderRef<GameTypeEnum> ref) {
  final players = ref.read(playerDataProvider);
  if (!players.map((e) => e.assignedId).toList().contains(assignedId)) {
    return '';
  }
  return players.firstWhere((e) => e.assignedId == assignedId).uid;
}

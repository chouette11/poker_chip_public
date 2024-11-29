import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poker_chip/model/entity/game/game_entity.dart';
import 'package:poker_chip/model/entity/message/message_entity.dart';
import 'package:poker_chip/model/entity/side_pot/side_pot_entity.dart';
import 'package:poker_chip/provider/presentation/opt_id.dart';
import 'package:poker_chip/provider/presentation/peer.dart';
import 'package:poker_chip/provider/presentation/player.dart';
import 'package:poker_chip/provider/presentation/pot.dart';
import 'package:poker_chip/provider/presentation/round.dart';
import 'package:poker_chip/provider/presentation_providers.dart';
import 'package:poker_chip/util/constant/context_extension.dart';
import 'package:poker_chip/util/enum/game.dart';
import 'package:poker_chip/util/enum/message.dart';

class HostRankingButton extends ConsumerWidget {
  const HostRankingButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final round = ref.watch(roundProvider);
    final sidePots = ref.watch(hostSidePotsProvider);
    return Visibility(
      visible: round == GameTypeEnum.showdown && sidePots.isNotEmpty,
      child: FloatingActionButton(
        onPressed: () {
          Map<String, int> rankingMap = {};
          final players = ref.read(playerDataProvider.notifier).activePlayers();
          for (final player in players) {
            final rank = ref.read(rankingProvider(player));
            rankingMap[player.uid] = rank;
          }
          final currentPotSize =
              ref.watch(potProvider.notifier).currentSize(true);
          final finalUids =
              ref.read(hostSidePotsProvider.notifier).finalistUids();
          final distributionMap = distributeSidePots(
              sidePots, currentPotSize, finalUids, rankingMap);
          final uids = distributionMap.keys.toList();

          final cons = ref.read(hostConsProvider);
          for (final uid in uids) {
            final score = distributionMap[uid] ?? 0;

            /// HostのStack状態変更
            ref.read(playerDataProvider.notifier).updateStack(uid, score);

            /// Participantのstack状態変更
            for (final conn in cons) {
              final game = GameEntity(
                  uid: uid, type: GameTypeEnum.showdown, score: score);
              final mes =
                  MessageEntity(type: MessageTypeEnum.game, content: game);
              conn.send(mes.toJson());
            }
          }

          /// HostのOption状態変更
          ref.read(roundProvider.notifier).updatePreFlop();

          /// ParticipantのOption状態変更
          final optId = ref.read(optionAssignedIdProvider);
          for (final conn in cons) {
            final game =
                GameEntity(uid: '', type: GameTypeEnum.preFlop, score: optId);
            final mes =
                MessageEntity(type: MessageTypeEnum.game, content: game);
            conn.send(mes.toJson());
          }
        },
        child: Text(context.l10n.confirm),
      ),
    );
  }
}

/// { uid: score }
Map<String, int> distributeSidePots(List<SidePotEntity> sidePots, int pot,
    List<String> finalUids, Map userRankings) {
  // 各ユーザーに分配されるチップの量を記録するマップ
  Map<String, int> distributions = {};

  // ランキング順にソートされたユーザーIDのリストを作成
  var sortedUsers = userRankings.keys.toList();
  sortedUsers.sort((a, b) => userRankings[a]!.compareTo(userRankings[b]!));

  //現在のpotのentityを作成
  final potEntity = SidePotEntity(uids: finalUids, size: pot, allinUids: []);
  sidePots.add(potEntity);
  print(userRankings);
  print(sidePots);

  // 各サイドポットに対して
  for (var pot in sidePots) {
    // このポットを獲得できる最高ランクを見つける
    List<String> eligibleWinners = [];
    for (var uid in sortedUsers) {
      if (pot.uids.contains(uid)) {
        if (eligibleWinners.isEmpty ||
            userRankings[uid] == userRankings[eligibleWinners[0]]) {
          eligibleWinners.add(uid);
        } else {
          break;
        }
      }
    }

    if (eligibleWinners.isEmpty) {
      continue;
    }
    // サイドポットを関連する勝者に分配
    int potShare = pot.size ~/ (eligibleWinners.length * 10);
    potShare = potShare * 10;
    for (var winner in eligibleWinners) {
      distributions.update(winner, (value) => value + potShare,
          ifAbsent: () => potShare);
    }
  }

  return distributions;
}

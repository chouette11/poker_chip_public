import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poker_chip/model/entity/game/game_entity.dart';
import 'package:poker_chip/model/entity/message/message_entity.dart';
import 'package:poker_chip/provider/presentation/opt_id.dart';
import 'package:poker_chip/provider/presentation/peer.dart';
import 'package:poker_chip/provider/presentation/player.dart';
import 'package:poker_chip/provider/presentation/pot.dart';
import 'package:poker_chip/provider/presentation/round.dart';
import 'package:poker_chip/provider/presentation_providers.dart';
import 'package:poker_chip/util/constant/context_extension.dart';
import 'package:poker_chip/util/enum/game.dart';
import 'package:poker_chip/util/enum/message.dart';

class HostWhoWinButton extends ConsumerWidget {
  const HostWhoWinButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final round = ref.watch(roundProvider);
    final sidePots = ref.watch(hostSidePotsProvider);
    return Visibility(
      visible: round == GameTypeEnum.showdown && sidePots.isEmpty,
      child: FloatingActionButton(
        onPressed: () {
          final players = ref.read(playerDataProvider);
          final List<String> uids = [];
          final cons = ref.read(hostConsProvider);

          for (final player in players) {
            if (ref.read(isSelectedProvider(player))) {
              uids.add(player.uid);
            }
          }

          final score = ref.read(potProvider) ~/ uids.length;

          for (final uid in uids) {
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

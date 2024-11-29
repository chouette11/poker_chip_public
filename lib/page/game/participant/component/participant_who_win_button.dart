import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poker_chip/model/entity/game/game_entity.dart';
import 'package:poker_chip/model/entity/message/message_entity.dart';
import 'package:poker_chip/provider/presentation/peer.dart';
import 'package:poker_chip/provider/presentation/player.dart';
import 'package:poker_chip/provider/presentation/pot.dart';
import 'package:poker_chip/provider/presentation/round.dart';
import 'package:poker_chip/provider/presentation_providers.dart';
import 'package:poker_chip/util/constant/context_extension.dart';
import 'package:poker_chip/util/enum/game.dart';
import 'package:poker_chip/util/enum/message.dart';

class ParticipantWhoWinButton extends ConsumerWidget {
  const ParticipantWhoWinButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final round = ref.watch(roundProvider);
    final sidePots = ref.watch(sidePotsProvider);
    return Visibility(
      visible: round == GameTypeEnum.showdown && sidePots.isEmpty,
      child: FloatingActionButton(
        onPressed: () {
          final players = ref.read(playerDataProvider);
          final List<String> values = [];

          for (final player in players) {
            if (ref.read(isSelectedProvider(player))) {
              values.add(player.uid);
            }
          }

          final score = ref.read(potProvider) ~/ values.length;

          for (final uid in values) {
            final conn = ref.read(participantConProvider);
            if (conn == null) {
              return;
            }
            final game =
            GameEntity(uid: uid, type: GameTypeEnum.showdown, score: score);
            final mes = MessageEntity(type: MessageTypeEnum.game, content: game);
            conn.send(mes.toJson());
          }
        },
        child: Text(context.l10n.confirm),
      ),
    );
  }
}

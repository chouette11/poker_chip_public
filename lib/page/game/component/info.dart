import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poker_chip/model/entity/user/user_entity.dart';
import 'package:poker_chip/provider/presentation/opt_id.dart';
import 'package:poker_chip/provider/presentation/player.dart';
import 'package:poker_chip/provider/presentation/round.dart';
import 'package:poker_chip/util/constant/context_extension.dart';
import 'package:poker_chip/util/constant/text_style_constant.dart';
import 'package:poker_chip/util/enum/game.dart';

class InfoWidget extends ConsumerWidget {
  const InfoWidget(this.isHost, {super.key});

  final bool isHost;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final round = ref.watch(roundProvider);
    final players = ref.watch(playerDataProvider);
    final optId = isHost
        ? ref.watch(optionAssignedIdProvider)
        : ref.watch(participantOptIdProvider);
    final actionId = players.indexWhere((e) => e.assignedId == optId);

    return SizedBox(
      height: 100,
      width: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            round.name,
            style: TextStyleConstant.bold18,
          ),
          const SizedBox(height: 16),
          _action(actionId, players, round, context)
        ],
      ),
    );
  }
}

Widget _action(int actionId, List<UserEntity> players, GameTypeEnum round, BuildContext context) {
  if (actionId == -1 || round == GameTypeEnum.showdown) {
    return const SizedBox.shrink();
  } else {
    final name = players[actionId].name ?? 'プレイヤー1';
    return Text(
      context.l10n.actionPerson(name),
      style: TextStyleConstant.bold14,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poker_chip/model/entity/action/action_entity.dart';
import 'package:poker_chip/model/entity/game/game_entity.dart';
import 'package:poker_chip/model/entity/history/history_entity.dart';
import 'package:poker_chip/model/entity/message/message_entity.dart';
import 'package:poker_chip/model/entity/user/user_entity.dart';
import 'package:poker_chip/provider/presentation/history.dart';
import 'package:poker_chip/provider/presentation/peer.dart';
import 'package:poker_chip/provider/presentation/player.dart';
import 'package:poker_chip/util/constant/color_constant.dart';
import 'package:poker_chip/util/constant/context_extension.dart';
import 'package:poker_chip/util/constant/text_style_constant.dart';
import 'package:poker_chip/util/enum/game.dart';
import 'package:poker_chip/util/enum/message.dart';

class HistoryButton extends StatelessWidget {
  const HistoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(context: context, builder: (context) => _CustomDialog());
      },
      child: Text(context.l10n.history),
    );
  }
}

class _CustomDialog extends ConsumerStatefulWidget {
  const _CustomDialog({super.key});

  @override
  ConsumerState<_CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends ConsumerState<_CustomDialog> {
  HistoryEntity? selectedHistory;
  int selectedTileIndex = -1;

  @override
  Widget build(BuildContext context) {
    final histories = ref.watch(historyProvider);
    return Dialog(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              context.l10n.history,
              style: TextStyleConstant.bold16
                  .copyWith(color: ColorConstant.black10),
            ),
          ),
          SizedBox(
            height: histories.length * 64 + 16,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: histories.length,
                reverse: true,
                itemBuilder: (context, index) {
                  final history = histories[index];
                  return _CustomTile(
                    dateTime: history.dateTime,
                    action: history.action,
                    round: history.round,
                    isSelected: index == selectedTileIndex,
                    onTap: () {
                      selectedHistory = history;
                      selectedTileIndex = index;
                      setState(() {});
                    },
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: selectedTileIndex == -1
                ? null
                : () {
                    void restore() {
                      print(selectedHistory);
                      /// Hostの状態変更
                      ref
                          .read(historyProvider.notifier)
                          .apply(selectedHistory!);

                      /// Participantの状態変更
                      final mes = MessageEntity(
                          type: MessageTypeEnum.history,
                          content: selectedHistory);
                      ref.read(hostConsProvider.notifier).send(mes);
                    }

                    showDialog(
                      context: context,
                      builder: (content) => _ConfirmDialog(
                          players: selectedHistory!.players, onTap: () => restore()),
                    );
                  },
            child: Text(context.l10n.restore),
          )
        ],
      ),
    );
  }
}

class _CustomTile extends ConsumerWidget {
  const _CustomTile({
    super.key,
    this.action,
    this.game,
    required this.onTap,
    required this.dateTime,
    required this.round,
    required this.isSelected,
  });

  final DateTime dateTime;
  final GameTypeEnum round;
  final ActionEntity? action;
  final GameEntity? game;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (action != null) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? ColorConstant.black80
                : ColorConstant.black80.withOpacity(0.4),
            border: Border.all(color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(_datetimeToString(dateTime)),
                    Text(round.name),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${_uidToName(action!.uid, ref, context)}   ',
                      style: TextStyleConstant.bold16
                          .copyWith(color: ColorConstant.black10),
                    ),
                    Text(
                      action!.type.displayName,
                      style: TextStyleConstant.bold16
                          .copyWith(color: ColorConstant.black10),
                    ),
                    Visibility(
                      visible: action!.score != 0,
                      child: Text(
                        ':${action!.score.toString()}',
                        style: TextStyleConstant.bold16
                            .copyWith(color: ColorConstant.black10),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Row(
        children: [
          Text(dateTime.hour.toString()),
          Text(_uidToName(game!.uid, ref, context))
        ],
      );
    }
  }
}

class _ConfirmDialog extends StatelessWidget {
  const _ConfirmDialog({super.key, required this.players, required this.onTap});

  final List<UserEntity> players;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.blowRestore),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: players
                .map(
                  (e) => Text(
                      '${e.name ?? context.l10n.playerX(1)}  stack: ${e.stack} score: ${e.score}'),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {
                onTap();
                context.pop();
                context.pop();
              },
              child: const Text('OK'))
        ],
      ),
    );
  }
}

String _uidToName(String uid, WidgetRef ref, BuildContext context) {
  final players = ref.read(playerDataProvider);
  return players.firstWhere((e) => e.uid == uid).name ??
      context.l10n.playerX(1);
}

String _datetimeToString(DateTime dateTime) {
  return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}  ';
}

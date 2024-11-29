import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poker_chip/model/entity/game/game_entity.dart';
import 'package:poker_chip/model/entity/message/message_entity.dart';
import 'package:poker_chip/provider/presentation/opt_id.dart';
import 'package:poker_chip/provider/presentation/peer.dart';
import 'package:poker_chip/provider/presentation/player.dart';
import 'package:poker_chip/provider/presentation_providers.dart';
import 'package:poker_chip/util/constant/color_constant.dart';
import 'package:poker_chip/util/constant/context_extension.dart';
import 'package:poker_chip/util/constant/text_style_constant.dart';
import 'package:poker_chip/util/enum/game.dart';
import 'package:poker_chip/util/enum/message.dart';

class SitButton extends ConsumerWidget {
  const SitButton({super.key, required this.isHost});

  final bool isHost;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        ref.read(isSittingButtonProvider.notifier).update((state) => false);
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return _CustomDialog(isHost);
          },
        );
      },
      child: Center(child: FittedBox(child: Text(context.l10n.joining))),
    );
  }
}

class _CustomDialog extends ConsumerStatefulWidget {
  const _CustomDialog(this.isHost, {super.key});

  final bool isHost;

  @override
  ConsumerState<_CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends ConsumerState<_CustomDialog> {
  int stack = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final uid = ref.watch(uidProvider);
    final myData = ref.watch(playerDataProvider.notifier).specificPlayer(uid);
    final initValue =
        myData.stack == 0 ? ref.read(initStackProvider) : myData.stack;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.changeStack,
              style: TextStyleConstant.normal18
                  .copyWith(color: ColorConstant.black0),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: width * 0.6,
                  child: TextFormField(
                    initialValue: initValue.toString(),
                    decoration: const InputDecoration(labelText: 'stack'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      stack = int.parse(value);
                    },
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (stack == 0) {
                  stack = initValue;
                }
                if (widget.isHost) {
                  /// Hostの状態変更
                  ref.read(sittingUidsProvider.notifier).add(uid);
                  ref.read(playerDataProvider.notifier).changeStack(uid, stack);
                  // ゲームが終了していた場合即時参加
                  if (!ref.read(isStartProvider)) {
                    ref
                        .read(playerDataProvider.notifier)
                        .updateSitOut(uid, false);
                  }

                  /// Participantの状態変更
                  final user = myData.copyWith.call(stack: stack);
                  final mes = MessageEntity(
                    type: MessageTypeEnum.userSetting,
                    content: user,
                  );
                  ref.read(hostConsProvider.notifier).send(mes);
                  final optId = ref.read(optionAssignedIdProvider);
                  final game = GameEntity(
                      uid: uid, type: GameTypeEnum.preFlop, score: optId);
                  final optMes =
                      MessageEntity(type: MessageTypeEnum.game, content: game);
                  ref.read(hostConsProvider.notifier).send(optMes);
                } else {
                  final conn = ref.read(participantConProvider);
                  final user = myData.copyWith.call(stack: stack);
                  final mes = MessageEntity(
                    type: MessageTypeEnum.userSetting,
                    content: user,
                  );
                  conn!.send(mes.toJson());
                  conn.send(
                      MessageEntity(type: MessageTypeEnum.sit, content: uid)
                          .toJson());
                }
                context.pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poker_chip/model/entity/message/message_entity.dart';
import 'package:poker_chip/model/entity/user/user_entity.dart';
import 'package:poker_chip/page/game/component/ranking_select_button.dart';
import 'package:poker_chip/page/game/component/sit_button.dart';
import 'package:poker_chip/page/game/host/component/host_action_button.dart';
import 'package:poker_chip/page/game/host/component/host_ranking_button.dart';
import 'package:poker_chip/page/game/host/component/host_who_win_button.dart';
import 'package:poker_chip/page/game/participant/component/participant_action_button.dart';
import 'package:poker_chip/page/game/participant/component/participant_ranking_button.dart';
import 'package:poker_chip/page/game/participant/component/participant_who_win_button.dart';
import 'package:poker_chip/provider/presentation/peer.dart';
import 'package:poker_chip/provider/presentation/player.dart';
import 'package:poker_chip/provider/presentation/pot.dart';
import 'package:poker_chip/provider/presentation/round.dart';
import 'package:poker_chip/provider/presentation_providers.dart';
import 'package:poker_chip/repository/user_repository.dart';
import 'package:poker_chip/util/constant/color_constant.dart';
import 'package:poker_chip/util/constant/context_extension.dart';
import 'package:poker_chip/util/constant/text_style_constant.dart';
import 'package:poker_chip/util/enum/game.dart';
import 'package:poker_chip/util/enum/message.dart';

class Hole extends ConsumerWidget {
  const Hole(this.isHost, {super.key});

  final bool isHost;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 自分のデータ
    final uid = ref.watch(uidProvider);
    final myData =
        ref.watch(playerDataProvider).firstWhere((e) => e.uid == uid);
    final round = ref.watch(roundProvider);
    final isSelected = ref.watch(isSelectedProvider(myData));
    final activeIds = ref
        .watch(playerDataProvider.notifier)
        .activePlayers()
        .map((e) => e.uid)
        .toList();
    final isSidePot = isHost
        ? ref.watch(hostSidePotsProvider).isNotEmpty
        : ref.watch(sidePotsProvider).isNotEmpty;

    return SizedBox(
      height: 240,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: myData.isSitOut && ref.watch(isSittingButtonProvider),
            child: SitButton(isHost: isHost),
          ),
          Visibility(
            visible: !myData.isSitOut,
            child: isHost
                ? const HostRankingButton()
                : const ParticipantRankingButton(),
          ),
          Visibility(
            visible: !myData.isSitOut,
            child: isHost
                ? const HostWhoWinButton()
                : const ParticipantWhoWinButton(),
          ),
          Visibility(
            visible: !myData.isSitOut,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: isHost
                  ? const HostActionButtons()
                  : const ParticipantActionButtons(),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 32),
              const SizedBox(height: 40, width: 40),
              Visibility(
                visible: round == GameTypeEnum.showdown &&
                    activeIds.contains(myData.uid),
                child: isSidePot
                    ? RankingSelectButton(myData)
                    : Checkbox(
                        value: isSelected,
                        onChanged: (value) {
                          ref
                              .read(isSelectedProvider(myData).notifier)
                              .update((state) => !state);
                        },
                      ),
              ),
              Visibility(
                visible: myData.score != 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFF636),
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      myData.score.toString(),
                      style: TextStyleConstant.score
                          .copyWith(color: ColorConstant.black20),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: myData.isCheck && myData.score == 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFF636),
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      'Ch',
                      style: TextStyleConstant.score
                          .copyWith(color: ColorConstant.black20),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: myData.isSitOut,
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFF636),
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      'Out',
                      style: TextStyleConstant.score
                          .copyWith(color: ColorConstant.black20),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 40),
              myData.isBtn ? const DealerButton() : const SizedBox(width: 32)
            ],
          ),
          const SizedBox(height: 16),
          _EditablePlayerCard(isHost, myData),
        ],
      ),
    );
  }
}

class DealerButton extends StatelessWidget {
  const DealerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: ColorConstant.black100,
        border: Border.all(width: 1, color: ColorConstant.black50),
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: ColorConstant.black70, //色
            spreadRadius: 1,
            blurRadius: 0,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Center(
          child: Text(
        'D',
        style: TextStyleConstant.bold14.copyWith(color: Colors.black),
      )),
    );
  }
}

class _EditablePlayerCard extends ConsumerStatefulWidget {
  const _EditablePlayerCard(this.isHost, this.myData, {super.key});

  final bool isHost;
  final UserEntity myData;

  @override
  ConsumerState<_EditablePlayerCard> createState() =>
      _EditablePlayerCardState();
}

class _EditablePlayerCardState extends ConsumerState<_EditablePlayerCard> {
  @override
  Widget build(BuildContext context) {
    final uid = ref.watch(uidProvider);
    final myData =
        ref.watch(playerDataProvider).firstWhere((e) => e.uid == uid);

    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(context.l10n.isLeaveMessage),
                actions: <Widget>[
                  TextButton(
                    child: Text(context.l10n.dialogYes),
                    onPressed: () {
                      if (widget.isHost) {
                        /// Hostの状態変更
                        ref
                            .read(playerDataProvider.notifier)
                            .updateSitOut(uid, true);
                        ref
                            .read(playerDataProvider.notifier)
                            .updateFold(uid);
                        ref
                            .read(playerDataProvider.notifier)
                            .updateAction(uid);

                        /// Participantの状態変更
                        final user = myData.copyWith
                            .call(isSitOut: true, isFold: true, isAction: true);
                        final mes = MessageEntity(
                          type: MessageTypeEnum.userSetting,
                          content: user,
                        );
                        ref.read(hostConsProvider.notifier).send(mes);
                        context.pop();
                      } else {
                        final user = myData.copyWith
                            .call(isSitOut: true, isFold: true, isAction: true);
                        final mes = MessageEntity(
                          type: MessageTypeEnum.userSetting,
                          content: user,
                        );
                        ref.read(participantConProvider)?.send(mes.toJson());
                        context.pop();
                      }
                    },
                  ),
                  TextButton(
                    child: Text(context.l10n.dialogNo),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(36, 36),
              shape: const CircleBorder(),
              backgroundColor: Colors.grey),
          child: const Icon(Icons.logout_rounded, size: 20),
        ),
        Container(
          height: 60,
          width: 100,
          decoration: const BoxDecoration(color: ColorConstant.black60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(myData.name ?? context.l10n.playerX(1),
                  style: TextStyleConstant.bold14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(myData.stack.toString(),
                      style: TextStyleConstant.bold20),
                ],
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => _CustomDialog(widget.isHost),
            );
          },
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(36, 36),
              shape: const CircleBorder(),
              backgroundColor: Colors.grey),
          child: const Icon(Icons.manage_accounts, size: 20),
        ),
      ],
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
  String playerName = '';
  int stack = 0;
  int sb = 10;
  int bb = 20;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final uid = ref.watch(uidProvider);
    final myData =
        ref.watch(playerDataProvider).firstWhere((e) => e.uid == uid);
    playerName = myData.name ?? context.l10n.playerX(1);
    stack = myData.stack;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: width * 0.6,
                  child: TextFormField(
                    initialValue: playerName,
                    decoration: const InputDecoration(labelText: 'Name'),
                    onChanged: (value) {
                      playerName = value;
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: width * 0.6,
                  child: TextFormField(
                    initialValue: stack.toString(),
                    decoration: const InputDecoration(labelText: 'Stack'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      stack = int.parse(value);
                    },
                  ),
                ),
              ],
            ),
            Visibility(
              visible: widget.isHost,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: context.screenWidth * 0.2,
                          height: 48,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'SB',
                            ),
                            initialValue: ref.read(sbProvider).toString(),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) {
                              sb = int.parse(value);
                            },
                          ),
                        ),
                        SizedBox(
                          width: context.screenWidth * 0.2,
                          height: 48,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'BB',
                            ),
                            initialValue: ref.read(bbProvider).toString(),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) {
                              bb = int.parse(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (widget.isHost) {
                    /// Hostの状態変更
                    ref
                        .read(playerDataProvider.notifier)
                        .updateName(uid, playerName);
                    ref
                        .read(playerDataProvider.notifier)
                        .changeStack(uid, stack);

                    /// Participantの状態変更
                    final user =
                        myData.copyWith.call(name: playerName, stack: stack);
                    final mes = MessageEntity(
                      type: MessageTypeEnum.userSetting,
                      content: user,
                    );
                    ref.read(hostConsProvider.notifier).send(mes);
                  } else {
                    final conn = ref.read(participantConProvider);
                    final user =
                        myData.copyWith.call(name: playerName, stack: stack);
                    final mes = MessageEntity(
                      type: MessageTypeEnum.userSetting,
                      content: user,
                    );
                    conn?.send(mes.toJson());
                  }
                  // 端末に保存
                  await ref.read(userRepositoryProvider).saveName(playerName);

                  /// ブラインドを変更
                  ref.read(sbProvider.notifier).update((state) => sb);
                  ref.read(bbProvider.notifier).update((state) => bb);

                  context.pop();
                },
                child: const Text('OK'))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poker_chip/model/entity/message/message_entity.dart';
import 'package:poker_chip/provider/presentation/peer.dart';
import 'package:poker_chip/provider/presentation/player.dart';
import 'package:poker_chip/provider/presentation_providers.dart';
import 'package:poker_chip/util/constant/color_constant.dart';
import 'package:poker_chip/util/constant/context_extension.dart';
import 'package:poker_chip/util/constant/text_style_constant.dart';
import 'package:poker_chip/util/enum/message.dart';

class SettingButton extends ConsumerStatefulWidget {
  const SettingButton({super.key});

  @override
  ConsumerState<SettingButton> createState() => _SettingButtonState();
}

class _SettingButtonState extends ConsumerState<SettingButton> {
  int stack = 1000;
  int sb = 10;
  int bb = 20;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.initialStack,
                    style: TextStyleConstant.normal18
                        .copyWith(color: ColorConstant.black0),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: context.screenWidth * 0.6,
                        child: TextFormField(
                          initialValue: ref.read(initStackProvider).toString(),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(labelText: 'stack'),
                          onChanged: (value) {
                            stack = int.tryParse(value) ?? 1000;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.l10n.changeBlind,
                    style: TextStyleConstant.normal18
                        .copyWith(color: ColorConstant.black0),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ElevatedButton(
                    onPressed: () {
                      final players = ref.read(playerDataProvider);
                      print('プレイヤー１');
                      print(players);
                      ref.read(initStackProvider.notifier).update((state) => stack);
                      print('プレイヤー2');
                      print(ref.read(playerDataProvider));


                      /// Hostの状態変更
                      for (final player in players) {
                        ref
                            .read(playerDataProvider.notifier)
                            .changeStack(player.uid, stack);
                      }

                      /// Participantの状態変更
                      for (final player in players) {
                        final user = player.copyWith.call(stack: stack);
                        final mes = MessageEntity(
                            type: MessageTypeEnum.userSetting, content: user);
                        ref.read(hostConsProvider.notifier).send(mes);
                      }

                      /// ブラインドを変更
                      ref.read(sbProvider.notifier).update((state) => sb);
                      ref.read(bbProvider.notifier).update((state) => bb);
                      context.pop();
                    },
                    child: const Text('OK'),
                  )
                ],
              ),
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(48, 48),
        shape: const CircleBorder(),
      ),
      child: const Icon(Icons.settings),
    );
  }
}

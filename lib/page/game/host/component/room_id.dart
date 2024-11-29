import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poker_chip/provider/presentation_providers.dart';
import 'package:poker_chip/util/constant/text_style_constant.dart';

class RoomIdWidget extends ConsumerWidget {
  const RoomIdWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomId = ref.watch(roomIdProvider);
    final isStart = ref.watch(isStartProvider);
    return Visibility(
      visible: !isStart,
      child: Column(
        children: [
          const Text(
            'RoomID',
            style: TextStyleConstant.bold16,
          ),
          Text(
            '$roomId',
            style: TextStyleConstant.bold20,
          )
        ],
      ),
    );
  }
}

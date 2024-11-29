import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poker_chip/model/entity/side_pot/side_pot_entity.dart';
import 'package:poker_chip/provider/presentation/pot.dart';
import 'package:poker_chip/util/constant/color_constant.dart';
import 'package:poker_chip/util/constant/text_style_constant.dart';

class PotWidget extends ConsumerWidget {
  const PotWidget(this.isHost, {super.key});

  final bool isHost;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pot = ref.watch(potProvider);
    final sidePots = isHost
        ? ref.watch(hostSidePotsProvider.notifier).totalValue()
        : ref.watch(sidePotsProvider.notifier).totalValue();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SidePotsWidget(isHost),
        const SizedBox(width: 8),
        Container(
          height: 52,
          width: 80,
          decoration: BoxDecoration(
            color: ColorConstant.black30.withOpacity(0.4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              const Text(
                'Pot',
                style: TextStyleConstant.bold12,
              ),
              Text(
                '${pot - sidePots}',
                style: TextStyleConstant.bold20,
              )
            ],
          ),
        ),
        const SizedBox(width: 8),
        const SizedBox(width: 48),
      ],
    );
  }
}

class _SidePotsWidget extends ConsumerWidget {
  const _SidePotsWidget(this.isHost, {super.key});

  final bool isHost;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sidePots =
        isHost ? ref.watch(hostSidePotsProvider) : ref.watch(sidePotsProvider);
    print('sidePots: $sidePots');
    return SizedBox(
      height: (24 * sidePots.length).toDouble(),
      width: 48,
      child: ListView.builder(
        itemCount: sidePots.length,
        itemBuilder: (context, index) {
          int sidePot = 0;
          if (isHost) {
            final entity = sidePots[index] as SidePotEntity;
            sidePot = entity.size;
          } else {
            sidePot = sidePots[index] as int;
          }
          return _sidePot(sidePot);
        },
      ),
    );
  }
}

Widget _sidePot(int value) {
  return Padding(
    padding: const EdgeInsets.all(2),
    child: Container(
      height: 20,
      width: 24,
      decoration: BoxDecoration(
        color: ColorConstant.black30.withOpacity(0.4),
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(16),
          right: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Center(
          child: FittedBox(
            fit: BoxFit.fill,
            child: Text(
              '$value',
              style: TextStyleConstant.normal12,
            ),
          ),
        ),
      ),
    ),
  );
}

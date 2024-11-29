import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poker_chip/provider/presentation_providers.dart';
import 'package:poker_chip/util/constant/color_constant.dart';
import 'package:poker_chip/util/constant/text_style_constant.dart';

class Chips extends ConsumerWidget {
  const Chips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(raiseBetProvider);
    return SizedBox(
      height: 129,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Chip(color: Color(0xFF74AA9C), size: 64, value: 500),
              const Chip(color: Color(0xFFA58CEA), size: 64, value: 300),
              const Chip(color: Color(0xFF23ACD8), size: 64, value: 100),
              const Chip(color: Color(0xFFFFC03F), size: 64, value: 50),
              Column(
                children: [
                  score != 0
                      ? const ClearChip(color: ColorConstant.black40, size: 48)
                      : const SizedBox(height: 48),
                  const SizedBox(height: 16),
                  const Chip(color: Color(0xFFFF7D34), size: 64, value: 10),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Chip extends ConsumerWidget {
  const Chip({
    super.key,
    required this.color,
    required this.size,
    required this.value,
  });

  final Color color;
  final double size;
  final int value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(raiseBetProvider.notifier).update((state) => state + value);
        HapticFeedback.mediumImpact();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size + 1,
            height: size + 1,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: ColorConstant.black90),
          ),
          SvgPicture.asset(
            'assets/images/chip.svg',
            width: size,
            height: size,
            color: color,
          ),
          Text(
            value.toString(),
            style:
                TextStyleConstant.bold16.copyWith(color: ColorConstant.black10),
          )
        ],
      ),
    );
  }
}

class ClearChip extends ConsumerWidget {
  const ClearChip({
    super.key,
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(raiseBetProvider.notifier).update((state) => 0);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: ColorConstant.black90),
          ),
          SvgPicture.asset(
            'assets/images/chip.svg',
            width: size,
            height: size,
            color: color,
          ),
          const Icon(Icons.refresh, size: 16)
        ],
      ),
    );
  }
}

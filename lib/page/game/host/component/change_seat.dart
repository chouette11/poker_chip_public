import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poker_chip/provider/presentation/change_seat.dart';
import 'package:poker_chip/util/constant/color_constant.dart';
import 'package:poker_chip/util/constant/context_extension.dart';
import 'package:poker_chip/util/constant/text_style_constant.dart';

class ChangeSeatWidget extends ConsumerWidget {
  const ChangeSeatWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final changeSeat = ref.watch(changeSeatProvider);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Text(
        changeSeat.isEmpty ? context.l10n.changeSeat : context.l10n.selectUser,
        textAlign: TextAlign.center,
        style: TextStyleConstant.bold14.copyWith(color: ColorConstant.black10),
      ),
    );
  }
}

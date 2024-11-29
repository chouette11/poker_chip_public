import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poker_chip/model/entity/user/user_entity.dart';
import 'package:poker_chip/provider/presentation/player.dart';
import 'package:poker_chip/provider/presentation_providers.dart';
import 'package:poker_chip/util/constant/color_constant.dart';

class RankingSelectButton extends ConsumerStatefulWidget {
  const RankingSelectButton(this.userEntity, {super.key});

  final UserEntity userEntity;

  @override
  ConsumerState<RankingSelectButton> createState() =>
      _RankingSelectButtonState();
}

class _RankingSelectButtonState extends ConsumerState<RankingSelectButton> {
  List<bool> selection = [];
  List<String> options = [];

  @override
  void initState() {
    final actives = ref.read(playerDataProvider.notifier).activePlayers();
    selection = List.generate(actives.length, (index) => false);
    selection[0] = true;
    options = List.generate(actives.length, (index) => '${index + 1}位');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ToggleButtons(
          fillColor: ColorConstant.accent2,
          borderColor: ColorConstant.black0,
          selectedColor: ColorConstant.black0,
          isSelected: selection,
          onPressed: (int index) {
            selection.fillRange(0, selection.length, false);
            selection[index] = true;
            ref
                .read(rankingProvider(widget.userEntity).notifier)
                .update((state) => index + 1);
            setState(() {});
          },
          constraints: const BoxConstraints(
            minHeight: 32.0,
            minWidth: 36.0,
          ),
          children: options.map((e) => Text(e)).toList(),
        ),
      ),
    );
  }
}

import 'package:go_router/go_router.dart';
import 'package:poker_chip/page/component/ad/banner_ad.dart';
import 'package:poker_chip/page/game/component/chips.dart';
import 'package:poker_chip/page/game/component/hole.dart';
import 'package:poker_chip/page/game/component/pot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poker_chip/page/root/component/info_button.dart';
import 'package:poker_chip/page/game/host/host_page.dart';
import 'package:poker_chip/page/root/component/usage_button.dart';
import 'package:poker_chip/provider/presentation_providers.dart';
import 'package:poker_chip/util/constant/color_constant.dart';
import 'package:poker_chip/util/constant/context_extension.dart';

final rootGlobalKey = GlobalKey();

class RootPage extends ConsumerStatefulWidget {
  const RootPage({super.key});

  @override
  ConsumerState<RootPage> createState() => _RootPageState();
}

class _RootPageState extends ConsumerState<RootPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Future(
        () async {
          await Future.delayed(const Duration(seconds: 1));
        },
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return RepaintBoundary(
      key: rootGlobalKey,
      child: Scaffold(
        backgroundColor: ColorConstant.back,
        body: SafeArea(
          child: Column(
            children: [
              BannerAdWidget(width: width, height: height * 0.06),
              Expanded(
                child: SizedBox(
                  width: width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Image.asset(
                          'assets/images/board.png',
                          fit: BoxFit.fill,
                          height: height - 36,
                          width: width,
                        ),
                      ),
                      const Positioned(top: 0, right: 0, child: InfoButton()),
                      Positioned(
                        top: height * 0.25,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: PotWidget(true),
                        ),
                      ),
                      Positioned(
                        bottom: height * 0.35,
                        child: Column(
                          children: [
                            const UsageButton(),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    context.go('/host');
                                  },
                                  child: Text(context.l10n.makeRoom),
                                ),
                                const SizedBox(width: 32),
                                ElevatedButton(
                                    onPressed: () {
                                      final flavor = ref.read(flavorProvider);
                                      if (flavor == 'dev') {
                                        context.go('/participant',
                                            extra: roomToPeerId(000000));
                                      }
                                      context.go('/participant');
                                    },
                                    child: Text(context.l10n.join)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(bottom: height * 0.2, child: const Hole(true)),
                      Positioned(
                          bottom: height * 0.08, left: 0, child: const Chips()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

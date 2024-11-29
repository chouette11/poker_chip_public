import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:poker_chip/ignore/revenue_data_source.dart';
import 'package:poker_chip/page/component/ad/gdpr.dart';
import 'package:poker_chip/page/component/snack.dart';
import 'package:poker_chip/provider/domain_providers.dart';
import 'package:poker_chip/provider/presentation_providers.dart';
import 'package:poker_chip/util/constant/color_constant.dart';
import 'package:poker_chip/util/constant/context_extension.dart';
import 'package:poker_chip/util/constant/text_style_constant.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoButton extends ConsumerStatefulWidget {
   const InfoButton({super.key});

  @override
  ConsumerState<InfoButton> createState() => _InfoButtonState();
}

class _InfoButtonState extends ConsumerState<InfoButton> {
  bool isGDPR = false;

  @override
  void initState() {
    Future(() async => isGDPR = await isUnderGdpr());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child: Padding(
            padding:  const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(context.l10n.infoButtonText),
                GestureDetector(
                  onTap: () {
                    _launchUrl(Uri.parse('https://twitter.com/anywhere_chip'));
                  },
                  child:  const Text(
                    '@anywhere_chip',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                  ),
                ),
                 Text(context.l10n.twitterDMRequest),
                 const SizedBox(height: 16),
                _DottedDivider(),
                 const SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    await ref.read(revenueProvider).buyMonthly();
                    ref.refresh(isProUserProvider);
                  },
                  child: Padding(
                    padding:  const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: ColorConstant.black10),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                               const Icon(
                                Icons.block,
                                size: 48,
                                color: ColorConstant.black40,
                              ),
                              RichText(
                                textAlign: TextAlign.end,
                                text:  const TextSpan(children: [
                                  TextSpan(
                                    text: 'A',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: ColorConstant.black0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'd',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: ColorConstant.black0,
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                          Text(
                            context.l10n.removeAd,
                            style: TextStyleConstant.normal18.copyWith(
                              color: ColorConstant.black30,
                            ),
                          ),
                          Text(
                            context.l10n.price,
                            style: TextStyleConstant.normal14.copyWith(
                              color: ColorConstant.black30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.l10n.notCancelAd,
                      style: TextStyleConstant.normal12
                          .copyWith(color: ColorConstant.black40),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => _launchUrl(
                        Uri.parse(
                            'https://lovely-year-a00.notion.site/2bd3e7eba8f844c4a7b56d1b11d90817'),
                      ),
                      child: Text(
                        context.l10n.usage,
                        style: TextStyleConstant.normal10
                            .copyWith(color: Colors.blueAccent),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _launchUrl(
                        Uri.parse('https://poker-chip-14428.web.app'),
                      ),
                      child: Text(
                        context.l10n.privacy,
                        style: TextStyleConstant.normal10
                            .copyWith(color: Colors.blueAccent),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await ref.read(revenueProvider).restore();
                        AppSnackBar.of(messager: ScaffoldMessenger.of(context))
                            .show('復元の記録が見つかりません。\nもう一度ご確認ください。');
                      },
                      child: Text(
                        context.l10n.restore,
                        style: TextStyleConstant.normal12
                            .copyWith(color: Colors.indigo),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: isGDPR,
                      child: TextButton(
                        onPressed: () => changeGDPR(),
                        child: Text(
                          context.l10n.gdpr,
                          style: TextStyleConstant.normal10
                              .copyWith(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ).then((value) async {
        final InAppReview inAppReview = InAppReview.instance;
        final value = ref.read(isReviewDialogProvider);

        if (Platform.isIOS || Platform.isMacOS) {
          showCupertinoDialog(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title:  Text(context.l10n.reviewTitle),
              content:  Text(context.l10n.reviewContent),
              actions: <Widget>[
                CupertinoDialogAction(
                  child:  Text(context.l10n.reviewCancelButton),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () =>
                      inAppReview.openStoreListing(appStoreId: '6476509645'),
                  child:  Text(context.l10n.reviewOkButton),
                ),
              ],
            ),
          );
        } else if (Platform.isAndroid) {
          if (await inAppReview.isAvailable() && !value) {
            inAppReview.requestReview();
            ref.read(isReviewDialogProvider.notifier).update((state) => true);
          }
        }
      }),
      child: Padding(
        padding:  const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             const Icon(Icons.info_outline,
                color: ColorConstant.black0, size: 32),
            Text(
              context.l10n.info,
              style: TextStyleConstant.normal16
                  .copyWith(color: ColorConstant.black0),
            )
          ],
        ),
      ),
    );
  }
}

class _DottedDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints raints) {
        final double lineWidth = raints.maxWidth; // Dividerの横幅
         double dashWidth = 5.0; // 点線の幅
         double dashSpace = 5.0; // 線と線の間隔

        // 点線の個数を計算
        int dashCount = (lineWidth / (dashWidth + dashSpace)).floor();

        return SizedBox(
          width: lineWidth,
          height: 2.0, // Dividerの高さ
          child: ListView.builder(
            itemCount: dashCount,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              // 各点線の描画
              return Container(
                width: dashWidth,
                height: 1.0, // 点線の高さ
                color: Colors.black, // 点線の色
                margin:  EdgeInsets.symmetric(horizontal: dashSpace),
              );
            },
          ),
        );
      },
    );
  }
}

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

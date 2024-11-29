import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:poker_chip/page/root/root_page.dart';
import 'package:poker_chip/util/constant/color_constant.dart';
import 'package:poker_chip/util/constant/context_extension.dart';
import 'package:poker_chip/util/constant/text_style_constant.dart';

import 'package:qr_flutter/qr_flutter.dart';

class UsageButton extends StatelessWidget {
  const UsageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final rootBoundary = rootGlobalKey.currentContext?.findRenderObject()
            as RenderRepaintBoundary?;
        final rootImage = await rootBoundary!.toImage();
        final byteData =
            await rootImage.toByteData(format: ImageByteFormat.png);
        final rootBytes = byteData?.buffer.asUint8List();
        final rootImageWidget = Image.memory(rootBytes!.buffer.asUint8List());

        showDialog(
          context: context,
          builder: (context) {
            return UsageDialog(
              rootImage: rootImageWidget,
            );
          },
        );
      },
      child: Text(context.l10n.usageButtonTitle),
    );
  }
}

class UsageDialog extends StatefulWidget {
  const UsageDialog({super.key, required this.rootImage});

  final Image rootImage;

  @override
  State<UsageDialog> createState() => _UsageDialogState();
}

class _UsageDialogState extends State<UsageDialog> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const _Page1(),
      _Page2(rootImage: widget.rootImage),
      _Page3(
        rootImage: widget.rootImage,
      ),
    ];

    return AlertDialog(
      content: Padding(padding: const EdgeInsets.all(8), child: pages[index]),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (index == 0) {
                  return;
                }
                index--;
                setState(() {});
              },
              child: const Icon(
                Icons.arrow_left,
                size: 48,
              ),
            ),
            Text('${index + 1} / ${pages.length}'),
            GestureDetector(
              onTap: () {
                print(index);
                if (index == pages.length - 1) {
                  return;
                }
                index++;
                setState(() {});
              },
              child: const Icon(
                Icons.arrow_right,
                size: 48,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _Page1 extends StatelessWidget {
  const _Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 400,
      child: Column(
        children: [
          Text(
            context.l10n.page1Title,
            style:
                TextStyleConstant.bold18.copyWith(color: ColorConstant.black10),
          ),
          Text(
            context.l10n.page1Description,
            style: TextStyleConstant.text,
          ),
          SizedBox(child: QrImageView(data: 'https://onelink.to/pabhbm'))
        ],
      ),
    );
  }
}

class _Page2 extends StatelessWidget {
  const _Page2({super.key, required this.rootImage});

  final Image rootImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 400,
      child: Column(
        children: [
          Text(
            context.l10n.page2Title,
            style:
                TextStyleConstant.bold18.copyWith(color: ColorConstant.black10),
          ),
          Text(
            context.l10n.page2Description,
            style: TextStyleConstant.text,
          ),
          ClipRect(
            child: Align(
              alignment: Alignment.center, // 中心部分を基準に
              heightFactor: 0.33, // 元の画像の高さの1/3を表示（必要に応じて調整）
              widthFactor: 1.0, // 幅は全体を使用
              child: SizedBox(
                height: 600, // 目的の高さ
                width: 400,
                child: rootImage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Page3 extends StatelessWidget {
  const _Page3({super.key, required this.rootImage});

  final Image rootImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 400,
      child: Column(
        children: [
          Text(
            context.l10n.page3Title,
            style:
                TextStyleConstant.bold18.copyWith(color: ColorConstant.black10),
          ),
          Text(
            context.l10n.page3Description,
            style: TextStyleConstant.text,
          ),
          ClipRect(
            child: Align(
              alignment: Alignment.center, // 中心部分を基準に
              heightFactor: 0.33, // 元の画像の高さの1/3を表示（必要に応じて調整）
              widthFactor: 1.0, // 幅は全体を使用
              child: SizedBox(
                height: 600, // 目的の高さ
                width: 400,
                child: rootImage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Page4 extends StatelessWidget {
  const _Page4({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 400,
      child: Column(
        children: [
          Text(
            '4. その他',
            style:
                TextStyleConstant.bold18.copyWith(color: ColorConstant.black10),
          ),
          const Text('初期stackを変更したい場合は右上の設定から変更してください。'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poker_chip/util/constant/text_style_constant.dart';

enum SnackBarStatus {
  success,
  error,
  info,
}

class AppSnackBar {
  AppSnackBar._({
    required this.messager,
  });
  final ScaffoldMessengerState messager;

  factory AppSnackBar.of({
    required ScaffoldMessengerState messager,
  }) {
    return AppSnackBar._(
      messager: messager,
    );
  }

  void show(
      String title, {
        SnackBarStatus status = SnackBarStatus.info,
      }) {
    messager.clearSnackBars();
    messager.showSnackBar(
      customSnackBar(
        CustomSnackBar(
          title,
          status: status,
          messager: messager,
        ) as Widget,
      ),
    );
  }
}

SnackBar customSnackBar(Widget content) {
  return SnackBar(
    content: content,
    backgroundColor: Colors.transparent,
    padding: const EdgeInsets.all(0),
  );
}

class CustomSnackBar extends ConsumerWidget {
  const CustomSnackBar(
      this.title, {
        Key? key,
        this.status = SnackBarStatus.info,
        required this.messager,
      }) : super(key: key);
  final String title;
  final SnackBarStatus status;
  final ScaffoldMessengerState messager;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var icon = Icons.info_outline;
    var backgroundColor = Colors.white;
    var onColor = Colors.black;
    switch (status) {
      case SnackBarStatus.success:
        icon = Icons.check_circle_outline;
        break;
      case SnackBarStatus.error:
        icon = Icons.error_outline;
        break;
      case SnackBarStatus.info:
        icon = Icons.info_outline;
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: Icon(
                    icon,
                    color: onColor,
                  ),
                ),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyleConstant.normal16,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            child: Icon(
              Icons.close,
              color: onColor,
            ),
            onTap: () => messager.hideCurrentSnackBar(),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:poker_chip/util/constant/color_constant.dart';
import 'package:poker_chip/util/constant/context_extension.dart';
import 'package:poker_chip/util/constant/text_style_constant.dart';
import 'package:poker_chip/util/enum/hand.dart';

class HandButton extends StatelessWidget {
  const HandButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return const _HandDialog();
          },
        );
      },
      child: Text(context.l10n.handList, style: TextStyleConstant.normal14,),
    );
  }
}

class _HandDialog extends StatelessWidget {
  const _HandDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        color: ColorConstant.black80.withOpacity(0.4),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.high,
                    style: TextStyleConstant.bold20.copyWith(color: Colors.red),
                  ),
                  Image.asset(
                    'assets/images/arrow.png',
                    width: context.screenWidth * 0.1,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    context.l10n.low,
                    style: TextStyleConstant.bold20
                        .copyWith(color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _HandTile(
                      name: context.l10n.straightFlush,
                      desc: context.l10n.straightFlushDesc,
                      hand: HandEnum.straightFlush),
                  _HandTile(
                      name: context.l10n.fourOfAKind,
                      desc: context.l10n.fourOfAKindDesc,
                      hand: HandEnum.fourOfAKind),
                  _HandTile(
                      name: context.l10n.fullHouse,
                      desc: context.l10n.fullHouseDesc,
                      hand: HandEnum.fullHouse),
                  _HandTile(
                      name: context.l10n.flush,
                      desc: context.l10n.flushDesc,
                      hand: HandEnum.flush),
                  _HandTile(
                      name: context.l10n.straight,
                      desc: context.l10n.straightDesc,
                      hand: HandEnum.straight),
                  _HandTile(
                      name: context.l10n.threeOfAKind,
                      desc: context.l10n.threeOfAKindDesc,
                      hand: HandEnum.threeOfAKind),
                  _HandTile(
                      name: context.l10n.twoPair,
                      desc: context.l10n.twoPairDesc,
                      hand: HandEnum.twoPair),
                  _HandTile(
                      name: context.l10n.onePair,
                      desc: context.l10n.onePairDesc,
                      hand: HandEnum.onePair),
                  _HandTile(
                      name: context.l10n.highCard,
                      desc: context.l10n.highCardDesc,
                      hand: HandEnum.highCard),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HandTile extends StatelessWidget {
  const _HandTile(
      {super.key, required this.name, required this.desc, required this.hand});

  final String name;
  final String desc;
  final HandEnum hand;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            name,
            style:
                TextStyleConstant.bold20.copyWith(color: ColorConstant.black0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _getHand(hand)
                .map((e) => _TrampCard(
                      number: e["number"],
                      suit: e["suit"],
                    ))
                .toList(),
          ),
          Text(desc),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> _getHand(HandEnum handEnum) {
  switch (handEnum) {
    case HandEnum.straightFlush:
      return [
        {"number": 14, "suit": "s"},
        {"number": 13, "suit": "s"},
        {"number": 12, "suit": "s"},
        {"number": 11, "suit": "s"},
        {"number": 10, "suit": "s"},
      ];
    case HandEnum.fourOfAKind:
      return [
        {"number": 14, "suit": "s"},
        {"number": 14, "suit": "c"},
        {"number": 14, "suit": "h"},
        {"number": 14, "suit": "d"},
        {"number": 10, "suit": "s"},
      ];
    case HandEnum.fullHouse:
      return [
        {"number": 14, "suit": "s"},
        {"number": 14, "suit": "c"},
        {"number": 14, "suit": "h"},
        {"number": 10, "suit": "d"},
        {"number": 10, "suit": "s"},
      ];
    case HandEnum.flush:
      return [
        {"number": 14, "suit": "s"},
        {"number": 7, "suit": "s"},
        {"number": 5, "suit": "s"},
        {"number": 11, "suit": "s"},
        {"number": 10, "suit": "s"},
      ];
    case HandEnum.straight:
      return [
        {"number": 11, "suit": "s"},
        {"number": 10, "suit": "c"},
        {"number": 9, "suit": "h"},
        {"number": 8, "suit": "d"},
        {"number": 7, "suit": "s"},
      ];
    case HandEnum.threeOfAKind:
      return [
        {"number": 14, "suit": "s"},
        {"number": 14, "suit": "c"},
        {"number": 14, "suit": "h"},
        {"number": 10, "suit": "d"},
        {"number": 9, "suit": "s"},
      ];
    case HandEnum.twoPair:
      return [
        {"number": 14, "suit": "s"},
        {"number": 14, "suit": "c"},
        {"number": 10, "suit": "h"},
        {"number": 10, "suit": "d"},
        {"number": 9, "suit": "s"},
      ];
    case HandEnum.onePair:
      return [
        {"number": 14, "suit": "s"},
        {"number": 14, "suit": "c"},
        {"number": 13, "suit": "h"},
        {"number": 10, "suit": "d"},
        {"number": 9, "suit": "s"},
      ];
    case HandEnum.highCard:
      return [
        {"number": 14, "suit": "s"},
        {"number": 13, "suit": "c"},
        {"number": 7, "suit": "h"},
        {"number": 10, "suit": "d"},
        {"number": 9, "suit": "s"},
      ];
  }
}

class _TrampCard extends StatelessWidget {
  const _TrampCard({super.key, required this.number, required this.suit});

  final int number;
  final String suit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 52,
      decoration: BoxDecoration(
          color: number == 0 ? Colors.black12 : Colors.white,
          border: number == 0
              ? null
              : Border.all(color: Colors.black54, width: 1.6),
          borderRadius: BorderRadius.circular(4)),
      child: Column(
        children: [
          Center(
            child: Text(
              returnNumber(number),
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "PTS",
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: suit == "s" || suit == "c"
                ? Text(
                    returnMark(suit),
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "PTS",
                        color: Colors.grey[700]),
                  )
                : Text(
                    returnMark(suit),
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "PTS",
                        color: Colors.red[900]),
                  ),
          ),
        ],
      ),
    );
  }
}

String returnNumber(int? n) {
  if (n == null) {
    return "";
  } else if (n == 0) {
    return "";
  } else if (n == 13) {
    return "K";
  } else if (n == 12) {
    return "Q";
  } else if (n == 11) {
    return "J";
  } else if (n == 10) {
    return "T";
  } else if (n == 14) {
    return "A";
  } else if (n == 1) {
    return "A";
  } else {
    return "$n";
  }
}

String returnMark(String? m) {
  if (m == null) {
    return "";
  } else if (m == "") {
    return "";
  } else if (m == "s") {
    return "♠";
  } else if (m == "c") {
    return "♣";
  } else if (m == "h") {
    return "♥";
  } else if (m == "d") {
    return "♦";
  } else {
    return "error";
  }
}

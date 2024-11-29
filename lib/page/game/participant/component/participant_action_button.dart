import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poker_chip/model/entity/action/action_entity.dart';
import 'package:poker_chip/model/entity/message/message_entity.dart';
import 'package:poker_chip/page/game/host/component/host_action_button.dart';
import 'package:poker_chip/page/game/host/host_page.dart';
import 'package:poker_chip/provider/presentation/opt_id.dart';
import 'package:poker_chip/provider/presentation/peer.dart';
import 'package:poker_chip/provider/presentation/player.dart';
import 'package:poker_chip/provider/presentation/round.dart';
import 'package:poker_chip/provider/presentation_providers.dart';
import 'package:poker_chip/util/enum/action.dart';
import 'package:poker_chip/util/enum/game.dart';
import 'package:poker_chip/util/enum/message.dart';
import 'package:audioplayers/audioplayers.dart';

class ParticipantActionButtons extends ConsumerWidget {
  const ParticipantActionButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final round = ref.watch(roundProvider);
    final isStart = ref.watch(isStartProvider);

    Widget children() {
      final players = ref.watch(playerDataProvider);
      final maxScore = _findMaxInList(players.map((e) => e.score).toList());
      final me = players.firstWhere((e) => e.uid == ref.watch(uidProvider));

      if (maxScore == 0 || me.score == maxScore) {
        return Row(
          children: [
            _ActionButton(
                actionTypeEnum: ActionTypeEnum.bet, maxScore: maxScore, audio:'audios/bet.wav'),
            const SizedBox(width: 8),
            _ActionButton(
                actionTypeEnum: ActionTypeEnum.check, maxScore: maxScore, audio: 'audios/check.wav'),
            const SizedBox(width: 8),
            _ActionButton(
                actionTypeEnum: ActionTypeEnum.fold, maxScore: maxScore, audio: 'audios/fold.wav')
          ],
        );
      } else {
        return Row(
          children: [
            _ActionButton(
                actionTypeEnum: ActionTypeEnum.raise, maxScore: maxScore, audio: 'audios/raise.wav'),
            const SizedBox(width: 8),
            _ActionButton(
                actionTypeEnum: ActionTypeEnum.call, maxScore: maxScore, audio: 'audios/call.wav'),
            const SizedBox(width: 8),
            _ActionButton(
                actionTypeEnum: ActionTypeEnum.fold, maxScore: maxScore, audio: 'audios/fold.wav'),
          ],
        );
      }
    }

    bool isVisible(int optAssignedId) {
      if (round == GameTypeEnum.foldout ||
          round == GameTypeEnum.showdown ||
          !isStart) {
        return false;
      }
      if (!ref.read(isStartProvider)) {
        return false;
      }
      final uid = assignedIdToUid(optAssignedId, ref);
      return ref.read(uidProvider) == uid;
    }

    final optAssignedId = ref.watch(participantOptIdProvider);
    return Visibility(visible: isVisible(optAssignedId), child: children());
  }
}

class _ActionButton extends ConsumerWidget {
  const _ActionButton({
    super.key,
    required this.actionTypeEnum,
    required this.maxScore,
    required this.audio,
  });

  final ActionTypeEnum actionTypeEnum;
  final int maxScore;
  final String audio;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conn = ref.watch(participantConProvider);
    final uid = ref.watch(uidProvider);
    final betScore = ref.watch(raiseBetProvider);
    final myScore = ref.watch(playerDataProvider.notifier).curScore(uid);
    final myStack = ref.watch(playerDataProvider.notifier).curStack(uid);
    final score =
        _fixScoreSize(actionTypeEnum, betScore, maxScore, myStack, myScore);
    final audioPlayer = AudioPlayer();
    Locale locale = Localizations.localeOf(context);

    return ElevatedButton(
      onPressed: () async {
        if (conn == null) {
          return;
        }
        if ((actionTypeEnum == ActionTypeEnum.bet ||
            actionTypeEnum == ActionTypeEnum.raise) &&
            (betScore == 0 || betScore < maxScore)) {
          return;
        }
        final optId = ref.read(optionAssignedIdProvider);
        final action = ActionEntity(
          uid: uid,
          type: actionTypeEnum,
          score: score,
          optId: optId,
        );
        final mes =
            MessageEntity(type: MessageTypeEnum.action, content: action);
        print('send: $mes');
        conn.send(mes.toJson());

        /// bet額リセット
        ref.read(raiseBetProvider.notifier).update((state) => 0);

        /// sitOutリセット
        ref.read(isSittingButtonProvider.notifier).update((state) => true);
        
        /// 音声
        if (locale.toString() == 'ja') {
          audioPlayer.play(AssetSource(audio));
        } else {
          await flutterTts.setLanguage("en-US");
          flutterTts.speak(actionTypeEnum.name);
        }
        print(locale.toString());
      },
      child: Column(
        children: [
          Text(actionTypeEnum.name),
          Visibility(
            visible: actionTypeEnum == ActionTypeEnum.bet ||
                actionTypeEnum == ActionTypeEnum.raise,
            child: Text(score.toString()),
          ),
          Visibility(
            visible: actionTypeEnum == ActionTypeEnum.call,
            child: Text((score - myScore).toString()),
          )
        ],
      ),
    );
  }
}

int _fixScoreSize(ActionTypeEnum actionTypeEnum, int betScore, int maxScore,
    int stack, int myScore) {
  int score = 0;
  if (actionTypeEnum == ActionTypeEnum.raise ||
      actionTypeEnum == ActionTypeEnum.bet) {
    score = betScore;
    if (score > stack) {
      score = stack;
    }
  } else if (actionTypeEnum == ActionTypeEnum.call) {
    score = maxScore;
    if (score > stack + myScore) {
      score = stack + myScore;
    }
  }
  return score;
}

int _findMaxInList(List<int> numbers) {
  // リストが空の場合は例外を投げる
  if (numbers.isEmpty) {
    throw ArgumentError("List is empty");
  }

  int maxValue = numbers[0];
  for (int number in numbers) {
    if (number > maxValue) {
      maxValue = number;
    }
  }

  return maxValue;
}

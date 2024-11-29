import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:poker_chip/model/entity/action/action_entity.dart';
import 'package:poker_chip/model/entity/game/game_entity.dart';
import 'package:poker_chip/model/entity/message/message_entity.dart';
import 'package:poker_chip/page/game/host/host_page.dart';
import 'package:poker_chip/provider/presentation/history.dart';
import 'package:poker_chip/provider/presentation/opt_id.dart';
import 'package:poker_chip/provider/presentation/peer.dart';
import 'package:poker_chip/provider/presentation/player.dart';
import 'package:poker_chip/provider/presentation/pot.dart';
import 'package:poker_chip/provider/presentation/round.dart';
import 'package:poker_chip/provider/presentation_providers.dart';
import 'package:poker_chip/util/enum/action.dart';
import 'package:poker_chip/util/enum/game.dart';
import 'package:poker_chip/util/enum/message.dart';

final flutterTts = FlutterTts();

class HostActionButtons extends ConsumerWidget {
  const HostActionButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final round = ref.watch(roundProvider);

    Widget children() {
      final players = ref.watch(playerDataProvider);
      final maxScore = _findMaxInList(players.map((e) => e.score).toList());
      final me = players.firstWhere((e) => e.uid == ref.watch(uidProvider));
      if (maxScore == 0 || me.score == maxScore) {
        return Row(
          children: [
            _ActionButton(
                actionTypeEnum: ActionTypeEnum.bet,
                maxScore: maxScore,
                audio: 'audios/bet.wav'),
            const SizedBox(width: 8),
            _ActionButton(
                actionTypeEnum: ActionTypeEnum.check,
                maxScore: maxScore,
                audio: 'audios/check.wav'),
            const SizedBox(width: 8),
            _ActionButton(
                actionTypeEnum: ActionTypeEnum.fold,
                maxScore: maxScore,
                audio: 'audios/fold.wav')
          ],
        );
      } else {
        return Row(
          children: [
            _ActionButton(
                actionTypeEnum: ActionTypeEnum.raise,
                maxScore: maxScore,
                audio: 'audios/raise.wav'),
            const SizedBox(width: 8),
            _ActionButton(
                actionTypeEnum: ActionTypeEnum.call,
                maxScore: maxScore,
                audio: 'audios/call.wav'),
            const SizedBox(width: 8),
            _ActionButton(
                actionTypeEnum: ActionTypeEnum.fold,
                maxScore: maxScore,
                audio: 'audios/fold.wav')
          ],
        );
      }
    }

    bool isVisible(int optAssignedId) {
      if (round == GameTypeEnum.foldout || round == GameTypeEnum.showdown) {
        return false;
      }
      if (!ref.read(isStartProvider)) {
        return false;
      }
      final uid = assignedIdToUid(optAssignedId, ref);
      return ref.read(uidProvider) == uid;
    }

    final optAssignedId = ref.watch(optionAssignedIdProvider);
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
    final cons = ref.watch(hostConsProvider);
    final myUid = ref.watch(uidProvider);
    final betScore = ref.watch(raiseBetProvider);
    final myScore = ref.watch(playerDataProvider.notifier).curScore(myUid);
    final myStack = ref.watch(playerDataProvider.notifier).curStack(myUid);
    final score =
        _fixScoreSize(actionTypeEnum, betScore, maxScore, myStack, myScore);
    final audioPlayer = AudioPlayer();
    Locale locale = Localizations.localeOf(context);

    return ElevatedButton(
      onPressed: () async {
        if ((actionTypeEnum == ActionTypeEnum.bet ||
                actionTypeEnum == ActionTypeEnum.raise) &&
            (betScore == 0 || betScore < maxScore)) {
          return;
        }
        final notifier = ref.read(playerDataProvider.notifier);

        /// HostのStack状態変更
        _hostActionMethod(ref, actionTypeEnum, myUid, score);

        /// HostのOption状態変更
        final isFoldout = notifier.isFoldout();
        final isChangeRound = notifier.isAllAction() && notifier.isSameScore();
        final isAllinShowDown = notifier.isAllinShowDown();
        if (isFoldout) {
          final winner = notifier.activePlayers().first;
          ref.read(roundProvider.notifier).update(GameTypeEnum.foldout);
          ref.read(playerDataProvider.notifier).clearScore();
          ref.read(playerDataProvider.notifier).clearIsAction();
          ref.read(playerDataProvider.notifier).clearIsCheck();
          final pot = ref.read(potProvider);
          ref.read(playerDataProvider.notifier).updateStack(winner.uid, pot);

          /// Participantのターン状態変更
          final uids = notifier.activePlayers().map((e) => e.uid).toList();
          final game = GameEntity(
              uid: uids.first, type: GameTypeEnum.foldout, score: pot);
          final mes = MessageEntity(type: MessageTypeEnum.game, content: game);
          await ref.read(hostConsProvider.notifier).send(mes);

          ref.read(roundProvider.notifier).updatePreFlop();
        } else if (isAllinShowDown) {
          if (notifier.isStackNone()) {
            final sidePots =
                ref.read(playerDataProvider.notifier).calculateSidePots();
            ref.read(hostSidePotsProvider.notifier).addSidePots(sidePots);

            final cons = ref.read(hostConsProvider);
            for (final conn in cons) {
              for (final sidePot in sidePots) {
                /// Participantの状態変更
                final game = GameEntity(
                    uid: '', type: GameTypeEnum.sidePot, score: sidePot.size);
                final mes =
                    MessageEntity(type: MessageTypeEnum.game, content: game);
                conn.send(mes.toJson());
              }
            }
          }
          ref.read(playerDataProvider.notifier).clearScore();
          ref.read(roundProvider.notifier).update(GameTypeEnum.showdown);
          ref.read(playerDataProvider.notifier).clearIsAction();
          ref.read(playerDataProvider.notifier).clearIsCheck();
        } else if (isChangeRound) {
          if (notifier.isStackNone()) {
            final sidePots =
                ref.read(playerDataProvider.notifier).calculateSidePots();
            ref.read(hostSidePotsProvider.notifier).addSidePots(sidePots);

            final cons = ref.read(hostConsProvider);
            for (final conn in cons) {
              for (final sidePot in sidePots) {
                /// Participantの状態変更
                final game = GameEntity(
                    uid: '', type: GameTypeEnum.sidePot, score: sidePot.size);
                final mes =
                    MessageEntity(type: MessageTypeEnum.game, content: game);
                conn.send(mes.toJson());
              }
            }
          }
          ref.read(playerDataProvider.notifier).clearScore();
          ref.read(optionAssignedIdProvider.notifier).updatePostFlopId();
          ref.read(roundProvider.notifier).nextRound();
          ref.read(playerDataProvider.notifier).clearIsAction();
          ref.read(playerDataProvider.notifier).clearIsCheck();
        } else {
          ref.read(optionAssignedIdProvider.notifier).updateId();
        }

        /// ParticipantのStack状態変更
        final optId = ref.read(optionAssignedIdProvider);
        final action = ActionEntity(
          uid: myUid,
          type: actionTypeEnum,
          score: score,
          optId: optId,
        );
        final mes =
            MessageEntity(type: MessageTypeEnum.action, content: action);
        await ref.read(hostConsProvider.notifier).send(mes);

        if (isFoldout) {
          /// Participantのターン状態変更
          final optId = ref.read(optionAssignedIdProvider);
          final game =
              GameEntity(uid: '', type: GameTypeEnum.preFlop, score: optId);
          final mes = MessageEntity(type: MessageTypeEnum.game, content: game);
          await ref.read(hostConsProvider.notifier).send(mes);
        } else if (isChangeRound || isAllinShowDown) {
          /// Participantのターン状態変更
          final round = ref.read(roundProvider);
          final game = GameEntity(uid: '', type: round, score: 0);
          final mes = MessageEntity(type: MessageTypeEnum.game, content: game);
          await ref.read(hostConsProvider.notifier).send(mes);
        }

        /// bet額リセット
        ref.read(raiseBetProvider.notifier).update((state) => 0);

        /// sitOutリセット
        ref.read(isSittingButtonProvider.notifier).update((state) => true);

        // 音声
        if (locale.toString() == 'ja') {
          audioPlayer.play(AssetSource(audio));
        } else {
          await flutterTts.setLanguage("en-US");
          flutterTts.speak(actionTypeEnum.name);
        }

        // 履歴の追加
        ref
            .read(historyProvider.notifier)
            .add(ActionEntity(uid: myUid, type: actionTypeEnum, score: score));
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

void _hostActionMethod(
    WidgetRef ref, ActionTypeEnum type, String uid, int score) {
  ref.read(playerDataProvider.notifier).updateAction(uid);
  switch (type) {
    case ActionTypeEnum.fold:
      ref.read(playerDataProvider.notifier).updateFold(uid);
      break;
    case ActionTypeEnum.call:
      final curScore = ref.read(playerDataProvider.notifier).curScore(uid);
      final fixScore = score - curScore;
      ref.read(playerDataProvider.notifier).updateStack(uid, -fixScore);
      ref.read(playerDataProvider.notifier).updateScore(uid, score);
      ref.read(potProvider.notifier).potUpdate(fixScore);
      break;
    case ActionTypeEnum.raise:
      ref.read(playerDataProvider.notifier).updateStack(uid, -score);
      ref.read(playerDataProvider.notifier).updateScore(uid, score);
      ref.read(potProvider.notifier).potUpdate(score);
      break;
    case ActionTypeEnum.bet:
      ref.read(playerDataProvider.notifier).updateStack(uid, -score);
      ref.read(playerDataProvider.notifier).updateScore(uid, score);
      ref.read(potProvider.notifier).potUpdate(score);
      break;
    case ActionTypeEnum.check:
      ref.read(playerDataProvider.notifier).updateCheck(uid);
      break;
  }
}

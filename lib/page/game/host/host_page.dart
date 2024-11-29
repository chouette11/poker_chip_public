import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:peerdart/peerdart.dart';
import 'package:poker_chip/model/entity/game/game_entity.dart';
import 'package:poker_chip/model/entity/message/message_entity.dart';
import 'package:poker_chip/model/entity/user/user_entity.dart';
import 'package:poker_chip/page/component/ad/banner_ad.dart';
import 'package:poker_chip/page/game/component/chips.dart';
import 'package:poker_chip/page/game/component/hand_button.dart';
import 'package:poker_chip/page/game/component/history_button.dart';
import 'package:poker_chip/page/game/component/hole.dart';
import 'package:poker_chip/page/game/component/info.dart';
import 'package:poker_chip/page/game/component/pot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poker_chip/page/game/component/user_box.dart';
import 'package:poker_chip/page/game/host/component/change_seat.dart';
import 'package:poker_chip/page/game/host/component/room_id.dart';
import 'package:poker_chip/page/game/host/component/setting_button.dart';
import 'package:poker_chip/provider/presentation/peer.dart';
import 'package:poker_chip/provider/presentation/player.dart';
import 'package:poker_chip/provider/presentation/pot.dart';
import 'package:poker_chip/provider/presentation_providers.dart';
import 'package:poker_chip/repository/room_repository.dart';
import 'package:poker_chip/util/constant/color_constant.dart';
import 'package:poker_chip/util/constant/context_extension.dart';
import 'package:poker_chip/util/constant/text_style_constant.dart';
import 'package:poker_chip/util/enum/game.dart';
import 'package:poker_chip/util/enum/message.dart';

class HostPage extends ConsumerStatefulWidget {
  const HostPage({Key? key}) : super(key: key);

  @override
  ConsumerState<HostPage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<HostPage> {
  bool isChanged = false;
  final TextEditingController _controller = TextEditingController();
  bool connected = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final flavor = ref.read(flavorProvider);
    final roomId = flavor == 'dev' ? 000000 : ref.read(roomIdProvider);
    final id = roomToPeerId(roomId);
    final peer = ref.read(peerProvider(id));
    ref.read(hostConnOpenProvider(peer).notifier).open(context);
    Future(() async {
      await ref.read(roomRepositoryProvider).createRoom(roomId);
      final userEntity = UserEntity(
        uid: ref.read(uidProvider),
        name: ref.read(nameProvider),
        stack: ref.read(initStackProvider),
        assignedId: 1,
        score: 0,
        isBtn: false,
        isAction: false,
        isFold: false,
        isCheck: false,
        isSitOut: false,
      );
      await ref.read(roomRepositoryProvider).joinRoom(roomId, userEntity);
    });

    ref
        .read(roomRepositoryProvider)
        .getMemberStream(roomId)
        .listen((event) async {
      for (final change in event.docChanges) {
        final data = change.doc.data();
        if (data == null) {
          break;
        }
        final user = UserEntity.fromJson(data);
        switch (change.type) {
          case DocumentChangeType.added:
            ref.read(playerDataProvider.notifier).add(user);
            break;
          case DocumentChangeType.removed:
            break;
          case DocumentChangeType.modified:
            ref.read(playerDataProvider.notifier).update(user);
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final cons = ref.watch(hostConsProvider);
    final flavor = ref.watch(flavorProvider);
    final isStart = ref.watch(isStartProvider);
    final roomId = ref.watch(roomIdProvider);
    final players = ref.watch(playerDataProvider);

    return PopScope(
      canPop: !isStart,
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
                      Visibility(
                        visible: isStart,
                        child: Positioned(
                          bottom: 16,
                          left: 16,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'RoomID',
                                style: TextStyleConstant.normal12,
                              ),
                              Text(
                                '$roomId',
                                style: TextStyleConstant.normal16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !isStart,
                        child: Positioned(
                          bottom: 8,
                          left: 16,
                          child: ElevatedButton(
                            onPressed: () {
                              ref.refresh(playerDataProvider);
                              context.pop();
                            },
                            child: Text(context.l10n.returnTop),
                          ),
                        ),
                      ),
                      const Positioned(
                        bottom: 8,
                        right: 16,
                        child: HandButton(),
                      ),
                      Visibility(
                        visible: isStart,
                        child: const Positioned(
                          bottom: 8,
                          child: HistoryButton(),
                        ),
                      ),
                      const Positioned(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: UserBoxes(true),
                        ),
                      ),
                      Visibility(
                        visible: isStart,
                        child: Positioned(
                          top: height * 0.25,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: PotWidget(true),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !isStart,
                        child: Positioned(
                          top: height * 0.2,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ChangeSeatWidget(),
                          ),
                        ),
                      ),
                      Positioned(
                        top: height * 0.3,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RoomIdWidget(),
                        ),
                      ),
                      Visibility(
                        visible: isStart,
                        child: Positioned(
                          top: height * 0.35,
                          child: const InfoWidget(true),
                        ),
                      ),
                      Visibility(
                        visible: !isStart,
                        child: Positioned(
                          top: height * 0.4,
                          child: Row(
                            children: [
                              const SizedBox(width: 66),
                              ElevatedButton(
                                onPressed: players
                                            .where((e) => !e.isSitOut)
                                            .toList()
                                            .length <
                                        2
                                    ? null
                                    : () {
                                        _game(cons, ref);
                                      },
                                child: Text(context.l10n.start),
                              ),
                              const SizedBox(width: 16),
                              const SettingButton(),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !isStart,
                        child: Positioned(
                          top: height * 0.5,
                          child: Text(
                            context.l10n.hostTaskKill,
                            style: TextStyleConstant.normal16
                                .copyWith(color: ColorConstant.black10),
                          ),
                        ),
                      ),
                      Positioned(bottom: height * 0.2, child: const Hole(true)),
                      Visibility(
                        visible: flavor == 'dev',
                        child: Positioned(
                            bottom: height * 0.17,
                            child: Text(connected.toString())),
                      ),
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

String assignedIdToUid(int assignedId, WidgetRef ref) {
  final players = ref.read(playerDataProvider);
  if (!players.map((e) => e.assignedId).toList().contains(assignedId)) {
    return '';
  }
  return players.firstWhere((e) => e.assignedId == assignedId).uid;
}

String roomToPeerId(int roomId) {
  return '$roomId--chouette111-poker-chip';
}

void _game(List<DataConnection> cons, WidgetRef ref) {
  ref.read(isStartProvider.notifier).update((state) => true);
  final bigId = ref.read(bigIdProvider);
  final smallId = ref.read(bigIdProvider.notifier).smallId();
  final btnId = ref.read(bigIdProvider.notifier).btnId();
  final big = ref.watch(bbProvider);
  final small = ref.watch(sbProvider);
  final smallBlind = MessageEntity(
    type: MessageTypeEnum.game,
    content: GameEntity(
      uid: assignedIdToUid(smallId, ref),
      type: GameTypeEnum.blind,
      score: small,
    ),
  );
  final bigBlind = MessageEntity(
    type: MessageTypeEnum.game,
    content: GameEntity(
      uid: assignedIdToUid(bigId, ref),
      type: GameTypeEnum.blind,
      score: big,
    ),
  );
  final btn = MessageEntity(
    type: MessageTypeEnum.game,
    content: GameEntity(
        uid: assignedIdToUid(btnId, ref), type: GameTypeEnum.btn, score: 0),
  );

  /// Participantの状態変更
  for (var conn in cons) {
    conn.send(smallBlind.toJson());
    conn.send(bigBlind.toJson());
    conn.send(btn.toJson());
  }

  /// Hostの状態変更
  ref
      .read(playerDataProvider.notifier)
      .updateStack(assignedIdToUid(smallId, ref), -small);
  ref
      .read(playerDataProvider.notifier)
      .updateScore(assignedIdToUid(smallId, ref), small);
  ref
      .read(playerDataProvider.notifier)
      .updateStack(assignedIdToUid(bigId, ref), -big);
  ref
      .read(playerDataProvider.notifier)
      .updateScore(assignedIdToUid(bigId, ref), big);
  ref.read(playerDataProvider.notifier).updateBtn(assignedIdToUid(btnId, ref));
  ref.read(potProvider.notifier).potUpdate(small + big);
}

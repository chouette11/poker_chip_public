import 'package:poker_chip/model/entity/message/message_entity.dart';
import 'package:poker_chip/model/entity/user/user_entity.dart';
import 'package:poker_chip/provider/presentation/peer.dart';
import 'package:poker_chip/provider/presentation/player.dart';
import 'package:poker_chip/util/enum/message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'change_seat.g.dart';

@riverpod
class ChangeSeat extends _$ChangeSeat {
  @override
  List<UserEntity> build() {
    return [];
  }

  void update(UserEntity user) {
    if (state.isEmpty) {
      state = [user];
    } else {
      /// Hostの状態変更
      final user1 = user.copyWith.call(assignedId: state.first.assignedId);
      final user2 = state.first.copyWith.call(assignedId: user.assignedId);
      ref.read(playerDataProvider.notifier).update(user1);
      ref.read(playerDataProvider.notifier).update(user2);
      state = [];

      /// Participantの状態変更
      final mes1 = MessageEntity(type: MessageTypeEnum.userSetting, content: user1);
      final mes2 = MessageEntity(type: MessageTypeEnum.userSetting, content: user2);
      ref.read(hostConsProvider.notifier).send(mes1);
      ref.read(hostConsProvider.notifier).send(mes2);
    }
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poker_chip/util/enum/message.dart';

part 'message_entity.freezed.dart';
part 'message_entity.g.dart';


@freezed
class MessageEntity with _$MessageEntity {
    const MessageEntity._();

  const factory MessageEntity({
    required MessageTypeEnum type,
    required dynamic content,
  }) = _MessageEntity;

   factory MessageEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageEntityFromJson(json);

}

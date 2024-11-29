import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poker_chip/model/document/room/room_document.dart';

part 'room_entity.freezed.dart';

part 'room_entity.g.dart';

@freezed
class RoomEntity with _$RoomEntity {
  const RoomEntity._();

  const factory RoomEntity({
    required int id,
    required int stack,
    required DateTime createdAt,
  }) = _RoomEntity;

  factory RoomEntity.fromJson(Map<String, dynamic> json) =>
      _$RoomEntityFromJson(json);

  static RoomEntity fromDoc(RoomDocument roomDoc) {
    return RoomEntity(
      id: roomDoc.id,
      stack: roomDoc.stack, createdAt: roomDoc.createdAt,
    );
  }

  RoomDocument toRoomDocument() {
    return RoomDocument(
      id: id,
      stack: stack,
      createdAt: createdAt,
    );
  }
}

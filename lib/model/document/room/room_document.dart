import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poker_chip/model/document/timestamp_comverter.dart';

part 'room_document.freezed.dart';

part 'room_document.g.dart';

@freezed
class RoomDocument with _$RoomDocument {
  const RoomDocument._();

  const factory RoomDocument({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'stack') required int stack,
    @TimestampConverter() @JsonKey(name: 'createdAt') required DateTime createdAt,

  }) = _RoomDocument;

  factory RoomDocument.fromJson(Map<String, dynamic> json) =>
      _$RoomDocumentFromJson(json);
}
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

part 'user_entity.g.dart';


@freezed
class UserEntity with _$UserEntity {
  const UserEntity._();

  const factory UserEntity({
    required String uid,
    required int assignedId,
    String? name,
    required int stack,
    required bool isBtn,
    required bool isAction,
    required bool isCheck,
    required bool isFold,
    required bool isSitOut,
    required int score,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}

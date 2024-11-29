import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poker_chip/model/document/room/room_document.dart';
import 'package:poker_chip/model/entity/user/user_entity.dart';
import 'package:poker_chip/provider/domain_providers.dart';
import 'package:poker_chip/provider/presentation_providers.dart';

final firestoreProvider =
    Provider<FirestoreDataSource>((ref) => FirestoreDataSource(ref: ref));

class FirestoreDataSource {
  FirestoreDataSource({required this.ref});

  final Ref ref;

  /// Room

  /// 新規ルーム追加
  Future<void> createRoom(RoomDocument roomDocument) async {
    final db = ref.read(firebaseFirestoreProvider);
    final collection = db.collection('rooms');
    await collection.doc(roomDocument.id.toString()).set(roomDocument.toJson());
  }

  /// ルームを取得
  Future<RoomDocument?> fetchRoom(int roomId) async {
    final db = ref.read(firebaseFirestoreProvider);
    final room = await db.collection('rooms').doc(roomId.toString()).get();
    if (room.data() == null) {
      return null;
    }
    return RoomDocument.fromJson(room.data()!);
  }

  /// ルームの更新
  Future<void> updateRoom({
    required String id,
    String? topic,
    int? maxNum,
    List<String>? roles,
    int? votedSum,
    int? killedId,
    DateTime? startTime,
  }) async {
    try {
      final db = ref.read(firebaseFirestoreProvider);
      final docRef = db.collection('rooms').doc(id);
      await db.runTransaction((Transaction transaction) async {
        // トランザクション内でドキュメントを読み込む
        final snapshot = await transaction.get(docRef);
        final room = RoomDocument.fromJson(snapshot.data()!);

        // ドキュメントを更新する
        transaction.update(docRef, room.copyWith.call().toJson());
      });
    } catch (e) {
      print('update_room');
      throw e;
    }
  }

  /// Member

  /// 新規メンバー追加
  Future<void> insertMember(UserEntity userEntity, int roomId) async {
    final db = ref.read(firebaseFirestoreProvider);
    final collection = db.collection('rooms/$roomId/members');
    await collection.doc(ref.read(uidProvider)).set(userEntity.toJson());
  }

  /// メンバーの一覧を取得
  Future<List<UserEntity>> fetchMembers(int roomId) async {
    try {
      final db = ref.read(firebaseFirestoreProvider);
      final rooms = await db.collection('rooms/$roomId/members').get();
      return rooms.docs.map((e) => UserEntity.fromJson(e.data())).toList();
    } catch (e) {
      print('firestore_getStream');
      throw e;
    }
  }

  /// メンバーのストリーム取得
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchMemberStream(int roomId) {
    try {
      final db = ref.read(firebaseFirestoreProvider);

      final stream = db.collection('rooms/$roomId/members').snapshots();
      return stream;
    } catch (e) {
      print('firestore_getMessageStream');
      throw e;
    }
  }

  /// メンバーの更新
  Future<void> updateMember({
    required int roomId,
    required String uid,
    int? assignedId,
    String? name,
    int? stack,
    bool? isBtn,
    bool? isAction,
    bool? isCheck,
    bool? isFold,
    bool? isSitOut,
    int? score,
  }) async {
    try {
      final db = ref.read(firebaseFirestoreProvider);
      final docRef = db.collection('rooms/$roomId/members').doc(uid);
      await db.runTransaction((Transaction transaction) async {
        // トランザクション内でドキュメントを読み込む
        final snapshot = await transaction.get(docRef);
        final user = UserEntity.fromJson(snapshot.data()!);

        // ドキュメントを更新する
        transaction.update(docRef, user.copyWith.call(
          assignedId: assignedId ?? user.assignedId,
          name: name ?? user.name,
          stack: stack ?? user.stack,
          isBtn: isBtn ?? user.isBtn,
          isAction: isAction ?? user.isAction,
          isCheck: isCheck ?? user.isCheck,
          isFold: isFold ?? user.isFold,
          isSitOut: isSitOut ?? user.isSitOut,
          score: score ?? user.score,
        ).toJson());
      });
    } catch (e) {
      print('update_room');
      throw e;
    }
  }
}

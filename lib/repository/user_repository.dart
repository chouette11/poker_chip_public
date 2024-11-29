import 'package:poker_chip/data/preferences_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final userRepositoryProvider =
    Provider<UserRepository>((ref) => UserRepository(ref));

class UserRepository {
  UserRepository(this.ref);

  final Ref ref;

  /// ユーザーの名前を保存
  Future<void> saveName(String name) async {
    final pref = ref.read(preferencesProvider);
    pref.setString(PrefKey.name.name, name);
  }

  /// ユーザーの名前を取得
  Future<String?> getName() async {
    final pref = ref.read(preferencesProvider);
    final value = await pref.getString(PrefKey.name.name);
    return value;
  }

  Future<String> saveUID() async {
    final pref = ref.read(preferencesProvider);
    final value = const Uuid().v4();
    pref.setString(PrefKey.uid.name, value);
    return value;
  }

  /// ユーザーのIDを取得
  Future<String> getUID() async {
    final pref = ref.read(preferencesProvider);
    final value = await pref.getString(PrefKey.uid.name);
    return value ?? await saveUID();
  }
}

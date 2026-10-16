import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_user.dart';

/// Локальное хранилище - замена Firebase Realtime Database.
class StorageService {
  static const _key = 'users';

  static Future<void> saveUser(AppUser user) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    list.add(user.toJson());
    await prefs.setStringList(_key, list);
  }

  static Future<List<AppUser>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    return list.map(AppUser.fromJson).toList().reversed.toList();
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}

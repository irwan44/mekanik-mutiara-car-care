import 'package:get_storage/get_storage.dart';
import 'package:mekanik/app/data/publik.dart';

class LocalStorages {
  static GetStorage boxToken = GetStorage('token-mekanik');
  static GetStorage boxRole = GetStorage('role-mekanik'); // Separate storage for role

  static Future<bool> hasToken() async {
    String token = await getToken;
    return token.isNotEmpty;
  }

  static Future<void> setToken(String token) async {
    await boxToken.write('token', token);
    Publics.controller.getToken.value = LocalStorages.getToken;
    return;
  }

  static String get getToken => boxToken.listenable.value['token'] ?? '';

  static Future<void> deleteToken() async {
    await boxToken.remove('token');
    Publics.controller.getToken.value = '';
  }

  static Future<void> logout() async {
    await deleteToken();
    await deleteRole();
  }

  static Future<void> setRole(String role) async {
    await boxRole.write('role', role);
    return;
  }

  static String get getRole => boxRole.listenable.value['role'] ?? '';

  static Future<void> deleteRole() async {
    await boxRole.remove('role');
  }
}

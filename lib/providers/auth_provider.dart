import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:crypto/crypto.dart';

class AuthProvider extends ChangeNotifier {
  static late Box _usersBox;
  static late Box _sessionBox;

  static Future<void> init() async {
    _usersBox = await Hive.openBox('users');
    _sessionBox = await Hive.openBox('session');
  }

  bool get isLoggedIn => _sessionBox.get('email') != null;
  String? get currentEmail => _sessionBox.get('email');

  Future<bool> signUp(String email, String password) async {
    if (_usersBox.containsKey(email)) return false; // already exists
    final hash = sha256.convert(utf8.encode(password)).toString();
    await _usersBox.put(email, hash);
    await _sessionBox.put('email', email);
    notifyListeners();
    return true;
  }

  Future<bool> login(String email, String password) async {
    final hash = sha256.convert(utf8.encode(password)).toString();
    final saved = _usersBox.get(email);
    if (saved == hash) {
      await _sessionBox.put('email', email);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _sessionBox.delete('email');
    notifyListeners();
  }
}

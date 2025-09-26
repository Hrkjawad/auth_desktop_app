import 'package:auth_desktop_app/data/model/user_info.dart';

import '../../data/repository/auth_repository.dart';

class Auth {
  final AuthRepository _repo = AuthRepository();
  UserInfo? _loggedInUser;
  UserInfo? get currentUser => _loggedInUser;

  Future<bool> register(UserInfo user) async {
    try {
      await _repo.register(user);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    final user = await _repo.login(email, password);
    if (user != null) {
      _loggedInUser = user;
      return true;
    }
    return false;
  }

  void logout() {
    _loggedInUser = null;
  }

  bool get isLoggedIn => _loggedInUser != null;
}

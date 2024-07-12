import 'package:bloc_app/data/dataprovider/auth_ql.dart';
import 'package:bloc_app/data/models/user.dart';

class AuthRepo {
  final AuthQl _authQl;
  AuthRepo(this._authQl);

  Future<String?> login(String email, String password) async {
    final rawResponse = await _authQl.login(email, password);
    return rawResponse!['login'];
  }

  Future<User?> tryAuth() async {
    final rawResponse = await _authQl.tryAuth();
    return rawResponse!['me'] != null ? User.fromMap(rawResponse['me']) : null;
  }

  // Future<String?> register(String email, String password, String confirmPassword) async {
  //   return await _authQl.register(email, password, confirmPassword);
  // }

  Future<bool> logout() async {
    final rawResponse = await _authQl.logout();
    return rawResponse!['logout'] != null;
  }
}

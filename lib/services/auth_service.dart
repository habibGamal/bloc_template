import 'package:bloc_app/constants/screens.dart';
import 'package:bloc_app/constants/secure_storage.dart';
import 'package:bloc_app/services/graphql_service.dart';
import 'package:flutter/widgets.dart';

class AuthService {
  final BuildContext _context;
  AuthService._(this._context);

  static of(BuildContext context) {
    return AuthService._(context);
  }

  authenticated() {
    GraphQLService.instance.resetClient();
    Navigator.of(_context).pushNamed(Screens.authHome);
  }

  authenticate(String token) {
    secureStorage
        .write(key: SecureStorageKeys.authToken, value: token)
        .then((_) {
      GraphQLService.instance.resetClient();
    });
    Navigator.of(_context).pushNamed(Screens.authHome);
  }

  logout() {
    secureStorage.delete(key: SecureStorageKeys.authToken).then((_) {
      GraphQLService.instance.resetClient();
    });
    Navigator.of(_context).pushNamed(Screens.login);
  }
}

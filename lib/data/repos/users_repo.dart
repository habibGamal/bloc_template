import 'dart:convert';

import 'package:bloc_app/data/dataprovider/users_ql.dart';
import 'package:bloc_app/data/models/user.dart';

class UsersRepo {
  final UsersQl _usersQl;

  UsersRepo(this._usersQl);

  Future<List<User>> getUsers() async {
    final rawUsers = await _usersQl.getUsersQl();
    return (rawUsers!['users']['data'] as List)
        .map((rawUser) => User.fromMap(rawUser))
        .toList();
  }
}

import 'package:bloc_app/services/graphql_service.dart';
// import 'package:http/http.dart' as http;

class AuthQl {
  final GraphQLService _graphQLService = GraphQLService.instance;
  Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await _graphQLService
        .performMutation(r'''mutation login($email: String!, $password: String!) {
        login(email: $email, password: $password)
      }
        ''', variables: {
      'email': 'habibmisi3@gmail.com',
      'password': 'Gh090807',
    });
    return response.data;
  }

  Future<Map<String, dynamic>?> tryAuth() async {
    final response = await _graphQLService.performQuery('''query me {
        me {
          id
          email
          }
      }''');
    return response.data;
  }

  Future<Map<String, dynamic>?> logout() async {
    final response = await _graphQLService.performMutation(
      r'''mutation logout {
        logout
      }
        ''',
    );
    return response.data;
  }
}

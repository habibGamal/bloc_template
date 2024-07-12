import 'package:bloc_app/services/graphql_service.dart';
// import 'package:http/http.dart' as http;

class UsersQl {
  final GraphQLService _graphQLService = GraphQLService.instance;
  Future<Map<String, dynamic>?> getUsersQl() async {
    final response = await _graphQLService.performQuery('''query MyQuery {
        users(first: 10) {
          data {
            id
            email
          }
        }
      }''');
    // print(response);
    return response.data;
  }
}

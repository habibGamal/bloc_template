import 'package:bloc_app/constants/secure_storage.dart';
import 'package:graphql/client.dart';

const timeout = Duration(seconds: 10);

class GraphQLService {
  GraphQLClient? _client;
  final HttpLink _httpLink = HttpLink('http://10.0.2.2:8000/graphql');
  static final GraphQLService _instance = GraphQLService._();

  GraphQLService._();

  factory GraphQLService() {
    return _instance;
  }

  static GraphQLService get instance => _instance;

  resetClient() async {
    final token = await secureStorage.read(key: SecureStorageKeys.authToken);
    if (token == null) {
      _client = GraphQLClient(link: _httpLink, cache: GraphQLCache());
      return;
    }
    AuthLink authLink = AuthLink(getToken: () async => 'Bearer $token');
    final link = authLink.concat(_httpLink);
    _client = GraphQLClient(link: link, cache: GraphQLCache());
  }

  Future<QueryResult> performQuery(
    String query, {
    Map<String, dynamic> variables = const {},
  }) async {
    QueryOptions options = QueryOptions(
      document: gql(query),
      variables: variables,
    );
    if (_client == null) await resetClient();
    try {
      final result = await _client!.query(options).timeout(timeout);
      if (result.hasException) throw result.exception!;
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<QueryResult> performMutation(String query,
      {Map<String, dynamic> variables = const {}}) async {
    MutationOptions options = MutationOptions(
      document: gql(query),
      variables: variables,
    );
    if (_client == null) await resetClient();
    try {
      final result = await _client!.mutate(options).timeout(timeout);
      if (result.hasException) throw result.exception!;
      return result;
    } catch (e) {
      rethrow;
    }
  }
}

// class TimeoutException implements Exception {
//   final String message;

//   TimeoutException(this.message);
// }

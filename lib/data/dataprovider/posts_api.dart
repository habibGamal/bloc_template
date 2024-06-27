import 'package:http/http.dart' as http;

class PostsApi {
  Future<String> getRawPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    return response.body;
  }
}

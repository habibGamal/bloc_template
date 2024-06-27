import 'dart:convert';

import 'package:bloc_app/data/dataprovider/posts_api.dart';
import 'package:bloc_app/data/models/post.dart';

class PostsRepo {
  final PostsApi _postsApi;

  PostsRepo(this._postsApi);

  Future<List<Post>> getPosts() async {
    final rawPosts = await _postsApi.getRawPosts();
    final postsJson = jsonDecode(rawPosts) as List;
    return postsJson.map((postJson) => Post.fromJson(postJson)).toList();
  }
}

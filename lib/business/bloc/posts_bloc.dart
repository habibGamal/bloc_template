import 'package:bloc_app/data/dataprovider/posts_api.dart';
import 'package:bloc_app/data/models/post.dart';
import 'package:bloc_app/data/repos/posts_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsEvent {}

class FetchPosts extends PostsEvent {}

enum PostsStatus { initial, loading, success, failure }

extension PostsStatusX on PostsStatus {
  bool get isLoading => this == PostsStatus.loading;
  bool get isSuccess => this == PostsStatus.success;
  bool get isFailure => this == PostsStatus.failure;
}

class PostsState {
  final List<Post> posts;
  final PostsStatus status;

  const PostsState(
      {this.status = PostsStatus.initial, this.posts = const <Post>[]});

  PostsState copyWith({List<Post>? posts, PostsStatus? status}) {
    return PostsState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
    );
  }
}

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepo _postsRepo = PostsRepo(PostsApi());
  PostsBloc() : super(const PostsState()) {
    on<FetchPosts>(_fetchPosts);
  }

  void _fetchPosts(FetchPosts event, Emitter<PostsState> emit) async {
    emit(state.copyWith(status: PostsStatus.loading));
    try {
      final posts = await _postsRepo.getPosts();
      emit(state.copyWith(posts: posts, status: PostsStatus.success));
    } catch (e) {
      emit(state.copyWith(status: PostsStatus.failure));
      print(e);
    }
  }
}

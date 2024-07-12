import 'dart:async';

import 'package:bloc_app/business/bloc/interceptor_bloc.dart';
import 'package:bloc_app/data/dataprovider/users_ql.dart';
import 'package:bloc_app/data/models/user.dart';
import 'package:bloc_app/data/repos/users_repo.dart';
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
  final List<User> posts;
  final PostsStatus status;

  const PostsState(
      {this.status = PostsStatus.initial, this.posts = const <User>[]});

  PostsState copyWith({List<User>? posts, PostsStatus? status}) {
    return PostsState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
    );
  }
}

class PostsBloc extends Bloc<PostsEvent, PostsState>
    with InterceptorMixen<PostsEvent, PostsState> {
  final UsersRepo _postsRepo = UsersRepo(UsersQl());
  @override
  final InterceptorBloc interceptorBloc;
  PostsBloc(this.interceptorBloc) : super(const PostsState()) {
    on<FetchPosts>(interceptor(_fetchPosts));
  }

  FutureOr<void> _fetchPosts(FetchPosts event, Emitter<PostsState> emit) async {
    emit(state.copyWith(status: PostsStatus.loading));
    final posts = await _postsRepo.getUsers();
    emit(state.copyWith(posts: posts, status: PostsStatus.success));
  }
}

import 'package:bloc_app/business/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() async {
  // await configureDependencies();
  // runApp(HookedBlocConfigProvider(
  //   injector: () => getIt.get,
  //   builderCondition: (state) => state != null, // Global build condition
  //   listenerCondition: (state) => state != null, // Global listen condition
  //   child: const MyApp(),
  // ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final posts = useBloc<PostsBloc>();
    final state = useBlocBuilder(posts);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (state.status.isLoading)
              const CircularProgressIndicator()
            else if (state.status.isFailure)
              const Text("Error fetching posts")
            else if (state.status.isSuccess)
              Text("Posts: ${state.posts.length}"),
            const Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(
                onPressed: () => {posts.add(FetchPosts())},
                child: const Text("Fetch Posts"))
          ],
        ),
      ),
    );
  }
}

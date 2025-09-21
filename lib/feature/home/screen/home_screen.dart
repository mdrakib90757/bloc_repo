import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serialman_app/feature/home/bloc/post_bloc.dart';
import 'package:serialman_app/feature/home/bloc/post_event.dart';
import 'package:serialman_app/feature/home/bloc/post_state.dart';
import 'package:serialman_app/feature/home/data/model/post_request.dart';
import 'package:serialman_app/feature/home/data/repository/post_reposiotry_impl.dart';

import '../../../data/model/post_user_model.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostBloc(PostRepositoryImpl()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Posts with Bloc")),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostInitial) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<PostBloc>().add(FetchPostEvent(1)); // postId = 1
                  },
                  child: const Text("Fetch Post"),
                ),
              );
            } else if (state is PostLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PostSuccess) {
              return const Center(child: Text("Success! (Post fetched/created)"));
            } else if (state is PostFailure) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const SizedBox();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final newPost = Post(
              userId: 1,
              id: 101,
              title: "Bloc created Post",
              body: "This is a post created via Bloc",
            );
            context.read<PostBloc>().add(CreatePostEvent(newPost));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}



import 'package:bloc/bloc.dart';
import 'package:serialman_app/feature/home/bloc/post_event.dart';
import 'package:serialman_app/feature/home/bloc/post_state.dart';

import '../data/repository/post_reposiotry_impl.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
 final PostRepositoryImpl repositoryImpl;
 PostBloc(this.repositoryImpl):super(PostInitial()){
  on<CreatePostEvent>((event, emit) async {
    emit(PostLoading());
    try {
      await repositoryImpl.createPostImpl(event.post);
      emit(PostSuccess());
    } catch (e) {
      emit(PostFailure(e.toString()));
    }
  });


  on<FetchPostEvent>((event, emit) async {
    emit(PostLoading());
    try {
      await repositoryImpl.fetchPostImpl(event.postId);
      emit(PostSuccess());
    } catch (e) {
      emit(PostFailure(e.toString()));
    }

  });

  }
}
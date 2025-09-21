
import 'package:serialman_app/data/provider/post_api/post_api.dart';
import 'package:serialman_app/feature/home/data/model/post_request.dart';

import '../../../../data/model/post_user_model.dart';
import '../../../../data/repository/post_repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {

  Future<void> createPostImpl(Post post) {
   try{
     final response = postApi.createPost(post);
     return response;
   } on Exception catch(e){
     throw Exception(e);
   }
  }

  Future<void> fetchPostImpl(int postId) {
    try{
      final response = postApi.fetchPost(postId);
      return response;
    } on Exception catch(e){
      throw Exception(e);
    }
  }

}
import '../../../feature/home/data/model/post_request.dart';
import '../../model/post_user_model.dart';

abstract class PostRepository{
  Future<void>createPostImpl(Post post);
}

abstract class fetchReposity{
  Future<void>fetchPostImpl(int postId);
}

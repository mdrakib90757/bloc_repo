

import '../../../data/model/post_user_model.dart';
import '../data/model/post_request.dart';

abstract class PostEvent{}


class CreatePostEvent extends PostEvent{
  final Post post;
  CreatePostEvent(this.post);
}

class FetchPostEvent extends PostEvent{
  final int postId;
  FetchPostEvent(this.postId);
}
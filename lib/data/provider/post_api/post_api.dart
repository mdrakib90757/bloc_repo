
import 'package:dio/dio.dart';
import 'package:serialman_app/feature/home/data/model/post_request.dart';

import '../../model/post_user_model.dart';

class postApi{

  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<Post>fetchPost(int postId)async{
    final dio =Dio();
    final response = await dio.get('$baseUrl/posts/$postId');
    if(response.statusCode==200){
      return Post.fromJson(response.data);
    }else{
      throw Exception("Failed to fetch post ${response.statusCode}");
    }
  }


  static Future<void>createPost(Post post)async{
    final dio = Dio();
    final response = await dio.post("$baseUrl/posts",data: post.toJson());
    if(response.statusCode==201){
      print("Post created successfully");
    }else{
      throw Exception("Failed to create post ${response.statusCode}");
    }

  }



}
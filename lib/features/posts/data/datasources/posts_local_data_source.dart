import 'dart:convert';

import 'package:clean_architecture_posts_app/core/error/exceptions.dart';
import 'package:clean_architecture_posts_app/features/posts/data/models/posts_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostsLocalDataSource {
  Future<List<PostsModel>> getCachPosts();
  cachePost(List<PostsModel> getSavedData);
}

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostsLocalDataSourceImpl({required this.sharedPreferences});

 
  @override
  cachePost(List<PostsModel> getSavedData) {
    List postModelsToJson = getSavedData
        .map<Map<String, dynamic>>((x) => x.toJson())
        .toList();
    sharedPreferences.setString('cachedPosts', jsonEncode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostsModel>> getCachPosts() {
    final jsonString = sharedPreferences.getString('cachedPosts');
    if (jsonString != null) {
      final List decodedJsonData = jsonDecode(jsonString);
      final List<PostsModel> posts = decodedJsonData
          .map<PostsModel>(
            (jsonPostsModel) => PostsModel.fromJson(jsonPostsModel),
          )
          .toList();
      return Future.value(posts);
    } else {
      throw EmptyCacheExcetion();
    }
  }
}

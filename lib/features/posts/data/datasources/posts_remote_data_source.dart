// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:clean_architecture_posts_app/core/error/exceptions.dart';
import 'package:clean_architecture_posts_app/features/posts/data/models/posts_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://jsonplaceholder.typicode.com";
//https://jsonplaceholder.typicode.com/posts/

abstract class PostsRemoteDataSource {
  Future<List<PostsModel>> getAllPosts();
  Future<Unit> deletPost(int postid);
  Future<Unit> updatePost(PostsModel post);
  Future<Unit> addPost(PostsModel post);
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final url = Uri.https('jsonplaceholder.typicode.com', 'posts');

  @override
  Future<List<PostsModel>> getAllPosts() async {
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final List decodeJson = jsonDecode(response.body);

      final List<PostsModel> postList = decodeJson.map<PostsModel>(
        (jsonPostModel) => PostsModel.fromJson(jsonPostModel)).toList();
      return (postList);
    } else {
      throw ServerException();
    }
  }
  //   @override
  // Future<List<PostsModel>> getAllPosts() async {
  //   final response = await http.get(
  //     url,
  //     headers: {"Content-Type": "application/json"},
  //   );

  //   if (response.statusCode == 200 && response.body.isNotEmpty) {
  //     final decoded = jsonDecode(response.body);

  //     if (decoded == null || decoded is! Map<String, dynamic> || decoded.isEmpty) {

  //       return [];
  //     }

  //     final Map<String, dynamic> decodeJson = decoded;

  //     final List<PostsModel> postList = decodeJson.values
  //         .map<PostsModel>((jsonPostModel) => PostsModel.fromJson(jsonPostModel))
  //         .toList();

  //     return postList;
  //   } else {
  //     throw ServerException();
  //   }
  // }

  @override
  Future<Unit> addPost(PostsModel post) async {
    final response = await http.post(url, body: ({
      "id":post.id,
      "title":post.title,
      "body":post.body
    }), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<Unit> deletPost(int postid) async {
    final url1 = Uri.https('jsonplaceholder.typicode.com', 'posts/$postid');
    final response = await http.delete(url1);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostsModel post) async {
    final url1 = Uri.https('jsonplaceholder.typicode.com', 'posts/${post.id}');
    final response = await http.patch(url1, body: (jsonEncode(post.toJson())), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}

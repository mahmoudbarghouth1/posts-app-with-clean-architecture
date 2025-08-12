import 'package:clean_architecture_posts_app/core/error/exceptions.dart';
import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/core/network/network_info.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasources/posts_local_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/models/posts_model.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

typedef DeleteOrAddOrUpdate = Future<Unit> Function();

class PostsRepositoryImpl implements PostsRepository {
  final PostsRemoteDataSource postsRemoteDataSource;
  final PostsLocalDataSource postsLocalDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl({required this.postsRemoteDataSource, required this.postsLocalDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await postsRemoteDataSource.getAllPosts();
        postsLocalDataSource.cachePost(remotePosts);
        return right(remotePosts);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postsLocalDataSource.getCachPosts();
        return right(localPosts);
      } on EmptyCacheExcetion {
        return left(EmptyCashFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostsModel postModel = PostsModel(title1: post.title, body1: post.body);
    return await _getMessage(() {
      return postsRemoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletPost(int postid) async {
    return await _getMessage(() {
      return postsRemoteDataSource.deletPost(postid);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    PostsModel postsModel = PostsModel(id1: post.id, title1: post.title, body1: post.body);
    return await _getMessage(() {
      return postsRemoteDataSource.updatePost(postsModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(DeleteOrAddOrUpdate addOrDleteOrUpdate) async {
    if (await networkInfo.isConnected) {
      try {
        await addOrDleteOrUpdate();
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(OffLineFailure());
    }
  }
}

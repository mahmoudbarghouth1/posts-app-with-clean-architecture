import 'package:clean_architecture_posts_app/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class AddPostUseCase {
  
  final PostsRepository postsRepository;

  AddPostUseCase({required this.postsRepository});

  Future <Either<Failure,Unit>> call(Post post) async {
    return  await postsRepository.addPost(post);
  }
}

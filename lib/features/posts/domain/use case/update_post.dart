import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class UpdatePostUseCase {
  final PostsRepository postsRepository;

  UpdatePostUseCase({required this.postsRepository});

  
  Future  <Either<Failure,Unit>> call(Post post) async {
    return await postsRepository.updatePost(post);
  }
}

import 'package:clean_architecture_posts_app/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class DeletPostUseCae {
  final PostsRepository postsRepository;

  DeletPostUseCae({required this.postsRepository});


   Future <Either<Failure,Unit>> call(int id) async {
    return await postsRepository.deletPost(id);
  }
}

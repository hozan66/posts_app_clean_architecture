// Packages
import 'package:dartz/dartz.dart';

// Entities
import '../entities/post.dart';

// Repositories
import '../repositories/base_posts_repository.dart';

// Core
import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/base_use_case.dart';

class AddPostUseCase implements BaseUseCase<Unit, Post> {
  final BasePostsRepository basePostsRepository;

  AddPostUseCase({required this.basePostsRepository});

  @override
  Future<Either<Failure, Unit>> call(Post post) async {
    return await basePostsRepository.addPost(post);
  }
}

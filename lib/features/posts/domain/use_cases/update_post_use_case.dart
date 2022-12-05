// Packages
import 'package:dartz/dartz.dart';

// Core
import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/base_use_case.dart';

// Entities
import '../entities/post.dart';

// Repositories
import '../repositories/base_posts_repository.dart';

class UpdatePostUseCase implements BaseUseCase<Unit, Post> {
  final BasePostsRepository basePostsRepository;

  UpdatePostUseCase({required this.basePostsRepository});

  @override
  Future<Either<Failure, Unit>> call(Post post) async {
    return await basePostsRepository.updatePost(post);
  }
}

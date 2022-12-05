// Repositories
import '../repositories/base_posts_repository.dart';

// Packages
import 'package:dartz/dartz.dart';

// Core
import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/base_use_case.dart';

class DeletePostUseCase implements BaseUseCase<Unit, int> {
  final BasePostsRepository basePostsRepository;

  DeletePostUseCase({required this.basePostsRepository});

  @override
  Future<Either<Failure, Unit>> call(int postId) async {
    return await basePostsRepository.deletePost(postId);
  }
}

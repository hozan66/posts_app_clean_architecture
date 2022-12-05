// Repositories
import '../repositories/base_posts_repository.dart';

// Packages
import 'package:dartz/dartz.dart';

// Core
import '../../../../core/use_cases/base_use_case.dart';
import '../../../../core/error/failures.dart';

// Entities
import '../entities/post.dart';

// Callable class because we have call() method
// So we can call the class as a method ==> GetAllPostsUseCase()
class GetAllPostsUseCase implements BaseUseCase<List<Post>, NoParams> {
  final BasePostsRepository basePostsRepository;

  GetAllPostsUseCase({required this.basePostsRepository});

  @override
  Future<Either<Failure, List<Post>>> call(NoParams params) async {
    return await basePostsRepository.getAllPosts();
  }
}

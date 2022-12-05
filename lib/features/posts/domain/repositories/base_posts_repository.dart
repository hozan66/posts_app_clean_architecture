// Packages
import 'package:dartz/dartz.dart';

// Core
import '../../../../core/error/failures.dart';

// Entities
import '../entities/post.dart';

// Common between data layer and domain layer
abstract class BasePostsRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();

  // Unit ==> means return nothing
  // We must use Unit but not void because void is not data type
  Future<Either<Failure, Unit>> deletePost(int id);

  Future<Either<Failure, Unit>> updatePost(Post post);

  Future<Either<Failure, Unit>> addPost(Post post);
}

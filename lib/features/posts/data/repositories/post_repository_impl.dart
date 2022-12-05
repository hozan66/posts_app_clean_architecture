// Packages
import 'dart:developer';
import 'package:dartz/dartz.dart';

// Core
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';

// Entities
import '../../domain/entities/post.dart';

// Repositories
import '../../domain/repositories/base_posts_repository.dart';

// Data Sources
import '../data_sources/post_local_data_source.dart';
import '../data_sources/post_remote_data_source.dart';

// Models
import '../models/post_model.dart';

// typedef Future<Unit> DeleteOrUpdateOrAddPost();
typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostsRepositoryImpl implements BasePostsRepository {
  final BasePostRemoteDataSource basePostRemoteDataSource;
  final BasePostLocalDataSource basePostLocalDataSource;
  final BaseNetworkInfo baseNetworkInfo;

  PostsRepositoryImpl({
    required this.basePostRemoteDataSource,
    required this.basePostLocalDataSource,
    required this.baseNetworkInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    final bool isConnected = await baseNetworkInfo.isConnected;
    log(name: 'Check Internet', isConnected.toString());
    log('=========================');
    if (isConnected) {
      try {
        final List<PostModel> remotePosts =
            await basePostRemoteDataSource.getAllPosts();

        // Save data into local storage
        basePostLocalDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final List<PostModel> localPosts =
            await basePostLocalDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel = PostModel(title: post.title, body: post.body);

    return await _getMessage(() {
      return basePostRemoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMessage(() {
      return basePostRemoteDataSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);

    return await _getMessage(() {
      return basePostRemoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    if (await baseNetworkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}

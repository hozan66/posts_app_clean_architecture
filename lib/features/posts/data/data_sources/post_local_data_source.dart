// Packages
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core
import '../../../../core/api/end_points.dart';
import '../../../../core/error/exceptions.dart';

// Models
import '../models/post_model.dart';

abstract class BasePostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();

  Future<Unit> cachePosts(List<PostModel> postModels);
}

class PostLocalDataSourceImpl implements BasePostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelsToJson =
        postModels.map<Map<String, dynamic>>((e) => e.toJson()).toList();
    // Save to cache
    sharedPreferences.setString(
        EndPoints.cachedPosts, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final String? jsonString =
        sharedPreferences.getString(EndPoints.cachedPosts);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels =
          decodeJsonData.map<PostModel>((e) => PostModel.fromJson(e)).toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}

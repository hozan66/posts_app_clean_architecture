// Packages
import 'dart:convert';
// import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

// Core
import '../../../../core/api/end_points.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/app_strings.dart';

// Models
import '../models/post_model.dart';

abstract class BasePostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost(int postId);

  Future<Unit> updatePost(PostModel postModel);

  Future<Unit> addPost(PostModel postModel);
}

class PostRemoteDataSourceImpl implements BasePostRemoteDataSource {
  final http.Client client;
  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final http.Response response = await client.get(
      Uri.parse(EndPoints.postsUrl),
      headers: {AppStrings.contentType: AppStrings.applicationJson},
    );

    // log(response.body.toString());
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels =
          decodedJson.map<PostModel>((e) => PostModel.fromJson(e)).toList();

      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final Map<String, String> body = {
      'title': postModel.title,
      'body': postModel.body,
    };

    final http.Response response =
        await client.post(Uri.parse(EndPoints.postsUrl), body: body);

    // statusCode = 201 for creating a post
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final http.Response response = await client.delete(
      Uri.parse('${EndPoints.postsUrl}$postId'),
      headers: {AppStrings.contentType: AppStrings.applicationJson},
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  // PUT and PATCH requests are HTTP verbs and both relate to updating the resources at a location.
  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final String postId = postModel.id.toString();
    final Map<String, String> body = {
      'title': postModel.title,
      'body': postModel.body,
    };

    final http.Response response = await client.patch(
      Uri.parse('${EndPoints.postsUrl}$postId'),
      body: body,
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}

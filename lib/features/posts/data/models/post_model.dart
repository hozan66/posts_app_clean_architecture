// Entities
import '../../domain/entities/post.dart';

class PostModel extends Post {
  // const PostModel({
  //   int? id,
  //   required String title,
  //   required String body,
  // }) : super(id: id, title: title, body: body);

  const PostModel({
    super.id,
    required super.title,
    required super.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}

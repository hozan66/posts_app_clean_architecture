// Packages
import 'package:flutter/material.dart';

// Config
import 'package:posts_app_clean_architecture/config/routes/app_routes.dart';

// Entities
import '../../../domain/entities/post.dart';

// Screens
import '../../screens/post_detail_screen.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostListWidget({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(posts[index].id.toString()),
          title: Text(
            posts[index].title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            posts[index].body,
            style: const TextStyle(fontSize: 16),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          onTap: () {
            navigateTo(context, PostDetailScreen(post: posts[index]));
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(thickness: 1),
    );
  }
}

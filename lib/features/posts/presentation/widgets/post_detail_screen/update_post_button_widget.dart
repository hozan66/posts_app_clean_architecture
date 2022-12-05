// Packages
import 'package:flutter/material.dart';

// Config
import 'package:posts_app_clean_architecture/config/routes/app_routes.dart';

// Entities
import '../../../domain/entities/post.dart';

// Screens
import '../../screens/post_add_update_screen.dart';

class UpdatePostButtonWidget extends StatelessWidget {
  final Post post;

  const UpdatePostButtonWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        navigateTo(
          context,
          PostAddUpdateScreen(
            isUpdatePost: true,
            post: post,
          ),
        );
      },
      icon: const Icon(Icons.edit),
      label: const Text('Edit'),
    );
  }
}

// Core
import '../../../../core/utils/snack_bar_message.dart';
import '../../../../core/widgets/loading_widget.dart';

// Config
import 'package:posts_app_clean_architecture/config/routes/app_routes.dart';

// Blocs
import '../controllers/blocs/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';

// Widgets
import '../widgets/post_add_update_screen/form_widget.dart';

// Screens
import 'posts_screen.dart';

// Packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Entities
import '../../domain/entities/post.dart';

class PostAddUpdateScreen extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  const PostAddUpdateScreen({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(title: Text(isUpdatePost ? 'Edit Post' : 'Add Post'));
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
          listener: (context, state) {
            if (state is MessageAddDeleteUpdatePostState) {
              SnackBarMessage().showSuccessSnackBar(
                message: state.message,
                context: context,
              );

              navigateAndFinish(context, const PostsScreen());
            } else if (state is ErrorAddDeleteUpdatePostState) {
              SnackBarMessage()
                  .showErrorSnackBar(message: state.message, context: context);
            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState) {
              return const LoadingWidget();
            }

            return FormWidget(
                isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
          },
        ),
      ),
    );
  }
}

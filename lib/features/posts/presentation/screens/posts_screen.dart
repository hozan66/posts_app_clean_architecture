// Packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Core
import '../../../../core/widgets/loading_widget.dart';

// Config
import '../../../../config/routes/app_routes.dart';

// Blocs
import '../controllers/blocs/posts_bloc/posts_bloc.dart';

// Widgets
import '../widgets/posts_screen/message_display_widget.dart';
import '../widgets/posts_screen/post_list_widget.dart';

// Screens
import 'post_add_update_screen.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingButton(context),
    );
  }

  AppBar _buildAppbar() => AppBar(title: const Text('Posts'));

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return const LoadingWidget();
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: PostListWidget(posts: state.posts));
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(
              message: state.message,
              onPress: () => _onRefresh(context),
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }

  Widget _buildFloatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        navigateTo(
          context,
          const PostAddUpdateScreen(
            isUpdatePost: false,
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

// Packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config
import 'package:posts_app_clean_architecture/config/routes/app_routes.dart';

// Core
import '../../../../../core/utils/snack_bar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';

// Blocs
import '../../controllers/blocs/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';

// Screens
import '../../screens/posts_screen.dart';

// Widgets
import 'delete_dialog_widget.dart';

class DeletePostButtonWidget extends StatelessWidget {
  final int postId;
  const DeletePostButtonWidget({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.redAccent,
        ),
      ),
      onPressed: () => deleteDialog(context, postId),
      icon: const Icon(Icons.delete_outline),
      label: const Text('Delete'),
    );
  }

  void deleteDialog(BuildContext context, int postId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeleteUpdatePostBloc,
              AddDeleteUpdatePostState>(
            listener: (context, state) {
              if (state is MessageAddDeleteUpdatePostState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);

                navigateAndFinish(context, const PostsScreen());
              } else if (state is ErrorAddDeleteUpdatePostState) {
                Navigator.of(context).pop();
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdatePostState) {
                return const AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(postId: postId);
            },
          );
        });
  }
}

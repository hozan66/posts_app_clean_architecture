// Packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config
import 'config/themes/app_theme.dart';

// Blocs
import 'features/posts/presentation/controllers/blocs/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';
import 'features/posts/presentation/controllers/blocs/posts_bloc/posts_bloc.dart';

// Posts Injections
import 'injections/posts_injections.dart';

// Screens
import 'features/posts/presentation/screens/posts_screen.dart';

class PostApp extends StatelessWidget {
  const PostApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => sl.get<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (context) => sl.get<AddDeleteUpdatePostBloc>()),
      ],
      child: MaterialApp(
        title: 'Posts App',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: const PostsScreen(),
      ),
    );
  }
}

// Packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Post App
import 'post_app.dart';

// App Bloc Observer
import 'app_bloc_observer.dart';

// Posts Injections
import 'injections/posts_injections.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PostsInjections().init();

  Bloc.observer = AppBlocObserver();
  runApp(const PostApp());
}

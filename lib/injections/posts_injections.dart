// Packages
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core
import '../core/network/network_info.dart';

// DataSources
import '../features/posts/data/data_sources/post_local_data_source.dart';
import '../features/posts/data/data_sources/post_remote_data_source.dart';

// Repositories
import '../features/posts/data/repositories/post_repository_impl.dart';
import '../features/posts/domain/repositories/base_posts_repository.dart';

// UseCases
import '../features/posts/domain/use_cases/add_post_use_case.dart';
import '../features/posts/domain/use_cases/delete_post_use_case.dart';
import '../features/posts/domain/use_cases/get_all_posts_use_case.dart';
import '../features/posts/domain/use_cases/update_post_use_case.dart';

// Blocs
import '../features/posts/presentation/controllers/blocs/add_delete_update_post_bloc/add_delete_update_post_bloc.dart';
import '../features/posts/presentation/controllers/blocs/posts_bloc/posts_bloc.dart';

// sl => serviceLocator
final GetIt sl = GetIt.instance;

class PostsInjections {
  Future<void> init() async {
//! Features - posts

// Blocs
    sl.registerFactory<PostsBloc>(() => PostsBloc(getAllPostsUseCase: sl()));
    sl.registerFactory<AddDeleteUpdatePostBloc>(() => AddDeleteUpdatePostBloc(
          addPostUseCase: sl(),
          updatePostUseCase: sl(),
          deletePostUseCase: sl(),
        ));

// UseCases
    sl.registerLazySingleton<GetAllPostsUseCase>(
        () => GetAllPostsUseCase(basePostsRepository: sl()));
    sl.registerLazySingleton<AddPostUseCase>(
        () => AddPostUseCase(basePostsRepository: sl()));
    sl.registerLazySingleton<DeletePostUseCase>(
        () => DeletePostUseCase(basePostsRepository: sl()));
    sl.registerLazySingleton<UpdatePostUseCase>(
        () => UpdatePostUseCase(basePostsRepository: sl()));

// Repositories
    sl.registerLazySingleton<BasePostsRepository>(() => PostsRepositoryImpl(
          basePostRemoteDataSource: sl(),
          basePostLocalDataSource: sl(),
          baseNetworkInfo: sl(),
        ));

// DataSources
    sl.registerLazySingleton<BasePostRemoteDataSource>(
        () => PostRemoteDataSourceImpl(client: sl()));
    sl.registerLazySingleton<BasePostLocalDataSource>(
        () => PostLocalDataSourceImpl(sharedPreferences: sl()));

//! Core
    sl.registerLazySingleton<BaseNetworkInfo>(() => NetworkInfoImpl());

//! External
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton(() => http.Client());
    // sl.registerLazySingleton(() => InternetConnectionChecker());
  }
}

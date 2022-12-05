// Packages
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Core
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/use_cases/base_use_case.dart';
import '../../../../../../core/utils/app_strings.dart';

// Entities
import '../../../../domain/entities/post.dart';

// UseCases
import '../../../../domain/use_cases/get_all_posts_use_case.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase; // Callable Class
  PostsBloc({
    required this.getAllPostsUseCase,
  }) : super(PostsInitialState()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());

        // getAllPostsUseCase() Callable Class
        final Either<Failure, List<Post>> failureOrPosts =
            // await getAllPostsUseCase.call(NoParams());
            await getAllPostsUseCase(NoParams());
        emit(_mapFailureOrPostsToState(failureOrPosts));
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());

        // getAllPostsUseCase() Callable Class
        final Either<Failure, List<Post>> failureOrPosts =
            // await getAllPostsUseCase.call(NoParams());
            await getAllPostsUseCase(NoParams());
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }

  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
      (posts) => LoadedPostsState(
        posts: posts,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailureMessage;
      case EmptyCacheFailure:
        return AppStrings.emptyCacheFailureMessage;
      case OfflineFailure:
        return AppStrings.offlineFailureMessage;
      default:
        return AppStrings.unexpectedError;
    }
  }
}

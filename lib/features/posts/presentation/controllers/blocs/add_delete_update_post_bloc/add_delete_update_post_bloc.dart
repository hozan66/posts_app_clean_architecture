// Packages
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Core
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/utils/app_strings.dart';
// Entities
import '../../../../domain/entities/post.dart';
// UseCases
import '../../../../domain/use_cases/add_post_use_case.dart';
import '../../../../domain/use_cases/delete_post_use_case.dart';
import '../../../../domain/use_cases/update_post_use_case.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  // Callable Class
  final AddPostUseCase addPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  AddDeleteUpdatePostBloc(
      {required this.addPostUseCase,
      required this.deletePostUseCase,
      required this.updatePostUseCase})
      : super(AddDeleteUpdatePostInitialState()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());

        final Either<Failure, Unit> failureOrDoneMessage =
            await addPostUseCase(event.post);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, AppStrings.addSuccessMessage),
        );
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());

        final Either<Failure, Unit> failureOrDoneMessage =
            await updatePostUseCase(event.post);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, AppStrings.updateSuccessMessage),
        );
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());

        final Either<Failure, Unit> failureOrDoneMessage =
            await deletePostUseCase(event.postId);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, AppStrings.deleteSuccessMessage),
        );
      }
    });
  }

  AddDeleteUpdatePostState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdatePostState(
        message: _mapFailureToMessage(failure),
      ),
      // _ here is unit
      (_) => MessageAddDeleteUpdatePostState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailureMessage;
      case OfflineFailure:
        return AppStrings.offlineFailureMessage;
      default:
        return AppStrings.unexpectedError;
    }
  }
}

// Packages
import 'package:equatable/equatable.dart';

// Each failure must have exception
abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

// In case we don't have data saved locally
class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

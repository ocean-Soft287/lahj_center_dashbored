part of 'government_cubit.dart';

@immutable
abstract class GovernmentState {}

class GovernmentInitial extends GovernmentState {}

class GovernmentLoading extends GovernmentState {}

class GovernmentLoaded extends GovernmentState {
  final List<Government> governments;
  GovernmentLoaded(this.governments);
}

class GovernmentAdded extends GovernmentState {
  final Government government;
  GovernmentAdded(this.government);
}

class GovernmentUpdated extends GovernmentState {
  final Government government;
  GovernmentUpdated(this.government);
}

class GovernmentDeleted extends GovernmentState {
  final String message;
  GovernmentDeleted(this.message);
}

class GovernmentError extends GovernmentState {
  final String message;
  GovernmentError(this.message);
}

class GovernmentActionLoading extends GovernmentState {}

class GovernmentActionError extends GovernmentState {
  final String message;
  GovernmentActionError(this.message);
}

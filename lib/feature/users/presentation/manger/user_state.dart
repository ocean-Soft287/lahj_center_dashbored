part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;

  UserLoaded(this.users);
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}

class AddUserSuccess extends UserState {}

class AddUserError extends UserState {
  final String message;

  AddUserError(this.message);
}

class DeleteSuccess extends UserState {
  final String message;

  DeleteSuccess([this.message = 'User deleted successfully.']);
}

class DeleteUserError extends UserState {
  final String message;

  DeleteUserError([this.message = 'Failed to delete user.']);
}

class UpdateUserSuccess extends UserState {}
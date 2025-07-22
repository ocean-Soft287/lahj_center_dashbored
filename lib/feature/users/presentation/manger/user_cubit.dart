
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:lahj_center/feature/users/data/model/succesresponde.dart';
import 'package:lahj_center/feature/users/data/model/user_model.dart';
import 'package:lahj_center/feature/users/data/userrepo/user_repo.dart';
import 'package:lahj_center/core/utils/Failure/failure.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepo) : super(UserInitial());

  final UserRepo userRepo;

  List<User> users = [];

  /// Fetch all users
  Future<void> getUsers() async {
    emit(UserInitial());
    final Either<Failure, List<User>> response = await userRepo.getuser();

    response.fold(
          (failure) => emit(UserError(_mapFailureToMessage(failure))),
          (data) {
        users = data;
        emit(UserLoaded(List<User>.from(data)));
      },
    );
  }

  /// Delete user and refresh list
  Future<void> delete(String id) async {
    final Either<Failure, String> response = await userRepo.deleteuserandallinformation(id);

    response.fold(
          (failure) => emit(DeleteUserError()),
          (data) {
        emit(DeleteSuccess());
        getUsers();
      },
    );
  }

  /// Block user and refresh list
  Future<void> block(String id) async {
    final Either<Failure, String> response = await userRepo.deleteandblock(id);

    response.fold(
          (failure) => emit(DeleteUserError()),
          (data) {
        emit(DeleteSuccess());
        getUsers();
      },
    );
  }

  /// Add new user and refresh list
  Future<void> addUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
    String? activity,
    required String role,
    dynamic imageFile,
    String? imageName,
  }) async {
    final Either<Failure, ResponseMessage> response = await userRepo.addmember(
      firstName,
      lastName,
      email,
      password,
      phoneNumber,
      activity,
      role,
      imageFile,
      imageName,
    );

    response.fold(
          (failure) => emit(AddUserError(_mapFailureToMessage(failure))),
          (_) {
        emit(AddUserSuccess());
        getUsers();
      },
    );
  }

  String _mapFailureToMessage(Failure failure) => failure.message;
}

import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lahj_center/feature/users/data/model/user_model.dart';
import 'package:lahj_center/feature/users/data/userrepo/user_repo.dart';
import 'package:lahj_center/core/utils/Failure/failure.dart';
import 'package:meta/meta.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

import '../../../../../feature/users/data/model/succesresponde.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepo) : super(UserInitial());

  final UserRepo userRepo;

  List<User> users = [];

  void getUsers() async {
    final Either<Failure, List<User>> response = await userRepo.getuser();

    response.fold(
          (failure) => emit(UserError(_mapFailureToMessage(failure))),
          (data) {
        users = data;
        emit(UserLoaded(List<User>.from(data)));
      },
    );
  }

  void delete(String id) async {
    final Either<Failure, String> response =
    await userRepo.deleteuserandallinformation(id);
    response.fold(
          (failure) => emit(DeleteUserError()),
          (_) {
        emit(DeleteSuccess());
        getUsers();
      },
    );
  }

  void block(String id) async {
    final Either<Failure, String> response =
    await userRepo.deleteandblock(id);
    response.fold(
          (failure) => emit(DeleteUserError()),
          (_) {
        emit(DeleteSuccess());
        getUsers();
      },
    );
  }

  void addUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
    String? activity,
    required String role,
    XFile? pickedXFile,
    Uint8List? pickedBytes,
  }) async {
    MultipartFile? imagePart;

    if (kIsWeb && pickedBytes != null) {
      imagePart = MultipartFile.fromBytes(
        pickedBytes,
        filename: 'profile_${DateTime.now().millisecondsSinceEpoch}.png',
        contentType: MediaType('image', 'png'),
      );
    } else if (!kIsWeb && pickedXFile != null) {
      imagePart = await MultipartFile.fromFile(
        pickedXFile.path,
        filename: path.basename(pickedXFile.path),
      );
    }

    final Either<Failure, ResponseMessage> response = await userRepo.addmember(
      firstName,
      lastName,
      email,
      password,
      phoneNumber,
      activity,
      role,
      imagePart,
    );

    response.fold(
          (failure) => emit(UserError(_mapFailureToMessage(failure))),
          (_) {
        getUsers();
        emit(AddUserSuccess());
      },
    );
  }

  void updateUser({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
    String? activity,
    required String role,
    XFile? pickedXFile,
    Uint8List? pickedBytes,
  }) async {
    MultipartFile? imagePart;

    if (kIsWeb && pickedBytes != null) {
      imagePart = MultipartFile.fromBytes(
        pickedBytes,
        filename: 'profile_${DateTime.now().millisecondsSinceEpoch}.png',
        contentType: MediaType('image', 'png'),
      );
    } else if (!kIsWeb && pickedXFile != null) {
      imagePart = await MultipartFile.fromFile(
        pickedXFile.path,
        filename: path.basename(pickedXFile.path),
      );
    }

    final Either<Failure, ResponseMessage> response =
    await userRepo.updatemember(
      id,
      firstName,
      lastName,
      email,
      phoneNumber,
      password,
      imagePart,
      role,
      activity,
    );

    response.fold(
          (failure) => emit(UserError(_mapFailureToMessage(failure))),
          (_) {
        getUsers();
        emit(UpdateUserSuccess());
      },
    );
  }




  String _mapFailureToMessage(Failure failure) {
    return failure.message;
  }
}

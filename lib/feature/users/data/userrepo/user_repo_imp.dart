import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lahj_center/core/utils/Failure/failure.dart';
import 'package:lahj_center/core/utils/api/dio_consumer.dart';
import 'package:lahj_center/core/utils/api/endpoint.dart';
import 'package:lahj_center/feature/users/data/model/succesresponde.dart';
import 'package:lahj_center/feature/users/data/model/user_model.dart';
import 'user_repo.dart';

class UserRepoImp implements UserRepo {
  final DioConsumer dioConsumer;

  UserRepoImp({required this.dioConsumer});

  @override
  Future<Either<Failure, List<User>>> getuser() async {
    try {
      final response = await dioConsumer.get(EndPoint.getallmembers);
      if (response is List) {
        final users = response.map((e) => User.fromJson(e)).toList();
        return Right(users);
      } else {
        return Left(ServerFailure('Unexpected data type'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteuserandallinformation(String id) async {
    try {
      final response = await dioConsumer.post(
        EndPoint.deleteuser,
        queryParameters: {'userId': id},
      );

      if (response != "Member is Not Exist") {
        return Right("تم الحذف بنجاح");
      } else {
        return Left(ServerFailure('المستخدم غير موجود'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteandblock(String id) async {
    try {
      final response = await dioConsumer.post(
        EndPoint.deactivateanddelete,
        queryParameters: {'userId': id},
      );

      if (response != "Member is Not Exist") {
        return Right("تم الحظر والحذف بنجاح");
      } else {
        return Left(ServerFailure('المستخدم غير موجود'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseMessage>> addmember(
      String firstName,
      String lastName,
      String email,
      String password,
      String phoneNumber,
      String? activity,
      String role,
      dynamic imageFile,
      String? imageName,
      ) async {
    try {
      final formData = FormData();

      formData.fields.addAll([
        MapEntry('FirstName', firstName),
        MapEntry('LastName', lastName),
        MapEntry('Email', email),
        MapEntry('Password', password),
        MapEntry('PhoneNumber', phoneNumber),
        MapEntry('Activity', activity ?? ''),
        MapEntry('Role', role),
      ]);

      if (imageFile != null) {
        if (imageFile is File) {
          formData.files.add(
            MapEntry(
              'Image',
              await MultipartFile.fromFile(
                imageFile.path,
                filename: imageFile.uri.pathSegments.last,
              ),
            ),
          );
        } else if (imageFile is Uint8List) {
          formData.files.add(
            MapEntry(
              'Image',
              MultipartFile.fromBytes(
                imageFile,
                filename: imageName ?? 'uploaded_image.jpg',
              ),
            ),
          );
        }
      }

      final response = await dioConsumer.post(
        EndPoint.adminadd,
        data: formData,
        isFromData: true,
      );

      if (response["message"] == "Add Member successful.") {
        final message = ResponseMessage.fromJson(response);
        return Right(message);
      } else {
        return Left(ServerFailure('لم يتم إرجاع استجابة صحيحة من السيرفر'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

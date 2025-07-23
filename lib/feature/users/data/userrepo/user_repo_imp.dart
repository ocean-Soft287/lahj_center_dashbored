import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lahj_center/core/utils/Failure/failure.dart';
import 'package:lahj_center/core/utils/api/dio_consumer.dart';
import 'package:lahj_center/core/utils/api/endpoint.dart';
import 'package:lahj_center/feature/users/data/model/succesresponde.dart';
import 'package:lahj_center/feature/users/data/model/user_model.dart';
import 'package:lahj_center/feature/users/data/userrepo/user_repo.dart';

class UserRepoImp implements UserRepo {
  final DioConsumer dioConsumer;

  UserRepoImp({required this.dioConsumer});

  @override
  Future<Either<Failure, List<User>>> getuser() async {
    try {
      final response = await dioConsumer.get(EndPoint.getallmembers);

      if (response is List) {
        final List<User> users =
            response
                .map((e) => User.fromJson(e as Map<String, dynamic>))
                .toList();

        return Right(users);
      } else {
        return Left(ServerFailure('فشل في جلب اليوزرز: نوع بيانات غير متوقع'));
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
        queryParameters: {'userId': id}, // pass it here!
      );

      if (response != "Member is Not Exist") {
        return Right("تم الحظر والحذف بنجاح");
      } else {
        return Left(ServerFailure('المستخدم غير موجود'));
      }
    } catch (e) {
      return Left(ServerFailure('خطأ أثناء الحظر والحذف: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, String>> deleteuserandallinformation(String id) async {
    try {
      final response = await dioConsumer.post(
        EndPoint.deleteuser,
        queryParameters: {'userId': id}, // pass it here!
      );

      if (response != "Member is Not Exist") {
        return Right("تم الحظر والحذف بنجاح");
      } else {
        return Left(ServerFailure('المستخدم غير موجود'));
      }
    } catch (e) {
      return Left(ServerFailure('خطأ أثناء الحظر والحذف: ${e.toString()}'));
    }
  }

  @override
  @override
  @override
  Future<Either<Failure, ResponseMessage>> addmember(
      String firstName,
      String lastName,
      String email,
      String password,
      String phoneNumber,
      String? activity,
      String role,
      MultipartFile? imageFile, // ✅ هنا التعديل
      ) async {
    try {
      final formData = FormData();

      formData.fields.addAll([
        MapEntry('FirstName', firstName),
        MapEntry('LastName', lastName),
        MapEntry('Email', email),
        MapEntry('Password', password),
        MapEntry('PhoneNumber', phoneNumber),
        MapEntry('Activity', activity ?? ''), // optional
        MapEntry('Role', role),
      ]);

      if (imageFile != null) {
        formData.files.add(
          MapEntry(
            'Image',
            imageFile, // ✅ لا داعي لتحويل، مباشرة
          ),
        );
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
      return Left(ServerFailure('خطأ أثناء إضافة العضو: ${e.toString()}'));
    }
  }

  @override
  @override
  Future<Either<Failure, ResponseMessage>> updatemember(
      String id,
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String password,
      MultipartFile? imageFile,
      String role,
      String? activity,
      ) async {
    try {
      final formData = FormData();

      formData.fields.addAll([
        MapEntry('Id', id),  // 👈 include user ID
        MapEntry('FirstName', firstName),
        MapEntry('LastName', lastName),
        MapEntry('Email', email),
        MapEntry('PhoneNumber', phoneNumber),

        MapEntry('Password', password),
        MapEntry('Activity', activity ?? ''), // optional
        MapEntry('Role', role),
      ]);

      if (imageFile != null) {
        formData.files.add(
          MapEntry(
            'Image',
            imageFile,
          ),
        );
      }

      final response = await dioConsumer.post(
        EndPoint.adminupdate,  // 👈 make sure this endpoint is correct
        data: formData,
        isFromData: true,
      );

      if (response["message"] == "Update Member successful.") {
        final message = ResponseMessage.fromJson(response);
        return Right(message);
      } else {
        return Left(ServerFailure('لم يتم إرجاع استجابة صحيحة من السيرفر'));
      }
    } catch (e) {
      return Left(ServerFailure('خطأ أثناء تعديل بيانات العضو: ${e.toString()}'));
    }
  }


}

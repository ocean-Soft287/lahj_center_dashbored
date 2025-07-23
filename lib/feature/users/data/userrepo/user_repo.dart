import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/utils/Failure/failure.dart';
import '../model/succesresponde.dart';
import '../model/user_model.dart';

abstract class UserRepo{
  Future<Either<Failure,List<User>>>getuser();
  Future<Either<Failure,String>>deleteuserandallinformation(String id);
  Future<Either<Failure,String>>deleteandblock(String id);
  Future<Either<Failure, ResponseMessage>> addmember(
      String firstName,
      String lastName,
      String email,
      String password,
      String phoneNumber,
      String? activity,
      String role,
      MultipartFile? imageFile,
      );
  Future<Either<Failure, ResponseMessage>> updatemember(
      String id ,

      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String password,
      MultipartFile? imageFile,
      String role,

      String? activity,
      );
}
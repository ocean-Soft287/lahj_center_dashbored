import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lahj_center/core/utils/Failure/failure.dart';
import 'package:lahj_center/core/utils/api/dio_consumer.dart' show DioConsumer;
import 'package:lahj_center/feature/Auth/data/model/user_model.dart';
import 'package:lahj_center/feature/Auth/data/repo/repo.dart' show LoginRepo;
import '../../../../core/utils/Network/local/flutter_secure_storage.dart';
import '../../../../core/utils/api/endpoint.dart';

class Loginrepoimp implements LoginRepo{
  final DioConsumer dioConsumer;

  Loginrepoimp({required this.dioConsumer});

  @override
  Future<Either<Failure, String>> forgetpassword({
    required String email,
  }) async {
    try {
      final response = await dioConsumer.post(
        EndPoint.forgetpassw,
        data: {'email': email},
      );

      // طالما السيرفر بيرجع String صريح
      final responseMessage = response.toString();

      if (responseMessage.trim() == "Email is Not Exist") {
        return left(ServerFailure("This email is not registered."));
      }

      return right(responseMessage);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure("Forget password failed: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dioConsumer.post(
        EndPoint.login,
        data: {
          'email': email,
          'password': password,
          'rememberMe': true,
          "deviceToken": "P@ssw0rd",
        },
      );
      print("responseresponseresponse$response");

      print(response);
      final json = response as Map<String, dynamic>;
      final model = UserModel.fromJson(json);

      if (model.token.isEmpty) {
        return left(ServerFailure("Missing token in response."));
      }

if(!model.isAdmin)
{
  return left(ServerFailure("لا يوجد صلاحيه لك للدخول هنا"));

}

      // SecureStorage writes
      // await SecureStorageService.write(SecureStorageService.token, model.token);
      // await SecureStorageService.write(SecureStorageService.role, model.role);
      //
      // final token = await SecureStorageService.read(SecureStorageService.token);
      // final role = await SecureStorageService.read(SecureStorageService.role);
      // print("token$token");
      // print("role$role");

      return right(model);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure("Login failed: ${e.toString()}"));
    }
  }


  @override
  Future<Either<Failure, String>> resetpassword({
    required String email,
    required String token,
    required String newpassword,
  }) async {
    final data = {'email': email, 'token': token, 'newPassword': newpassword};

    try {
      final response = await dioConsumer.post(
        EndPoint.changePassconfirm,
        data: jsonEncode(data),
      );

      final responseMessage = response.toString();

      if (responseMessage.trim() == "Invalid or Expired Token") {
        return left(ServerFailure("TInvalid or Expired Token."));
      }

      return right(responseMessage);
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(ServerFailure("Reset password failed: ${e.toString()}"));
    }
  }


    Failure _handleDioError(DioException error) {
      return ServerFailure(error.message ?? "Unknown error occurred");
    }
  
}
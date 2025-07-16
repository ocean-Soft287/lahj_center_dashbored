import 'package:dartz/dartz.dart';
import 'package:lahj_center/core/utils/Failure/failure.dart';
import 'package:lahj_center/core/utils/api/endpoint.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/data/model/government.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/data/repo/government_repo.dart';
import '../../../../core/utils/api/dio_consumer.dart';


class Governmentrepoimp implements Governmentrepo {
  final DioConsumer dioConsumer;

  Governmentrepoimp({required this.dioConsumer});

  @override
  Future<Either<Failure, Government>> addGovernment(String arName, String enName) async {
    try {
      final response = await dioConsumer.post(
        EndPoint.addGovernorate,
        data: {'arName': arName, 'enName': enName},
      );

      if (response is Map<String, dynamic> && response != null) {
        final Government government = Government.fromJson(response['data']);
        return Right(government);
      } else {
        return Left(ServerFailure('فشل في إضافة المحافظة: بيانات غير متوقعة'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteGovernment(int id) async {
    try {
      final response = await dioConsumer.delete(
        '${EndPoint.baseUrl}/api/governorate/deleteGovernorate',
        queryParameters: {'id': id},
      );

      if (response.statusCode == 200) {
        return Right('تم حذف المحافظة بنجاح');
      } else {
        return Left(ServerFailure('فشل في حذف المحافظة: استجابة غير متوقعة'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Government>>> getGovernment() async {
    try {
      final response = await dioConsumer.get(EndPoint.getAllGovernorates);

      if (response is List) {
        final List<Government> governments = response
            .map((e) => Government.fromJson(e as Map<String, dynamic>))
            .toList();
        return Right(governments);
      } else {
        return Left(ServerFailure('فشل في جلب المحافظات: البيانات غير متوقعة'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Government>> updateGovernment(int id, String arName, String enName) async {
    try {
      final response = await dioConsumer.put(
        '${EndPoint.baseUrl}/api/governorate/updateGovernorate',
        data: {'id': id, 'arName': arName, 'enName': enName},
      );

      if (response is Map<String, dynamic> && response['data'] != null) {
        final Government government = Government.fromJson(response['data']);
        return Right(government);
      } else {
        return Left(ServerFailure('فشل في تحديث المحافظة: بيانات غير متوقعة'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
import 'package:dartz/dartz.dart';
import 'package:lahj_center/core/utils/Failure/failure.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/data/model/services.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/data/repo/services_repo.dart';
import '../../../../core/utils/api/dio_consumer.dart';
import '../../../../core/utils/api/endpoint.dart';


class ServicesRepoImp implements ServicesRepo {
  final DioConsumer dioConsumer;

  ServicesRepoImp({required this.dioConsumer});

  @override
  Future<Either<Failure, Services>> addServices(String arName, String enName) async {
    try {
      final response = await dioConsumer.post(
        EndPoint.Addservices,
        data: {
          "arName": arName,
          "enName": enName,
        },
      );
      final json = response as Map<String, dynamic>;
      final model = Services.fromJson(json);

      return Right(model);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteServices(int id) async {
    try {
      final response = await dioConsumer.delete(
        EndPoint.deleteService(id),
      );

      if (response.toString() == "Service Deleted Successfully") {
        return Right('تم حذف الخدمة بنجاح');
      } else {
        return Left(ServerFailure('فشل في حذف الخدمة: استجابة غير متوقعة'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Services>>> getServices() async {
    try {
      final response = await dioConsumer.get(EndPoint.getallServices);
      final List<Services> services = (response as List)
          .map((e) => Services.fromJson(e))
          .toList();
      return Right(services);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Services>> updateServices(int id, String arName, String enName) async {
    try {
      final response = await dioConsumer.put(
        EndPoint.updateservices,
        data: {
          "id": id,
          "arName": arName,
          "enName": enName,
        },
      );

      if (response is Map<String, dynamic>) {
        final Services services = Services.fromJson(response);
        return Right(services);
      } else {
        return Left(ServerFailure('فشل في تعديل الخدمة: بيانات غير متوقعة'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

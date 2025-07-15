import 'package:dartz/dartz.dart';
import 'package:lahj_center/core/utils/Failure/failure.dart';
import 'package:lahj_center/core/utils/api/dio_consumer.dart';
import 'package:lahj_center/core/utils/api/endpoint.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/data/model/currency.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/data/repo/currency_repo.dart';


class CurrencyRepoImp implements Currencyrepo {
  final DioConsumer dioConsumer;

  CurrencyRepoImp({required this.dioConsumer});

  @override
  Future<Either<Failure, List<Currency>>> getcurrency() async {
    try {
      final response = await dioConsumer.get(EndPoint.getcurrency);
      final List<Currency> currencies = (response as List)
            .map((e) => Currency.fromJson(e))
            .toList();
        return Right(currencies);

    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Currency>> addCurrency(String namearabic, String nameenglish) async {
    try {
      final response = await dioConsumer.post(
        EndPoint.addcurrrency,
        data: {
          "arName": namearabic,
          "enName": nameenglish,
        },
      );
      final json = response as Map<String, dynamic>;
      final model = Currency.fromJson(json);

      return Right(model);



    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Currency>> updateCurrency(int id, String arName, String enName) async {
    try {
      final response = await dioConsumer.put(
        EndPoint.updatecurrency,
        data: {
          "id": id,
          "arName": arName,
          "enName": enName,
        },
      );

      if (response is Map<String, dynamic>) {
        final Currency newCurrency = Currency.fromJson(response);
        return Right(newCurrency);
      } else {
        return Left(ServerFailure('فشل في تعديل العملة: بيانات غير متوقعة'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, String>> deleteCurrency(int id) async {
    try {
      final response = await dioConsumer.delete(
        EndPoint.deleteCurrency(id),
      );

      if (response.toString() == "Currency Deleted Successfully") {
        return Right('تم حذف العملة بنجاح'); // رسالة نجاح
      } else {
        return Left(ServerFailure('فشل في حذف العملة: استجابة غير متوقعة'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
import 'package:dartz/dartz.dart';
import 'package:lahj_center/core/utils/Failure/failure.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/data/model/currency.dart';


abstract class Currencyrepo {
  Future<Either<Failure, List<Currency>>> getcurrency();

  Future<Either<Failure, Currency>> addCurrency(String arName, String enName);

  Future<Either<Failure, Currency>> updateCurrency(int id, String arName, String enName);

  Future<Either<Failure, String>> deleteCurrency(int id);
}

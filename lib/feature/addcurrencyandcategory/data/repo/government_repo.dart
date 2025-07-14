import 'package:dartz/dartz.dart';

import '../../../../core/utils/Failure/failure.dart';
import '../model/government.dart';

abstract class Governmentrepo{
  Future<Either<Failure, List<Government>>> getGovernment();

  Future<Either<Failure, Government>> addGovernment(String arName, String enName);

  Future<Either<Failure, Government>> updateGovernment(int id, String arName, String enName);

  Future<Either<Failure, String>> deleteGovernment(int id);


}
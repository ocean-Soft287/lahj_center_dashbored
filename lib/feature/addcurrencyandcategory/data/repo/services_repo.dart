
import 'package:dartz/dartz.dart';

import '../../../../core/utils/Failure/failure.dart';
import '../model/services.dart';

abstract class ServicesRepo {
  Future<Either<Failure, List<Services>>> getServices();

  Future<Either<Failure, Services>> addServices(String arName, String enName);

  Future<Either<Failure, Services>> updateServices(
      int id,
      String arName,
      String enName,
      );

  Future<Either<Failure, String>> deleteServices(int id);
}

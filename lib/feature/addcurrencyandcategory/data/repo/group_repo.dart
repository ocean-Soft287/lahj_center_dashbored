import 'package:dartz/dartz.dart';
import '../../../../core/utils/Failure/failure.dart';
import '../model/group.dart';

abstract class GroupRepo {
  Future<Either<Failure, List<Group>>> getgroup();

  Future<Either<Failure, Group>> addgroup(String arName, String enName);

  Future<Either<Failure, Group>> updategroup(
    int id,
    String arName,
    String enName,
  );

  Future<Either<Failure, String>> deletegroup(int id);
}

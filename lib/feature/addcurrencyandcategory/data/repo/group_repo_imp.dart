import 'package:dartz/dartz.dart';
import 'package:lahj_center/core/utils/Failure/failure.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/data/model/group.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/data/repo/group_repo.dart';

import '../../../../core/utils/api/dio_consumer.dart';
import '../../../../core/utils/api/endpoint.dart';

class GroupRepoImp implements GroupRepo {
  final DioConsumer dioConsumer;

  GroupRepoImp({required this.dioConsumer});

  @override
  Future<Either<Failure, List<Group>>> getgroup() async {
    try {
      final response = await dioConsumer.get(EndPoint.getallGroups);
      final List<Group> groups = (response as List)
          .map((e) => Group.fromJson(e))
          .toList();
      return Right(groups);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Group>> addgroup(String arName, String enName) async {
    try {
      final response = await dioConsumer.post(
        EndPoint.addGroups,
        data: {
          "arName": arName,
          "enName": enName,
        },
      );
      final json = response as Map<String, dynamic>;
      final model = Group.fromJson(json);

      return Right(model);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Group>> updategroup(int id, String arName, String enName) async {
    try {
      final response = await dioConsumer.put(
        EndPoint.updateGroups,
        data: {
          "id": id,
          "arName": arName,
          "enName": enName,
        },
      );

      if (response is Map<String, dynamic>) {
        final Group updatedGroup = Group.fromJson(response);
        return Right(updatedGroup);
      } else {
        return Left(ServerFailure('فشل في تعديل المجموعة: بيانات غير متوقعة'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deletegroup(int id) async {
    try {
      final response = await dioConsumer.delete(
        EndPoint.deleteGroup(id),
      );

      if (response.toString() == "Group Deleted Successfully") {
        return Right('تم حذف المجموعة بنجاح');
      } else {
        return Left(ServerFailure('فشل في حذف المجموعة: استجابة غير متوقعة'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

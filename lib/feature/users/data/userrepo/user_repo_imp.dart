import 'package:dartz/dartz.dart';
import 'package:lahj_center/core/utils/Failure/failure.dart';
import 'package:lahj_center/core/utils/api/dio_consumer.dart';
import 'package:lahj_center/core/utils/api/endpoint.dart';
import 'package:lahj_center/feature/users/data/model/user_model.dart';
import 'package:lahj_center/feature/users/data/userrepo/user_repo.dart';


class UserRepoImp implements UserRepo {
  final DioConsumer dioConsumer;

  UserRepoImp({required this.dioConsumer});

  @override
  Future<Either<Failure, List<User>>> getuser() async {
    try {
      final response = await dioConsumer.get(EndPoint.getallmembers);

      if (response is List) {
        final List<User> users = response
            .map((e) => User.fromJson(e as Map<String, dynamic>))
            .toList();

        return Right(users);
      } else {
        return Left(ServerFailure('فشل في جلب اليوزرز: نوع بيانات غير متوقع'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

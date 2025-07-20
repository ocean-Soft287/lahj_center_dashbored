import 'package:dartz/dartz.dart';
import 'package:lahj_center/core/utils/Failure/failure.dart';
import 'package:lahj_center/feature/users/data/model/user_model.dart';

abstract class UserRepo{
Future<Either<Failure,List<User>>>getuser();


}
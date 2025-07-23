import 'package:dartz/dartz.dart';

import 'package:lahj_center/core/utils/Failure/failure.dart';
import 'package:lahj_center/core/utils/api/dio_consumer.dart';

import 'package:lahj_center/feature/mange_orders/Data/model/data_of_category.dart';

import '../../../../core/utils/api/endpoint.dart';
import 'data_number_repo.dart';

class Datanumberrepoimp implements Datanumberrepo{
  final DioConsumer dioConsumer;

  Datanumberrepoimp({required this.dioConsumer});

  @override
  Future<Either<Failure, List<GroupDataNumbers>>> datagroupdatanumber() async{
    try {
      final response = await dioConsumer.get(EndPoint.getAdvertGroupsTotal);
      final List<GroupDataNumbers> groups = (response as List)
          .map((e) => GroupDataNumbers.fromJson(e))
          .toList();
      return Right(groups);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
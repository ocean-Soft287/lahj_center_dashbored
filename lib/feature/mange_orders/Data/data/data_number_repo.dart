import 'package:dartz/dartz.dart';
import 'package:lahj_center/core/utils/Failure/failure.dart';

import '../../../mange_orders/Data/model/data_of_category.dart';

abstract class Datanumberrepo{

  Future<Either<Failure, List<GroupDataNumbers>>>datagroupdatanumber();
}
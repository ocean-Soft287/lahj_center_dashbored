import 'package:dartz/dartz.dart';

import '../../../../core/utils/Failure/failure.dart';
import '../report_model/comment_report.dart';

abstract class Reportrepo{
  Future<Either<Failure,List<CommentReport>>>getreportcomment();


}
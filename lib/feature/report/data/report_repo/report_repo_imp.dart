import 'package:dartz/dartz.dart';
import 'package:lahj_center/core/utils/Failure/failure.dart';
import 'package:lahj_center/core/utils/api/dio_consumer.dart';
import 'package:lahj_center/core/utils/api/endpoint.dart';
import 'package:lahj_center/feature/report/data/report_model/comment_report.dart';
import 'package:lahj_center/feature/report/data/report_repo/report_repo.dart';

class Reportrepoimp implements Reportrepo {
  final DioConsumer dioConsumer;

  Reportrepoimp({required this.dioConsumer});

  @override
  Future<Either<Failure, List<CommentReport>>> getreportcomment() async {
    try {
      final response = await dioConsumer.get(EndPoint.getAllCommentReports);
      if (response is List) {
        final List<CommentReport> comment = response
            .map((e) => CommentReport.fromJson(e as Map<String, dynamic>))
            .toList();

        return Right(comment);
      } else {
        return Left(ServerFailure('فشل في جلب التعليقات: نوع بيانات غير متوقع'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
//
}

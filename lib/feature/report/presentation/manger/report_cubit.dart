import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:lahj_center/feature/report/data/report_repo/report_repo.dart';

import '../../../../core/utils/Failure/failure.dart';
import '../../data/report_model/comment_report.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit(this.reportRepo) : super(ReportInitial());

  final Reportrepo reportRepo;

  List<CommentReport> comments = [];

  Future<void> getReportComment() async {

    final Either<Failure, List<CommentReport>> response =
    await reportRepo.getreportcomment();

    response.fold(
          (failure) => emit(ReportError(_mapFailureToMessage(failure))),
          (data) {
        comments = data;
        emit(ReportLoaded(comments));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    }
    return 'حدث خطأ غير متوقع';
  }




}

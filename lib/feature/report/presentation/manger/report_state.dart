part of 'report_cubit.dart';

@immutable
abstract class ReportState {}

class ReportInitial extends ReportState {}


class ReportLoaded extends ReportState {
  final List<CommentReport> comments;

  ReportLoaded(this.comments);
}

class ReportError extends ReportState {
  final String message;

  ReportError(this.message);
}

import 'package:flutter/cupertino.dart';
import 'package:lahj_center/feature/report/presentation/screen/view_report/widget/report_code.dart';

import '../../../../data/report_model/comment_report.dart';

class MobileReportList extends StatelessWidget {
  final List<CommentReport> reports;

  const MobileReportList({super.key, required this.reports});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: reports.length,
      itemBuilder: (context, index) =>
          ReportCard(report: reports[index]),
      separatorBuilder: (_, __) => const SizedBox(height: 20),
    );
  }
}

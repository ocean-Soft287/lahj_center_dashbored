import 'package:flutter/cupertino.dart';
import 'package:lahj_center/feature/report/presentation/screen/view_report/widget/report_code.dart';

import '../../../../data/report_model/comment_report.dart';

class DesktopReportGrid extends StatelessWidget {
  final List<CommentReport> reports;

  const DesktopReportGrid({super.key, required this.reports});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 3,
      ),
      itemCount: reports.length,
      itemBuilder: (context, index) =>
          ReportCard(report: reports[index]),
    );
  }
}

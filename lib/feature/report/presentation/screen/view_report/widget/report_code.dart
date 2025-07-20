import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lahj_center/feature/report/presentation/screen/view_report/widget/report_actions.dart';
import 'package:lahj_center/feature/report/presentation/screen/view_report/widget/report_header.dart';

import '../../../../../../core/utils/colors/colors.dart';
import '../../../../../../core/utils/font/fonts.dart';
import '../../../../data/report_model/comment_report.dart';

class ReportCard extends StatelessWidget {
  final CommentReport report;

  const ReportCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final buttonWidth = width < 600 ? width * 0.20 : width * 0.10;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Appcolors.kwhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReportHeader(report: report),
          const SizedBox(height: 8),
          Text(
            "التعليق: ${report.comment}",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontFamily: Fonts.cairo, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Text(
            "السبب: ${report.reason}",
            style: const TextStyle(
              color: Colors.red,
              fontFamily: Fonts.cairo,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          ReportActions(buttonWidth: buttonWidth),
        ],
      ),
    );
  }
}

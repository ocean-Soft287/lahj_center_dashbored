import 'dart:ui';

import 'package:flutter/material.dart' ;

import '../../../../../../core/utils/font/fonts.dart';
import '../../../../data/report_model/comment_report.dart';

class ReportHeader extends StatelessWidget {
  final CommentReport report;

  const ReportHeader({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "المستخدم: ${report.commenterMemberName}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: Fonts.cairo,
          ),
        ),
        Text(
          "الحالة: ${report.status}",
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontFamily: Fonts.cairo,
          ),
        ),
      ],
    );
  }
}

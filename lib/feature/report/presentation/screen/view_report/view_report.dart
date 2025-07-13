import 'package:flutter/material.dart';
import 'package:lahj_center/core/utils/colors/colors.dart';
import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/utils/font/fonts.dart';

class ViewReportScreen extends StatelessWidget {
  ViewReportScreen({super.key});

  // Sample data for reported comments
  final List<ReportedComment> reports = List.generate(
    10,
    (index) => ReportedComment(
      userId: "مستخدم $index",
      comment: "هذا تعليق تم الإبلاغ عنه رقم $index",
      reason: index % 2 == 0 ? "إساءة" : "محتوى غير لائق",
      date:
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            // Mobile layout
            return _buildMobileView();
          } else {
            // Desktop layout
            return _buildDesktopView();
          }
        },
      ),
    );
  }

  Widget _buildMobileView() {
    return ListView.separated(
      itemCount: reports.length,
      itemBuilder: (context, index) {
        final report = reports[index];
        return _buildReportCard(report, context);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 30);
      },
    );
  }

  Widget _buildDesktopView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 3,
      ),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        final report = reports[index];
        return _buildReportCard(report, context);
      },
    );
  }

  Widget _buildReportCard(ReportedComment report, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Appcolors.kwhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "المستخدم: ${report.userId}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: Fonts.cairo,
                ),
              ),
              Text(
                "التاريخ: ${report.date}",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontFamily: Fonts.cairo,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "التعليق: ${report.comment}",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontFamily: Fonts.cairo, color: Colors.black87),
          ),
          SizedBox(height: 8),
          Text(
            "السبب: ${report.reason}",
            style: TextStyle(
              color: Colors.red,
              fontFamily: Fonts.cairo,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                name: "حذف",
                onTap: () {
                  _showDeleteDialog(context);
                },
                width:
                MediaQuery.of(context).size.width < 600
                    ? 0.20 * MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width * 0.10,
              ),
              SizedBox(width: 10),
              CustomButton(
                name: "قبول",
                onTap: () {
                  _showApproveDialog(context);
                },
                width:
                MediaQuery.of(context).size.width < 600
                    ? 0.20 * MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width * 0.10,
              ),
              SizedBox(width: 10),

              CustomButton(
                name: "حظر المستخدم",
                onTap: () {
                  _showApproveDialog(context);
                },
                width:
                MediaQuery.of(context).size.width < 600
                    ? 0.20 * MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width * 0.10,
              ),

            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              "تأكيد الحذف",
              style: TextStyle(fontFamily: Fonts.cairo),
            ),
            content: Text(
              "هل أنت متأكد من حذف هذا التقرير؟",
              style: TextStyle(fontFamily: Fonts.cairo),
            ),
            actions: [
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: Text("إلغاء", style: TextStyle(fontFamily: Fonts.cairo)),
              ),
              TextButton(
                onPressed: () {
                  // Add delete logic here
                  Navigator.of(context).pop();
                },
                child: Text("حذف", style: TextStyle(fontFamily: Fonts.cairo)),
              ),
            ],
          ),
    );
  }

  void _showApproveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              "تأكيد القبول",
              style: TextStyle(fontFamily: Fonts.cairo),
            ),
            content: Text(
              "هل تريد قبول هذا التقرير واتخاذ إجراء؟",
              style: TextStyle(fontFamily: Fonts.cairo),
            ),
            actions: [
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: Text("إلغاء", style: TextStyle(fontFamily: Fonts.cairo)),
              ),
              TextButton(
                onPressed: () {
                  // Add approve logic here
                  Navigator.of(context).pop();
                },
                child: Text("نعم", style: TextStyle(fontFamily: Fonts.cairo)),
              ),
            ],
          ),
    );
  }
}

// Model class for reported comment
class ReportedComment {
  final String userId;
  final String comment;
  final String reason;
  final String date;

  ReportedComment({
    required this.userId,
    required this.comment,
    required this.reason,
    required this.date,
  });
}

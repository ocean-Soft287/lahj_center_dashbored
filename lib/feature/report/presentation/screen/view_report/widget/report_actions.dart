import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/const/widget/custom_button.dart';
import '../../../../../../core/utils/font/fonts.dart';

class ReportActions extends StatelessWidget {
  final double buttonWidth;

  const ReportActions({super.key, required this.buttonWidth});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomButton(
          name: "حذف",
          onTap: () => _showConfirmationDialog(
            context,
            title: "تأكيد الحذف",
            content: "هل أنت متأكد من حذف هذا التقرير؟",
            confirmText: "حذف",
          ),
          width: buttonWidth,
        ),
        const SizedBox(width: 10),
        CustomButton(
          name: "قبول",
          onTap: () => _showConfirmationDialog(
            context,
            title: "تأكيد القبول",
            content: "هل تريد قبول هذا التقرير؟",
            confirmText: "نعم",
          ),
          width: buttonWidth,
        ),
        const SizedBox(width: 10),
        CustomButton(
          name: "حظر المستخدم",
          onTap: () => _showConfirmationDialog(
            context,
            title: "تأكيد الحظر",
            content: "هل تريد حظر هذا المستخدم؟",
            confirmText: "نعم",
          ),
          width: buttonWidth,
        ),
      ],
    );
  }

  void _showConfirmationDialog(
      BuildContext context, {
        required String title,
        required String content,
        required String confirmText,
      }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: const TextStyle(fontFamily: Fonts.cairo)),
        content: Text(content, style: const TextStyle(fontFamily: Fonts.cairo)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("إلغاء",
                style: TextStyle(fontFamily: Fonts.cairo)),
          ),
          TextButton(
            onPressed: () {
              // TODO: Add your logic here
              Navigator.of(context).pop();
            },
            child: Text(confirmText,
                style: const TextStyle(fontFamily: Fonts.cairo)),
          ),
        ],
      ),
    );
  }
}

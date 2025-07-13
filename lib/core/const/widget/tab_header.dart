// ===== Table Header Widget =====
import 'package:flutter/cupertino.dart';
import 'package:lahj_center/core/utils/font/fonts.dart';

class TableHeader extends StatelessWidget {
  final String text;
 final int? flex;
  const TableHeader({super.key, required this.text, this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex??1,
      child: Center(
        child: Text(
          text,
          style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 13,fontFamily: Fonts.cairo),
        ),
      ),
    );
  }
}
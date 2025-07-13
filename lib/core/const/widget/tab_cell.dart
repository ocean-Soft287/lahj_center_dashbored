// ===== Table Cell Widget =====
import 'package:flutter/cupertino.dart';

class TableCell extends StatelessWidget {
  final Widget child;
  const TableCell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Center(child: child));
  }
}
import 'package:flutter/cupertino.dart';

import 'filter_box.dart';

class StatusFiltersRow extends StatelessWidget {
  const StatusFiltersRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: double.infinity),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // ← تم التعديل هنا
        children: [
          FilterBox(text: 'جديد'),
          FilterBox(text: 'محذوف'),
          FilterBox(text: 'مقبول', isSelected: true),
          FilterBox(text: 'مرفوض'),
        ],
      ),
    );
  }
}

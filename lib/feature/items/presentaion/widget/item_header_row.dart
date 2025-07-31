import 'package:flutter/cupertino.dart';

import '../../../../core/const/widget/tab_header.dart';

class ItemHeaderRow extends StatelessWidget {
  const ItemHeaderRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: const Color(0xffF9FAFB),
      child: const Row(
        children: [
          TableHeader(text: 'السعر'),
          TableHeader(text: 'الوصف'),
          TableHeader(text: 'الصنف'),
          TableHeader(text: 'الصورة'),
          // TableHeader(text: 'رقم الجوال'),
          TableHeader(text: 'الحالة'),
          TableHeader(text: ''),
        ],
      ),
    );
  }
}

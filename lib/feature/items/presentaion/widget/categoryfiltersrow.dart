import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryFiltersRow extends StatelessWidget {
  const CategoryFiltersRow({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'الكل',
      'السيارات',
      'دراجات',
      'العقارات',
      'جوال-تابلت',
      'الاجهزة',
    ];

    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.start, // ← تم التعديل هنا
        spacing: 16,
        children: List.generate(categories.length, (index) {
          return Text(
            categories[index],
            style: TextStyle(
              fontSize: 14,
              color: index == 0 ? Colors.green : Colors.grey,
              fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
            ),
          );
        }),
      ),
    );
  }
}


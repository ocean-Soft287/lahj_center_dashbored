import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/const/widget/textformcrud.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/utils/font/fonts.dart';
import '../screen/add_currency.dart';

class Addcategoryphone extends StatelessWidget {
  const Addcategoryphone({super.key, required this.category, required this.categoryenglish});
  final TextEditingController category;
  final TextEditingController categoryenglish;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ====== العنوان الرئيسي ======
            Text(
              "إضافة فئه",
              style: TextStyle(
                fontFamily: Fonts.cairo,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Appcolors.kblue,
              ),
            ),
            const SizedBox(height: 20),

            // ====== الصندوق الأبيض ======
            Container(
              height: MediaQuery.of(context).size.height*.80,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Appcolors.kwhite,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ====== الحقول ======
                    Textformcrud(
                      controller: currency,
                      name: 'اسم الفئه بالعربي *',
                      nameinfo: 'أدخل اسم الفئه بالعربي',
                    ),
                    const SizedBox(height: 12),
                    Textformcrud(
                      controller: currencyenglish,
                      name: 'اسم الفئه بالإنجليزية *',
                      nameinfo: 'أدخل اسم الفئه بالإنجليزية',
                    ),
                    const SizedBox(height: 20),

                    // ====== الأزرار ======
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: CustomButton(name: 'إضافة', onTap: () {})),
                        const SizedBox(width: 16),
                        Expanded(child: CustomButton(name: 'إلغاء', onTap: () {})),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

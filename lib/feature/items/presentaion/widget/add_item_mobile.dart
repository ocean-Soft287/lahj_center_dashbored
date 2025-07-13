import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/const/widget/custom_button.dart';
import '../../../../core/const/widget/dropdownformcrud.dart';
import '../../../../core/const/widget/textformcrud.dart';
import '../../../../core/utils/colors/colors.dart';
import '../../../../core/utils/font/fonts.dart';

class Additemmobileview extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController price;
  final TextEditingController currency;
  final TextEditingController description;

  const Additemmobileview({
    super.key,
    required this.name,
    required this.phone,
    required this.price,
    required this.currency,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 0.999 * MediaQuery.of(context).size.height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "إضافة إعلان",
                          style: TextStyle(
                            color: Appcolors.kblue,
                            fontFamily: Fonts.cairo,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "إضافة معلومات تفصيلية للعناصر",
                          style: TextStyle(
                            color: Appcolors.kblue,
                            fontFamily: Fonts.cairo,
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                  color: Appcolors.kwhite,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(0, 4),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "إضافة إعلان",
                      style: TextStyle(
                        color: Appcolors.kblue,
                        fontFamily: Fonts.cairo,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Textformcrud(controller: name, name: 'اسم الإعلان', nameinfo: 'أدخل اسم الإعلان'),
                    SizedBox(height: 10),
                    Textformcrud(controller: phone, name: 'رقم الهاتف', nameinfo: 'أدخل رقم الهاتف'),
                    SizedBox(height: 10),
                    Textformcrud(controller: price, name: 'السعر', nameinfo: 'أدخل السعر'),
                    SizedBox(height: 10),
                    DropdownFormCrud(name: 'القسم الرئيسي', hint: 'اختر من القائمة', items: ['إلكترونيات', 'أثاث', 'سيارات']),
                    SizedBox(height: 10),
                    DropdownFormCrud(name: 'المحافظة', hint: 'اختر المحافظة', items: ['الرياض', 'جدة', 'الدمام']),
                    SizedBox(height: 10),
                    DropdownFormCrud(name: 'الحالة', hint: 'اختر الحالة', items: ['جديد', 'مستعمل']),
                    SizedBox(height: 10),
                    Textformcrud(controller: description, name: 'وصف الإعلان', nameinfo: 'أدخل وصف الإعلان'),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(flex: 3, child: CustomButton(name: 'إرسال', onTap: () {})),
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(flex: 3, child: CustomButton(name: 'إلغاء', onTap: () {})),
                        Expanded(flex: 1, child: SizedBox()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/const/widget/custom_button.dart';
import '../../../../core/const/widget/dropdownformcrud.dart';
import '../../../../core/const/widget/textformcrud.dart';
import '../../../../core/utils/colors/colors.dart';
import '../../../../core/utils/font/fonts.dart';

class Additem_DesktopView extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController price;
  final TextEditingController currency;
  final TextEditingController description;

  const Additem_DesktopView({super.key, required this.name, required this.phone, required this.price, required this.currency, required this.description});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 1.12 * MediaQuery.of(context).size.height),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
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
              SizedBox(height: 30),

              Container(
                padding: EdgeInsets.all(15.0),
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
                  mainAxisAlignment: MainAxisAlignment.start,
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

                    Row(
                      children: [
                        Expanded(child: Textformcrud(controller: name, name: 'اسم الإعلان', nameinfo: 'أدخل اسم الإعلان')),
                        SizedBox(width: 10),
                        Expanded(child: Textformcrud(controller: phone, name: 'رقم الهاتف', nameinfo: 'أدخل رقم الهاتف')),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: Textformcrud(controller: price, name: 'السعر', nameinfo: 'أدخل السعر')),
                        SizedBox(width: 10),
                        Expanded(child: DropdownFormCrud(name: 'العمله', hint: 'اختر العمله', items: ['جنيه', 'ريال', 'دولار'])),
                      ],
                    ),
                    SizedBox(height: 10),
                    DropdownFormCrud(name: 'القسم الرئيسي', hint: 'اختر من القائمة', items: ['إلكترونيات', 'أثاث', 'سيارات']),
                    SizedBox(height: 10),
                    DropdownFormCrud(name: 'المحافظة', hint: 'اختر المحافظة', items: ['الرياض', 'جدة', 'الدمام']),
                    SizedBox(height: 30),
                    DropdownFormCrud(name: 'الحالة', hint: 'اختر الحالة', items: ['جديد', 'مستعمل']),
                    SizedBox(height: 30),
                    Textformcrud(controller: description, name: 'وصف الإعلان', nameinfo: 'أدخل وصف الإعلان'),
                    SizedBox(height: 30),
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
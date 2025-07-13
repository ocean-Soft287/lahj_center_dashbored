import 'package:flutter/cupertino.dart';

import '../../../../core/const/widget/custom_text_field.dart';
import '../../../../core/const/widget/dropdownformcrud.dart';
import '../../../../core/utils/colors/colors.dart';
import '../screen/edit_item.dart';
import 'image_list.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/const/widget/textformcrud.dart';
import '../../../../core/const/widget/dropdownformcrud.dart';
import '../../../../core/utils/colors/colors.dart';
import '../screen/edit_item.dart';
import 'image_list.dart';

class EditItemWideLayouttablet extends StatelessWidget {
  final String itemName;
  final String category;
  final String code;
  final String quantity;
  final String imageUrl;

  EditItemWideLayouttablet({
    super.key,
    required this.itemName,
    required this.category,
    required this.code,
    required this.quantity,
    required this.imageUrl,
  });

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = itemName;
    phoneController.text = code;
    priceController.text = '';
    descriptionController.text = '';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * .25,
              minHeight: MediaQuery.of(context).size.height * .30,
            ),
            decoration: BoxDecoration(
              color: Appcolors.kwhite,
              border: Border.all(color: const Color(0xffA2A1A8)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const ImageList(isWide: true),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 4,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * .6,
              minHeight: MediaQuery.of(context).size.height * .30,
            ),
            decoration: BoxDecoration(
              color: Appcolors.kwhite,
              border: Border.all(color: const Color(0xffA2A1A8)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Textformcrud(
                    controller: nameController,
                    name: 'اسم الإعلان',
                    nameinfo: 'أدخل اسم الإعلان',
                  ),
                  const SizedBox(height: 10),
                  Textformcrud(
                    controller: phoneController,
                    name: 'رقم الهاتف',
                    nameinfo: 'أدخل رقم الهاتف',
                  ),
                  const SizedBox(height: 10),
                  Textformcrud(
                    controller: priceController,
                    name: 'السعر',
                    nameinfo: 'أدخل السعر',
                  ),
                  const SizedBox(height: 10),
                  DropdownFormCrud(
                    name: 'القسم الرئيسي',
                    hint: 'اختر من القائمة',
                    items: ['إلكترونيات', 'أثاث', 'سيارات'],
                  ),
                  const SizedBox(height: 10),
                  DropdownFormCrud(
                    name: 'المحافظة',
                    hint: 'اختر المحافظة',
                    items: ['الرياض', 'جدة', 'الدمام'],
                  ),
                  const SizedBox(height: 10),
                  DropdownFormCrud(
                    name: 'الحالة',
                    hint: 'اختر الحالة',
                    items: ['جديد', 'مستعمل'],
                  ),
                  const SizedBox(height: 10),
                  Textformcrud(
                    controller: descriptionController,
                    name: 'وصف الإعلان',
                    nameinfo: 'أدخل وصف الإعلان',
                  ),
                  const SizedBox(height: 20),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: const ActionButtons(isWide: false)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

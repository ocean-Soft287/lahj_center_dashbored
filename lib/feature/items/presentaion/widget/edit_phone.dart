import 'package:flutter/cupertino.dart';
import '../../../../core/const/widget/dropdownformcrud.dart';
import '../../../../core/utils/colors/colors.dart';
import '../screen/edit_item.dart';
import 'image_list.dart';

import '../../../../core/const/widget/textformcrud.dart';

class EditItemNarrowLayout extends StatelessWidget {
  final String itemName;
  final String category;
  final String code;
  final String quantity;
  final String imageUrl;

  const EditItemNarrowLayout({
    super.key,
    required this.itemName,
    required this.category,
    required this.code,
    required this.quantity,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: itemName);
    final TextEditingController phoneController = TextEditingController(text: code);
    final TextEditingController priceController = TextEditingController();
    final TextEditingController quantityController = TextEditingController(text: quantity);
    final TextEditingController descriptionController = TextEditingController();

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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
                const SizedBox(width: 20),
                Expanded(
                  flex: 3,
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
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: ListView(
                        children: [
                          Textformcrud(
                            controller: nameController,
                            name: "اسم الإعلان",
                            nameinfo: "أدخل اسم الإعلان",
                          ),
                          const SizedBox(height: 10),
                          Textformcrud(
                            controller: phoneController,
                            name: "رقم الهاتف",
                            nameinfo: "أدخل رقم الهاتف",
                          ),
                          const SizedBox(height: 10),
                          Textformcrud(
                            controller: priceController,
                            name: "السعر",
                            nameinfo: "أدخل السعر",
                          ),
                          const SizedBox(height: 10),
                          DropdownFormCrud(
                            name: "القسم الرئيسي",
                            hint: "اختر من القائمة",
                            items: const ["إلكترونيات", "أثاث", "سيارات"],
                          ),
                          const SizedBox(height: 10),
                          DropdownFormCrud(
                            name: "المحافظة",
                            hint: "اختر المحافظة",
                            items: const ["الرياض", "جدة", "الدمام"],
                          ),
                          const SizedBox(height: 10),
                          DropdownFormCrud(
                            name: "الحالة",
                            hint: "اختر الحالة",
                            items: const ["جديد", "مستعمل"],
                          ),
                          const SizedBox(height: 10),
                          Textformcrud(
                            controller: descriptionController,
                            name: "وصف الإعلان",
                            nameinfo: "أدخل وصف الإعلان",
                          ),
                          const SizedBox(height: 10),
                          ImagePickerField(imageUrl: imageUrl),

                          const SizedBox(height: 10),
                          const ActionButtons(isWide: false),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

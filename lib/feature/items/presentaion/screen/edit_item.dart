import 'package:flutter/material.dart';
import '../widget/edit_item_tablet.dart';
import '../widget/edit_phone.dart';

class EditItem extends StatelessWidget {
  const EditItem({super.key});

  final String itemName = "تيشيرت رجالي";
  final String category = "أ";
  final String code = "TSH123";
  final String quantity = "50";
  final String imageUrl =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdTaY5LvNFr-1pvAvWJ0ZSThKM87WYqM86Kw&s";

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:
            isWide
                ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: EditItemWideLayouttablet(
                    itemName: itemName,
                    category: category,
                    code: code,
                    quantity: quantity,
                    imageUrl: imageUrl,
                  ),
                )
                : EditItemNarrowLayout(
                  itemName: itemName,
                  category: category,
                  code: code,
                  quantity: quantity,
                  imageUrl: imageUrl,
                ),
      )
    );
  }
}



class ImagePickerField extends StatelessWidget {
  final String imageUrl;

  const ImagePickerField({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "الصور",
        prefixIcon: const Icon(Icons.attach_file),
        suffixIcon: Image.network(imageUrl, width: 24),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}


class ActionButtons extends StatelessWidget {
  final bool isWide;

  const ActionButtons({super.key, required this.isWide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isWide ? 40 : 12, vertical: 20),
      child: Row(
        mainAxisAlignment:
            isWide ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            ),
            child: const Text("تحديث"),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF5E35B1)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              foregroundColor: const Color(0xFF5E35B1),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            ),
            child: const Text("الغاء"),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import '../widget/addcategoryphone.dart';
TextEditingController categoryarabic=TextEditingController();
TextEditingController categoryEnglish=TextEditingController();
class Addcategory extends StatelessWidget {
  const Addcategory({super.key});

  @override

  Widget build(BuildContext context) {
    return Addcategoryphone(  category: categoryarabic, categoryenglish: categoryEnglish,);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/presentation/manger/group_cubit/group_cubit.dart';
import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/const/widget/textformcrud.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/utils/font/fonts.dart';
import '../../../../barnavigation/cubitbar/bar_cubit.dart';

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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  "إضافة فئه",
                  style: TextStyle(
                    fontFamily: Fonts.cairo,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Appcolors.kblue,
                  ),
                ),

                BlocBuilder<BarCubit, BarState>(
                  builder: (context, state) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: TextButton.icon(
                        onPressed: () {
                          context.read<BarCubit>().changeitems(1);

                        },
                        icon: const Icon(Icons.list),
                        label: const Text("عرض الفئات",     style: TextStyle(
                          fontFamily: Fonts.cairo,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Appcolors.kblue,
                        ),),
                      ),
                    );
                  },
                ),

              ],
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
                      controller: category,
                      name: 'اسم الفئه بالعربي *',
                      nameinfo: 'أدخل اسم الفئه بالعربي',
                    ),
                    const SizedBox(height: 12),
                    Textformcrud(
                      controller: categoryenglish,
                      name: 'اسم الفئه بالإنجليزية *',
                      nameinfo: 'أدخل اسم الفئه بالإنجليزية',
                    ),
                    const SizedBox(height: 20),

                    // ====== الأزرار ======
                    BlocConsumer<GroupCubit, GroupState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {

    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: CustomButton(name: 'إضافة', onTap: () {
                          context.read<GroupCubit>().addGroup(category.text, categoryenglish.text);

                        })),
                        const SizedBox(width: 16),
                        Expanded(child: CustomButton(name: 'إلغاء', onTap: () {})),
                      ],
                    );
  },
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
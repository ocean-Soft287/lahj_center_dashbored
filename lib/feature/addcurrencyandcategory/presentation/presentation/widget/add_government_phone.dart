import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/const/widget/textformcrud.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/utils/font/fonts.dart';
import '../../../../barnavigation/cubitbar/bar_cubit.dart';
import '../../manger/currency_cubit/currency_cubit.dart';


class AddGovernmentPhone extends StatelessWidget {
  final TextEditingController government;
  final TextEditingController governmentenglish;

  const AddGovernmentPhone({
    super.key,
    required this.government,
    required this.governmentenglish,
  });

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
                  "إضافة محافظة",
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
                        label: const Text(
                          "عرض المحافظات",
                          style: TextStyle(
                            fontFamily: Fonts.cairo,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Appcolors.kblue,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ====== الصندوق الأبيض ======
            Container(
              height: MediaQuery.of(context).size.height * .80,
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
                      controller: government,
                      name: 'اسم المحافظة بالعربي *',
                      nameinfo: 'أدخل اسم المحافظة بالعربي',
                    ),
                    const SizedBox(height: 12),
                    Textformcrud(
                      controller: governmentenglish,
                      name: 'اسم المحافظة بالإنجليزية *',
                      nameinfo: 'أدخل اسم المحافظة بالإنجليزية',
                    ),
                    const SizedBox(height: 20),

                    // ====== الأزرار ======
                    BlocConsumer<CurrencyCubit, CurrencyState>(
                      listener: (context, state) {
                        // يمكنك إضافة إشعار نجاح/فشل هنا
                      },
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CustomButton(
                                name: 'إضافة',
                                onTap: () {
                                  context.read<CurrencyCubit>().addCurrency(
                                    government.text,
                                    governmentenglish.text,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CustomButton(
                                name: 'إلغاء',
                                onTap: () {
                                  government.clear();
                                  governmentenglish.clear();
                                },
                              ),
                            ),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/presentation/manger/currency_cubit/currency_cubit.dart';
import 'package:lahj_center/feature/barnavigation/cubitbar/bar_cubit.dart';
import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/const/widget/textformcrud.dart';
import '../../../../../core/utils/class_helper/validator_class.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/utils/font/fonts.dart';


class AddCurrencyPhone extends StatelessWidget {
  final TextEditingController currency;
  final TextEditingController currencyenglish;

  const AddCurrencyPhone({
    super.key,
    required this.currency,
    required this.currencyenglish,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>(); // ✅

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ====== العنوان ======
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "إضافة عملات",
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
                          "عرض العملات",
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
                child: Form( // ✅ الفورم
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ====== الحقول ======
                      Textformcrud(
                        controller: currency,
                        name: 'اسم العملة بالعربي *',
                        nameinfo: 'أدخل اسم العملة بالعربي',
                        validator: FormValidators.arabicOnly, // ✅
                      ),
                      const SizedBox(height: 12),
                      Textformcrud(
                        controller: currencyenglish,
                        name: 'اسم العملة بالإنجليزية *',
                        nameinfo: 'أدخل اسم العملة بالإنجليزية',
                        validator: FormValidators.englishOnly, // ✅
                      ),

                      const SizedBox(height: 20),

                      // ====== الأزرار ======
                      BlocConsumer<CurrencyCubit, CurrencyState>(
                        listener: (context, state) {
                          if (state is CurrencyAdded) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('تم إضافة العملة بنجاح'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CustomButton(
                                  name: 'إضافة',
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      context.read<CurrencyCubit>().addCurrency(
                                        currency.text.trim(),
                                        currencyenglish.text.trim(),
                                      );
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: CustomButton(
                                  name: 'إلغاء',
                                  onTap: () {
                                    currency.clear();
                                    currencyenglish.clear();
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
            ),
          ],
        ),
      ),
    );
  }
}

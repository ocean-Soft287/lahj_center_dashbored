import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/presentation/manger/services_cubit/services_cubit.dart';
import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/const/widget/textformcrud.dart';
import '../../../../../core/utils/class_helper/validator_class.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/utils/font/fonts.dart';
import '../../../../barnavigation/cubitbar/bar_cubit.dart';

class AddServicePhone extends StatelessWidget {
  final TextEditingController service;
  final TextEditingController serviceEnglish;

  const AddServicePhone({
    super.key,
    required this.service,
    required this.serviceEnglish,
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
                  "إضافة خدمة",
                  style: TextStyle(
                    fontFamily: Fonts.cairo,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Appcolors.kblue,
                  ),
                ),
                BlocBuilder<BarCubit, BarState>(
                  builder: (context, state) {
                    return TextButton.icon(
                      onPressed: () {
                        context.read<BarCubit>().changeitems(1);
                      },
                      icon: const Icon(Icons.list),
                      label: const Text(
                        "عرض الخدمات",
                        style: TextStyle(
                          fontFamily: Fonts.cairo,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Appcolors.kblue,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height * .80,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Appcolors.kwhite,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Textformcrud(
                      controller: service,
                      name: 'اسم الخدمة بالعربي *',
                      nameinfo: 'أدخل اسم الخدمة بالعربي',
                      validator: FormValidators.arabicOnly,

                    ),
                    const SizedBox(height: 12),
                    Textformcrud(
                      controller: serviceEnglish,
                      name: 'اسم الخدمة بالإنجليزية *',
                      nameinfo: 'أدخل اسم الخدمة بالإنجليزية',
                      validator: FormValidators.englishOnly,

                    ),
                    const SizedBox(height: 20),
                    BlocConsumer<ServicesCubit, ServicesState>(
                      listener: (context, state) {
                        if(state is ServiceAdded){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('تم إضافة الخدمه بنجاح'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }

                      },
                      builder: (context, state) {
                        return Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                name: 'إضافة',
                                onTap: () {
                                  context.read<ServicesCubit>().addService(
                                    service.text,
                                    serviceEnglish.text,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CustomButton(
                                name: 'إلغاء',
                                onTap: () {
                                  service.clear();
                                  serviceEnglish.clear();
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    )
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

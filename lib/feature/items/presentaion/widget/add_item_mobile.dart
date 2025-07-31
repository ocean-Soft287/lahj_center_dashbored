import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/const/widget/custom_button.dart';
import '../../../../core/const/widget/dropdownformcrud.dart';
import '../../../../core/const/widget/textformcrud.dart';
import '../../../../core/utils/colors/colors.dart';
import '../../../../core/utils/font/fonts.dart';
import '../../../addcurrencyandcategory/presentation/manger/currency_cubit/currency_cubit.dart';
import '../../../addcurrencyandcategory/presentation/manger/governmentcubit/government_cubit.dart';
import '../../../addcurrencyandcategory/presentation/manger/group_cubit/group_cubit.dart';
import '../../../addcurrencyandcategory/presentation/manger/services_cubit/services_cubit.dart';
import '../../../items/presentaion/manger/item_cubit.dart';

class Additemmobileview extends StatefulWidget {
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
  State<Additemmobileview> createState() => _AdditemmobileviewState();
}

class _AdditemmobileviewState extends State<Additemmobileview> {
  String? selectedCurrency;
  String? selectedGroup;
  String? selectedGovernment;
  String? selectedStatus;
  int? selectedCurrencyint;
  int? selectedGroupint;
  int? selectedGovernmentint;
  int? selectedStatusint;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GroupCubit>(
          create: (context) => GetIt.instance<GroupCubit>()..getGroups(),
        ),
        BlocProvider<ServicesCubit>(
          create: (context) => GetIt.instance<ServicesCubit>()..getServices(),
        ),
        BlocProvider<GovernmentCubit>(
          create:
              (context) => GetIt.instance<GovernmentCubit>()..getGovernments(),
        ),
        BlocProvider<CurrencyCubit>(
          create: (context) => GetIt.instance<CurrencyCubit>()..getCurrencies(),
        ),
        BlocProvider<ItemCubit>(
          create: (BuildContext context) => GetIt.instance<ItemCubit>(),
        ),
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 0.999 * MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                    color: Appcolors.kwhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 4),
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textformcrud(
                        controller: widget.name,
                        name: 'اسم الإعلان',
                        nameinfo: 'أدخل اسم الإعلان',
                      ),
                      const SizedBox(height: 10),
                      Textformcrud(
                        controller: widget.phone,
                        name: 'رقم الهاتف',
                        nameinfo: 'أدخل رقم الهاتف',
                      ),
                      const SizedBox(height: 10),
                      Textformcrud(
                        controller: widget.price,
                        name: 'السعر',
                        nameinfo: 'أدخل السعر',
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<GroupCubit, GroupState>(
                        builder: (context, state) {
                          if (state is GroupLoaded) {
                            return DropdownFormCrud(
                              name: 'القسم الرئيسي',
                              hint: 'اختر من القائمة',
                              items: state.groups.map((e) => e.arName).toList(),
                              value: selectedGroup,
                              onChanged: (val) {
                                setState(() {
                                  selectedGroup = val;
                                  final selected = state.groups.firstWhere(
                                    (e) => e.arName == val,
                                  );
                                  selectedGroupint = selected.id;
                                });
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      BlocBuilder<GovernmentCubit, GovernmentState>(
                        builder: (context, state) {
                          if (state is GovernmentLoaded) {
                            return DropdownFormCrud(
                              name: 'المحافظة',
                              hint: 'اختر المحافظة',
                              items:
                                  state.governments
                                      .map((e) => e.arName)
                                      .toList(),
                              value: selectedGovernment,
                              onChanged: (val) {
                                setState(() {
                                  selectedGovernment = val;
                                  final selected = state.governments.firstWhere(
                                    (e) => e.arName == val,
                                  );
                                  selectedGovernmentint = selected.id;
                                });
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<ServicesCubit, ServicesState>(
                        builder: (context, state) {
                          if (state is ServicesLoaded) {
                            return DropdownFormCrud(
                              name: 'الحالة',
                              hint: 'اختر الحالة',
                              items:
                                  state.services.map((e) => e.arName).toList(),
                              value: selectedStatus,
                              onChanged: (val) {
                                setState(() {
                                  selectedStatus = val;
                                  final selected = state.services.firstWhere(
                                    (e) => e.arName == val,
                                  );
                                  selectedStatusint = selected.id;
                                });
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<CurrencyCubit, CurrencyState>(
                        builder: (context, state) {
                          if (state is CurrencyLoaded) {
                            return DropdownFormCrud(
                              name: 'العملة',
                              hint: 'اختر العملة',
                              items:
                                  state.currencies
                                      .map((e) => e.arName)
                                      .toList(),
                              value: selectedCurrency,
                              onChanged: (val) {
                                setState(() {
                                  selectedCurrency = val;
                                  final selected = state.currencies.firstWhere(
                                    (e) => e.arName == val,
                                  );
                                  selectedCurrencyint = selected.id;
                                });
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      Textformcrud(
                        controller: widget.description,
                        name: 'وصف الإعلان',
                        nameinfo: 'أدخل وصف الإعلان',
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 3,
                            child: BlocConsumer<ItemCubit, ItemState>(
                              listener: (context, state) {
                                // إضافة أي feedback عند الإرسال
                              },
                              builder: (context, state) {
                                return CustomButton(
                                  name: 'إرسال',
                                  onTap: () {
                                    print(selectedGroupint);
                                    print(selectedCurrencyint);
                                    print(selectedGovernmentint);
                                    print(selectedStatusint);

                                    context
                                        .read<ItemCubit>()
                                        .addAdvertisement(
                                          name: widget.name.text,
                                          phone: widget.phone.text,
                                          groupId: selectedGroupint ?? 0,
                                          serviceId: selectedStatusint ?? 0,
                                          price:
                                              int.tryParse(widget.price.text) ??
                                              0,
                                          currency: selectedCurrencyint ?? 0,
                                          governorateId:
                                              selectedGovernmentint ?? 0,
                                          area: '',
                                          description: widget.description.text, X: [],
                                        );
                                  },
                                );
                              },
                            ),
                          ),
                          const Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 3,
                            child: CustomButton(name: 'إلغاء', onTap: () {}),
                          ),
                          const Expanded(flex: 1, child: SizedBox()),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
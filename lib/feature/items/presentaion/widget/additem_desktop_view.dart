import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lahj_center/feature/items/presentaion/manger/add_item_cubit.dart';
import '../../../../core/const/widget/custom_button.dart';
import '../../../../core/const/widget/dropdownformcrud.dart';
import '../../../../core/const/widget/textformcrud.dart';
import '../../../../core/utils/colors/colors.dart';
import '../../../addcurrencyandcategory/presentation/manger/currency_cubit/currency_cubit.dart';
import '../../../addcurrencyandcategory/presentation/manger/governmentcubit/government_cubit.dart';
import '../../../addcurrencyandcategory/presentation/manger/group_cubit/group_cubit.dart';
import '../../../addcurrencyandcategory/presentation/manger/services_cubit/services_cubit.dart';

class Additem_DesktopView extends StatefulWidget {
  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController price;
  final TextEditingController currency;
  final TextEditingController description;

  const Additem_DesktopView({
    super.key,
    required this.name,
    required this.phone,
    required this.price,
    required this.currency,
    required this.description,
  });

  @override
  State<Additem_DesktopView> createState() => _Additem_DesktopViewState();
}

class _Additem_DesktopViewState extends State<Additem_DesktopView> {
  String? selectedCurrency;
  String? selectedGroup;
  String? selectedGovernment;
  String? selectedStatus;
  int? selectedCurrencyint;
  int? selectedGovernmentint;
  int? selectedStatusint;
  int? selectedGroupint;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GroupCubit>(
          create:
              (BuildContext context) =>
          GetIt.instance<GroupCubit>()..getGroups(),
        ),
        BlocProvider<ServicesCubit>(
          create:
              (BuildContext context) =>
          GetIt.instance<ServicesCubit>()..getServices(),
        ),
        BlocProvider<GovernmentCubit>(
          create:
              (BuildContext context) =>
          GetIt.instance<GovernmentCubit>()..getGovernments(),
        ),
        BlocProvider<CurrencyCubit>(
          create:
              (BuildContext context) =>
          GetIt.instance<CurrencyCubit>()..getCurrencies(),
        ),
        BlocProvider<AddItemCubit>(
          create: (BuildContext context) => GetIt.instance<AddItemCubit>(),
        ),
      ],
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 1.12 * MediaQuery.of(context).size.height,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// header & intro
                const SizedBox(height: 30),

                /// main form
                Container(
                  padding: const EdgeInsets.all(15.0),
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
                      Row(
                        children: [
                          Expanded(
                            child: Textformcrud(
                              controller: widget.name,
                              name: 'اسم الإعلان',
                              nameinfo: 'أدخل اسم الإعلان',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Textformcrud(
                              controller: widget.phone,
                              name: 'رقم الهاتف',
                              nameinfo: 'أدخل رقم الهاتف',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Textformcrud(
                              controller: widget.price,
                              name: 'السعر',
                              nameinfo: 'أدخل السعر',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: BlocBuilder<CurrencyCubit, CurrencyState>(
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
                                        final selected = state.currencies
                                            .firstWhere((e) => e.arName == val);
                                        selectedCurrencyint = selected.id;
                                      });
                                    },
                                  );
                                } else {
                                  return SizedBox();
                                }
                              },
                            ),
                          ),
                        ],
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
                                  // احفظ الid بناءً على العنصر المختار
                                  final selected = state.groups.firstWhere(
                                        (e) => e.arName == val,
                                  );

                                  selectedGroupint = selected.id;
                                });
                              },
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                      const SizedBox(height: 10),
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
                            return SizedBox();
                          }
                        },
                      ),
                      const SizedBox(height: 30),
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
                            return SizedBox();
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      Textformcrud(
                        controller: widget.description,
                        name: 'وصف الإعلان',
                        nameinfo: 'أدخل وصف الإعلان',
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 3,
                            child: BlocConsumer<AddItemCubit, AddItemState>(
                              listener: (context, state) {
                                // TODO: implement listener
                              },
                              builder: (context, state) {
                                return CustomButton(
                                  name: 'إرسال',
                                  onTap: () {

                                    context.read<AddItemCubit>().addAdvertisement(
                                      name: widget.name.text,
                                      phone: widget.phone.text,
                                      groupId: selectedGroupint ?? 0,
                                      serviceId: selectedStatusint ?? 0,
                                      price: int.parse(widget.price.text),
                                      currency: selectedCurrencyint ?? 0,
                                      governorateId: selectedGovernmentint ?? 0,
                                      area: 'wqdadsdasdsadasdasd', // or another controller if you have area
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

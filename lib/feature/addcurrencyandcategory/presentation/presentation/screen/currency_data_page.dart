import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/data/model/currency.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/utils/font/fonts.dart';
import '../../manger/currency_cubit/currency_cubit.dart';


class CurrencyDataPage extends StatefulWidget {
  const CurrencyDataPage({super.key});

  @override
  State<CurrencyDataPage> createState() => _CurrencyDataPageState();
}

class _CurrencyDataPageState extends State<CurrencyDataPage> {
  late CurrencyCubit _currencyCubit;

  @override
  void initState() {
    super.initState();
    _currencyCubit = GetIt.instance<CurrencyCubit>();
    _currencyCubit.getCurrencies();
  }

  void _editCurrency(BuildContext context, Currency currency) {
    final TextEditingController arController = TextEditingController(text: currency.arName);
    final TextEditingController enController = TextEditingController(text: currency.enName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تعديل العملة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: arController,
              decoration: const InputDecoration(labelText: 'الاسم بالعربي'),
            ),
            TextField(
              controller: enController,
              decoration: const InputDecoration(labelText: 'الاسم بالإنجليزية'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              _currencyCubit.updateCurrency(
                currency.id,
                arController.text,
                enController.text,
              );
              Navigator.pop(context);
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, Currency currency) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: Text('هل تريد حذف "${currency.arName}"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              _currencyCubit.deleteCurrency(currency.id);
              Navigator.pop(context);
            },
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _currencyCubit,
      child: BlocConsumer<CurrencyCubit, CurrencyState>(
        listener: (context, state) {
          if (state is CurrencyDeleted || state is CurrencyUpdated) {
            _currencyCubit.getCurrencies();
          }
        },
        builder: (context, state) {
          final currencies = _currencyCubit.currencies;

          return Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Container(
                constraints: const BoxConstraints(minHeight: 100),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Appcolors.kwhite,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'العملات المضافة',
                      style: TextStyle(
                        fontFamily: Fonts.cairo,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Appcolors.kblue,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (state is CurrencyLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      ListView.separated(
                        itemCount: currencies.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final currency = currencies[index];
                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(8),
                              color: Appcolors.kwhite,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      currency.arName,
                                      style: TextStyle(
                                        fontFamily: Fonts.cairo,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Appcolors.kBlack,
                                      ),
                                    ),
                                    Text(
                                      currency.enName,
                                      style: TextStyle(
                                        fontFamily: Fonts.cairo,
                                        fontSize: 14,
                                        color: Appcolors.kgrey2,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton.icon(
                                      onPressed: () => _editCurrency(context, currency),
                                      icon: const Icon(Icons.edit, color: Colors.orange),
                                      label: const Text('تعديل', style: TextStyle(color: Colors.orange)),
                                    ),
                                    const SizedBox(width: 8),
                                    TextButton.icon(
                                      onPressed: () => _confirmDelete(context, currency),
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      label: const Text('حذف', style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

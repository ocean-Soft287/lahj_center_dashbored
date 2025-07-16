import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/data/model/government.dart'; // تأكد من وجود هذا الموديل

import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/utils/font/fonts.dart';
import '../../manger/governmentcubit/government_cubit.dart'; // تأكد من وجود هذا الكيوبت

class GovernmentDataPage extends StatefulWidget {
  const GovernmentDataPage({super.key});

  @override
  State<GovernmentDataPage> createState() => _GovernmentDataPageState();
}

class _GovernmentDataPageState extends State<GovernmentDataPage> {
  late GovernmentCubit _governmentCubit;

  @override
  void initState() {
    super.initState();
    _governmentCubit = GetIt.instance<GovernmentCubit>();
    _governmentCubit.getGovernments();
  }

  void _editGovernment(BuildContext context, Government government) {
    final TextEditingController arController = TextEditingController(text: government.arName);
    final TextEditingController enController = TextEditingController(text: government.enName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تعديل المحافظة'),
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
              _governmentCubit.updateGovernment(
                government.id,
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

  void _confirmDelete(BuildContext context, Government government) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: Text('هل تريد حذف "${government.arName}"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              _governmentCubit.deleteGovernment(government.id);
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
      value: _governmentCubit,
      child: BlocConsumer<GovernmentCubit, GovernmentState>(
        listener: (context, state) {
          if (state is GovernmentDeleted || state is GovernmentUpdated) {
            _governmentCubit.getGovernments();
          }
        },
        builder: (context, state) {
          final governments = _governmentCubit.governments;

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
                      'المحافظات المضافة',
                      style: TextStyle(
                        fontFamily: Fonts.cairo,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Appcolors.kblue,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (state is GovernmentLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      ListView.separated(
                        itemCount: governments.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final government = governments[index];
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
                                      government.arName,
                                      style: TextStyle(
                                        fontFamily: Fonts.cairo,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Appcolors.kBlack,
                                      ),
                                    ),
                                    Text(
                                      government.enName,
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
                                      onPressed: () => _editGovernment(context, government),
                                      icon: const Icon(Icons.edit, color: Colors.orange),
                                      label: const Text('تعديل', style: TextStyle(color: Colors.orange)),
                                    ),
                                    const SizedBox(width: 8),
                                    TextButton.icon(
                                      onPressed: () => _confirmDelete(context, government),
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

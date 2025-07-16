
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/presentation/manger/services_cubit/services_cubit.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/utils/font/fonts.dart';
import '../../../data/model/services.dart';

class ServiceDataPage extends StatefulWidget {
  const ServiceDataPage({super.key});

  @override
  State<ServiceDataPage> createState() => _ServiceDataPageState();
}

class _ServiceDataPageState extends State<ServiceDataPage> {
  late ServicesCubit _serviceCubit;

  @override
  void initState() {
    super.initState();
    _serviceCubit = GetIt.instance<ServicesCubit>();
    _serviceCubit.getServices();
  }

  void _editService(BuildContext context, Services service) {
    final TextEditingController arController = TextEditingController(text: service.arName);
    final TextEditingController enController = TextEditingController(text:service.enName );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تعديل الخدمة'),
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
              _serviceCubit.updateService(
                service.id,
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

  void _confirmDelete(BuildContext context, Services service) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: Text('هل تريد حذف "${service.arName}"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              _serviceCubit.deleteService(service.id);
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
      value: _serviceCubit,
      child: BlocConsumer<ServicesCubit, ServicesState>(
        listener: (context, state) {
          if (state is ServiceDeleted || state is ServiceUpdated) {
            _serviceCubit.getServices();
          }
        },
        builder: (context, state) {
          final services = _serviceCubit.services;

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
                      'الخدمات المضافة',
                      style: TextStyle(
                        fontFamily: Fonts.cairo,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Appcolors.kblue,
                      ),
                    ),
                    const SizedBox(height: 16),

                      ListView.separated(
                        itemCount: services.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final service = services[index];
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
                                      service.arName,
                                      style: TextStyle(
                                        fontFamily: Fonts.cairo,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Appcolors.kBlack,
                                      ),
                                    ),
                                    Text(
                                      service.enName,
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
                                      onPressed: () => _editService(context, service),
                                      icon: const Icon(Icons.edit, color: Colors.orange),
                                      label: const Text('تعديل', style: TextStyle(color: Colors.orange)),
                                    ),
                                    const SizedBox(width: 8),
                                    TextButton.icon(
                                      onPressed: () => _confirmDelete(context, service),
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

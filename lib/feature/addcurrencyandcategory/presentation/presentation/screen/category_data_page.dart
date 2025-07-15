import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/data/model/group.dart';
import 'package:lahj_center/feature/addcurrencyandcategory/presentation/manger/group_cubit/group_cubit.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/utils/font/fonts.dart';

class CategoryDataPage extends StatefulWidget {
  const CategoryDataPage({super.key});

  @override
  State<CategoryDataPage> createState() => _CategoryDataPageState();
}

class _CategoryDataPageState extends State<CategoryDataPage> {
  late GroupCubit _groupCubit;

  @override
  void initState() {
    super.initState();
    _groupCubit = GetIt.instance<GroupCubit>();
    _groupCubit.getGroups();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _groupCubit,
      child: BlocConsumer<GroupCubit, GroupState>(
        listener: (context, state) {
          if (state is GroupDeleted || state is GroupUpdated) {
            _groupCubit.getGroups();
          }
        },
        builder: (context, state) {
          final groups = _groupCubit.groups;

          return Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Container(
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
                      'الفئات المضافة',
                      style: TextStyle(
                        fontFamily: Fonts.cairo,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Appcolors.kblue,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (state is GroupLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      ListView.separated(
                        itemCount: groups.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final group = groups[index];
                          return GroupTile(
                            group: group,
                            onEdit: () => showGroupDialog(context, group, _groupCubit),
                            onDelete: () => showConfirmDeleteDialog(context, group, _groupCubit),
                          );
                        },
                      ),
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

class GroupTile extends StatelessWidget {
  final Group group;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const GroupTile({
    super.key,
    required this.group,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
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
                group.arName,
                style: TextStyle(
                  fontFamily: Fonts.cairo,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Appcolors.kBlack,
                ),
              ),
              Text(
                group.enName,
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
                onPressed: onEdit,
                icon: const Icon(Icons.edit, color: Colors.orange),
                label: const Text('تعديل', style: TextStyle(color: Colors.orange)),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: onDelete,
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text('حذف', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



void showGroupDialog(BuildContext context, Group group, GroupCubit groupCubit) {
  final TextEditingController arController = TextEditingController(text: group.arName);
  final TextEditingController enController = TextEditingController(text: group.enName);

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('تعديل الفئة'),
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
            groupCubit.updateGroup(group.id, arController.text, enController.text);
            Navigator.pop(context);
          },
          child: const Text('حفظ'),
        ),
      ],
    ),
  );
}

void showConfirmDeleteDialog(BuildContext context, Group group, GroupCubit groupCubit) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('تأكيد الحذف'),
      content: Text('هل تريد حذف "${group.arName}"؟'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        TextButton(
          onPressed: () {
            groupCubit.deleteGroup(group.id);
            Navigator.pop(context);
          },
          child: const Text('حذف', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}




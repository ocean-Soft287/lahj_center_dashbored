import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahj_center/core/utils/colors/colors.dart';
import '../../../../core/const/widget/action_button.dart';
import '../../../../core/const/widget/search.dart';
import '../../../../core/const/widget/tab_header.dart';
import '../../../barnavigation/cubitbar/bar_cubit.dart';

class Item {
  final String price;
  final String description;
  final String category;
  final String imageUrl;
  final String phoneNumber;
  final String status;

  Item({
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.phoneNumber,
    required this.status,
  });
}

final demoItems = List.generate(
  10,
      (index) => Item(
    price: '40\$',
    description: 'وصف العنصر ${index + 1}',
    category: 'G-78${index % 2 == 0 ? '85' : '88'}',
    imageUrl: 'https://www.militarykit.com/cdn/shop/products/sport-grey-cotton-tshirt.jpg?v=1591341911',
    phoneNumber: '012-3080408',
    status: 'جديد',
  ),
);

class ItemsResponsive extends StatefulWidget {
  const ItemsResponsive({super.key});

  @override
  State<ItemsResponsive> createState() => _ItemsResponsiveState();
}

class _ItemsResponsiveState extends State<ItemsResponsive> with WidgetsBindingObserver {
  late TextEditingController search;

  @override
  void initState() {
    super.initState();
    search = TextEditingController();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    search.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxWidth < 1200
            ? ItemMobile(search: search)
            : ItemTablet(search: search);
      },
    );
  }
}

class ItemMobile extends StatelessWidget {
  const ItemMobile({super.key, required this.search});
  final TextEditingController search;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: SearchTextformfield(controller: search),
                    ),
                    Expanded(child: SizedBox(),flex: 2,)
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatusFiltersRow(),
                    const SizedBox(height: 10),
                    CategoryFiltersRow(),
                  ],
                ),

                const SizedBox(height: 20),
                const ItemHeaderRow(),
              ],
            ),
          ),
        ),
        SliverList.separated(
          itemCount: demoItems.length,
          separatorBuilder: (_, __) =>
          const Divider(color: Color(0xffF1F2F4)),
          itemBuilder: (context, index) =>
              buildItemRow(demoItems[index], context, isTablet: false),
        ),
      ],
    );
  }
}

class ItemTablet extends StatelessWidget {
  const ItemTablet({super.key, required this.search});
  final TextEditingController search;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Appcolors.kwhite,
                border: Border.all(color: const Color(0xffA2A1A8)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: SearchTextformfield(controller: search),
                        ),
                        Expanded(child: SizedBox(),flex: 2,)

                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        StatusFiltersRow(),
                        const SizedBox(height: 10),
                        CategoryFiltersRow(),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const ItemHeaderRow(),
                    const SizedBox(height: 10),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: demoItems.length,
                      separatorBuilder: (_, __) =>
                      const Divider(color: Color(0xffF1F2F4)),
                      itemBuilder: (context, index) =>
                          buildItemRow(demoItems[index], context, isTablet: true),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// === Shared Header Widget ===
class ItemHeaderRow extends StatelessWidget {
  const ItemHeaderRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: const Color(0xffF9FAFB),
      child: const Row(
        children: [
          TableHeader(text: 'السعر'),
          TableHeader(text: 'الوصف'),
          TableHeader(text: 'الصنف'),
          TableHeader(text: 'الصورة'),
          TableHeader(text: 'رقم الجوال'),
          TableHeader(text: 'الحالة'),
          TableHeader(text: ''),
        ],
      ),
    );
  }
}

// === Shared Row Widget ===
Widget buildItemRow(Item item, BuildContext context, {required bool isTablet}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
    child: Row(
      children: [
        Expanded(child: Center(child: Text(item.price))),
        Expanded(child: Center(child: Text(item.description))),
        Expanded(child: Center(child: Text(item.category))),
        Expanded(
          child: Center(
            child: Image.network(item.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
          ),
        ),
        Expanded(child: Center(child: Text(item.phoneNumber))),
        Expanded(child: Center(child: Text(item.status))),
        Expanded(
          child: isTablet
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ActionBtn(label: 'قبول', color: Colors.yellow),
              BlocBuilder<BarCubit, BarState>(
                builder: (context, state) {
                  return ActionBtn(
                    label: 'تعديل',
                    color: Colors.red,
                    onTap: () => context.read<BarCubit>().changeitems(1),
                  );
                },
              ),
              ActionBtn(label: 'حذف', color: Colors.red),
            ],
          )
              : Center(
            child: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'تعديل') {
                  context.read<BarCubit>().changeitems(1);
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'قبول', child: Text('قبول')),
                PopupMenuItem(value: 'تعديل', child: Text('تعديل')),
                PopupMenuItem(value: 'حذف', child: Text('حذف')),
              ],
              icon: const Icon(Icons.more_vert),
            ),
          ),
        ),
      ],
    ),
  );
}












class StatusFiltersRow extends StatelessWidget {
  const StatusFiltersRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: double.infinity),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // ← تم التعديل هنا
        children: [
          FilterBox(text: 'جديد'),
          FilterBox(text: 'محذوف'),
          FilterBox(text: 'مقبول', isSelected: true),
          FilterBox(text: 'مرفوض'),
        ],
      ),
    );
  }
}


class FilterBox extends StatelessWidget {
  final String text;
  final bool isSelected;

  const FilterBox({super.key, required this.text, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


class CategoryFiltersRow extends StatelessWidget {
  const CategoryFiltersRow({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'الكل',
      'السيارات',
      'دراجات',
      'العقارات',
      'جوال-تابلت',
      'الاجهزة',
    ];

    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.start, // ← تم التعديل هنا
        spacing: 16,
        children: List.generate(categories.length, (index) {
          return Text(
            categories[index],
            style: TextStyle(
              fontSize: 14,
              color: index == 0 ? Colors.green : Colors.grey,
              fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
            ),
          );
        }),
      ),
    );
  }
}


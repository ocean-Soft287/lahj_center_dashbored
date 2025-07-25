import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lahj_center/core/utils/colors/colors.dart';
import '../../../../core/const/widget/action_button.dart';
import '../../../../core/const/widget/search.dart';
import '../../../../core/const/widget/tab_header.dart';
import '../../../barnavigation/cubitbar/bar_cubit.dart';
import '../widget/item_mobile.dart';
import '../widget/item_tablet.dart';

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






class buildItemRow extends StatelessWidget {
  final Item item;
  final bool isTablet;

  const buildItemRow({
    Key? key,
    required this.item,
    required this.isTablet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
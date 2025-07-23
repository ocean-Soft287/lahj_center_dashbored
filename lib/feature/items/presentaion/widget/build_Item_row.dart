import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/const/widget/action_button.dart';
import '../../../barnavigation/cubitbar/bar_cubit.dart';
import '../screen/items_responsive.dart';

class BuildItemRow extends StatelessWidget {
  final Item item;
  final bool isTablet;

  const BuildItemRow({
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
              child: Image.network(
                item.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
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

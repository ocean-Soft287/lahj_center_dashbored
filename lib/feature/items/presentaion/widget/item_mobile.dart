import 'package:flutter/material.dart';
import 'package:lahj_center/feature/items/presentaion/widget/statusfiltersrow.dart';
import '../../../../core/const/widget/search.dart';
import '../screen/items_responsive.dart';
import 'categoryfiltersrow.dart';
import 'item_header_row.dart';


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
                    Expanded(flex: 2,child: SizedBox(),)
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
              buildItemRow(  isTablet: false, item:demoItems[index],),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lahj_center/feature/items/presentaion/widget/statusfiltersrow.dart';

import '../../../../core/const/widget/search.dart';
import '../../../../core/utils/colors/colors.dart';
import '../screen/items_responsive.dart';
import 'categoryfiltersrow.dart';
import 'item_header_row.dart';

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
                        Expanded(flex: 2,child: SizedBox(),)

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
                          buildItemRow( item:demoItems[index], isTablet: true,),
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

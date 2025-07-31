import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/const/widget/search.dart';
import '../manger/item_cubit.dart';
import '../screen/items_responsive.dart';
import 'item_header_row.dart';

class ItemMobile extends StatelessWidget {
  const ItemMobile({super.key, required this.search});

  final TextEditingController search;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      GetIt.instance<ItemCubit>()
        ..getaddvertisminte(),
      child: CustomScrollView(
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
                      Expanded(flex: 2, child: SizedBox(),)
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     StatusFiltersRow(),
                  //     const SizedBox(height: 10),
                  //     CategoryFiltersRow(),
                  //   ],
                  // ),

                  const SizedBox(height: 20),
                  const ItemHeaderRow(),
                ],
              ),
            ),
          ),
          BlocBuilder<ItemCubit, ItemState>(
            builder: (context, state) {
              if(state is  Fetchitemssuccful)
                {
                  return SliverList.separated(
                    itemCount: state.alladvertisminte.length,
                    separatorBuilder: (_, __) =>
                        Divider(color: Color(0xffF1F2F4)),
                    itemBuilder: (context, index) =>
                        BuildItemRow(isTablet: false, item:state.alladvertisminte[index]

                        ),
                  );

                }
              else {
                return SliverToBoxAdapter(
                  child: SizedBox(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart' show launchUrl, LaunchMode, canLaunchUrl;
import '../../../../core/const/widget/action_button.dart';
import '../../../../core/const/widget/search.dart';
import '../../../../core/utils/colors/colors.dart';
import '../manger/item_cubit.dart';
import '../../data/model/advertisminte.dart';
import 'item_header_row.dart';

class ItemTablet extends StatelessWidget {
  const ItemTablet({super.key, required this.search});

  final TextEditingController search;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<ItemCubit>()..getaddvertisminte(),
      child: CustomScrollView(
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
                          const Expanded(flex: 2, child: SizedBox()),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      const ItemHeaderRow(),

                      BlocConsumer<ItemCubit, ItemState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is Fetchitemssuccful) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.alladvertisminte.length,
                              itemBuilder: (context, index) {
                                return BuildItemRow(
                                  item: state.alladvertisminte[index],
                                  isTablet: true,
                                );
                              },
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class BuildItemRow extends StatelessWidget {
  final Item item;
  final bool isTablet;

  const BuildItemRow({
    super.key,
    required this.item,
    required this.isTablet,
  });

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Row(
        children: [
          Expanded(child: Center(child: Text(item.price.toString()))),
          Expanded(child: Center(child: Text(item.name))),
          Expanded(child: Center(child: Text(item.description))),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: item.advertisementImages.map((img) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: InkWell(
                    onTap: () {
                      _openUrl(img.imageName);
                    },
                    child: SelectableText(
                      img.imageName,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      // overflow: TextOverflow.ellipsis, // SelectableText لا يدعم overflow
                    ),
                  ),
                );
              }).toList(),
            ),
          ),


          Expanded(child: Center(child: Text(item.status))),
          Expanded(
            child: isTablet
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ActionBtn(label: 'قبول', color: Colors.yellow),
                ActionBtn(label: 'حذف', color: Colors.red),
              ],
            )
                : Center(
              child: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'تعديل') {
                    // context.read<BarCubit>().changeitems(1);
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'قبول', child: Text('قبول')),
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
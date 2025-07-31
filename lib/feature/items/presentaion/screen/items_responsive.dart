import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/const/widget/action_button.dart';
import '../../data/model/advertisminte.dart';
import '../widget/item_mobile.dart';
import '../widget/item_tablet.dart';


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
          Expanded(child: Center(child: SelectableText(item.price.toString()))),
          Expanded(child: Center(child: SelectableText(item.name))),
          Expanded(child: Center(child: SelectableText(item.description))),
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
          Expanded(child: Center(child: SelectableText(item.status))),
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

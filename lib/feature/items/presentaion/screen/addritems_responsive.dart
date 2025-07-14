import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widget/add_item_mobile.dart';
import '../widget/additem_desktop_view.dart';

class AddritemsResponsive extends StatelessWidget {
  AddritemsResponsive({super.key});
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController currency = TextEditingController();
  final TextEditingController description = TextEditingController();

  static const mobileBreakpoint = 700;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileBreakpoint) {
          return Additemmobileview(
            name: name,
            phone: phone,
            price: price,
            currency: currency,
            description: description,
          );
        } else {
          return Additem_DesktopView(
            name: name,
              phone: phone,
              price: price,
              currency: currency,
              description: description,);
        }
      },
    );
  }
}


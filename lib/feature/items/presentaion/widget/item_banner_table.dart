import 'package:flutter/material.dart';
import '../../../../core/utils/font/fonts.dart';

class ItemBannerTableRow extends StatelessWidget {
  const ItemBannerTableRow({super.key, required this.name,  this.flex});
final String name;
final int? flex;
  @override
  Widget build(BuildContext context) {
    return                     Expanded(
      flex:flex??1 ,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffFAFAFA),
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(0),
        ),
        padding: EdgeInsets.all(8),
        child: Center(
          child: Text(
            name,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontFamily: Fonts.cairo,
              fontSize: 12,
            ),
          ),
        ),
      ),
    )
    ;
  }
}
class ItemBannerTablewidget extends StatelessWidget {
  const ItemBannerTablewidget({super.key, required this.name, this.widget, this.flex});
  final String? name;
  final Widget? widget;
  final int? flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? 1,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffFAFAFA),
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(0),
        ),
        padding: EdgeInsets.all(8), // Add padding for better spacing
        child: Center(
          child: widget ??
              Text(
                name ?? "",
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontFamily: Fonts.cairo,
                  fontSize: 12,
                ),
              ),
        ),
      ),
    );
  }
}
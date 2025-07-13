import 'package:flutter/material.dart';
import 'package:lahj_center/core/utils/appstyle/app_styles.dart';

import '../../utils/colors/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.name, this.onTap, this.buttoncolor, this.width});
final String name;
final void Function()? onTap;
final Color? buttoncolor;
final double? width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width:width?? .94*MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color:buttoncolor?? Appcolors.kprimary,
            borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Text(
            name,
            style: AppStyles.buttonstyle(context),
          ),
        ),
      ),
    );
  }
}

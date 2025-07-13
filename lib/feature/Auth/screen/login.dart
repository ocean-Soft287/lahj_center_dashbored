import 'package:flutter/material.dart';
import 'package:lahj_center/feature/Auth/widget/login_widget/mobile_loginscreen.dart';
import '../../../core/utils/appstyle/size_config.dart';
import '../widget/login_widget/tablet_loginscreen.dart';


class ResponsiveLogin extends StatefulWidget {
  const ResponsiveLogin({super.key});

  @override
  State<ResponsiveLogin> createState() => _ResponsiveLoginState();
}

class _ResponsiveLoginState extends State<ResponsiveLogin> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(


     body: LayoutBuilder(builder: (context, constrains) {
        if (constrains.maxWidth < 800) {
            return MobileLoginScreen();

        }
        else if (constrains.maxWidth < 1200) {
          return TabletLoginScreen();
        } else
        {
          return TabletLoginScreen();
        }
      }),
    );
  }
}
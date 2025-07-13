import 'package:flutter/material.dart';
import 'package:lahj_center/feature/Auth/screen/login.dart';

import '../../../feature/Auth/screen/forgetpassword.dart';
import '../../../feature/items/presentaion/screen/edit_item.dart';
import '../../const/widget/custom_column_slider.dart';
class Routes {
  static const String login = '/login';
  static const String forgetPassword = '/forget-password';
  static const String splash = '/splash';
  static const String home = '/home';
  static const String edititem='/edititem';
}

class AppRouter {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const ResponsiveLogin());

      case Routes.forgetPassword:
        return MaterialPageRoute(
            builder: (_) => const Forgetpasswordresponsive());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const CustomColumnSlider());

      case Routes.edititem:
        return MaterialPageRoute(builder: (_) => const EditItem());

      default:
        return MaterialPageRoute(builder: (_) => const ResponsiveLogin());
    }
  }
}


//EditItem
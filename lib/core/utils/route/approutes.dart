import 'package:flutter/material.dart';
import '../../../feature/Auth/presentation/screen/forgetpassword.dart';
import '../../../feature/Auth/presentation/screen/login.dart';
import '../../../feature/Auth/presentation/screen/reset_password.dart';
import '../../../feature/items/presentaion/screen/edit_item.dart';
import '../../const/widget/custom_column_slider.dart';
class Routes {
  static const String login = '/login';
  static const String forgetPassword = '/forget-password';
  static const String resetpassword='/resetpassword';
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
        
      case Routes.resetpassword:
        return MaterialPageRoute(builder: (_)=>ResponsiveResetLogin());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const CustomColumnSlider());

      // case Routes.edititem:
      //   return MaterialPageRoute(builder: (_) => const EditItem());

      default:
        return MaterialPageRoute(builder: (_) => const ResponsiveLogin());
    }
  }
}


//EditItem
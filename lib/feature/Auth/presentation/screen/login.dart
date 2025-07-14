import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/utils/appstyle/size_config.dart';
import '../cubit/auth_cubit.dart';
import '../widget/login_widget/mobile_loginscreen.dart';
import '../widget/login_widget/tablet_loginscreen.dart';

final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();

class ResponsiveLogin extends StatefulWidget {
  const ResponsiveLogin({super.key});

  @override
  State<ResponsiveLogin> createState() => _ResponsiveLoginState();
}

class _ResponsiveLoginState extends State<ResponsiveLogin> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return  BlocProvider(
      create: (context) => GetIt.instance<AuthCubit>(),
      child: Scaffold(


        body: LayoutBuilder(builder: (context, constrains) {
          if (constrains.maxWidth < 800) {
            return MobileLoginScreen(
              emailController: email, passwordController: password,);
          }
          else {
            return TabletLoginScreen(
              emailController: email, passwordController: password,);
          }
        }),
      ),
    );
  }
}
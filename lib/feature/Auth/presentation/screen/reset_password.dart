import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lahj_center/feature/Auth/presentation/widget/change_password/change_password_tabler.dart';
import '../../../../core/utils/appstyle/size_config.dart';
import '../cubit/auth_cubit.dart';
import '../widget/change_password/change_password_phone.dart';

class ResponsiveResetLogin extends StatefulWidget {
  const ResponsiveResetLogin({super.key});

  @override
  State<ResponsiveResetLogin> createState() => _ResponsiveResetLoginState();
}

class _ResponsiveResetLoginState extends State<ResponsiveResetLogin> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BlocProvider(
      create: (context) => GetIt.instance<AuthCubit>(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            return const ConfirmPasswordScreenphone();
          } else {
            return const ConfirmPasswordTabletScreen();
          }
        },
      ),
    );
  }
}

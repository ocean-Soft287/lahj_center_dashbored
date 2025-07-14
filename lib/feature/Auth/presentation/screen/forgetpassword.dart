import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/utils/appstyle/size_config.dart';
import '../cubit/auth_cubit.dart';
import '../widget/forget_widget/forget_pss_phone.dart';
import '../widget/forget_widget/forget_pss_tablet.dart';

final TextEditingController email = TextEditingController();

class Forgetpasswordresponsive extends StatelessWidget {
  const Forgetpasswordresponsive({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocProvider(
      create: (context) => GetIt.instance<AuthCubit>(),
      child: Scaffold(


        body: LayoutBuilder(builder: (context, constrains) {
          if (constrains.maxWidth < 800) {
            return ForgetPssPhone();
          }
          else {
            return ForgetPssTablet();
          }
        }),
      ),
    );
  }
}

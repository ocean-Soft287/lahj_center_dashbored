import 'package:flutter/material.dart';

import '../../../core/utils/appstyle/size_config.dart';
import '../widget/forget_widget/forget_pss_phone.dart';
import '../widget/forget_widget/forget_pss_tablet.dart';

class Forgetpasswordresponsive extends StatelessWidget {
  const Forgetpasswordresponsive({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(


      body: LayoutBuilder(builder: (context, constrains) {
        if (constrains.maxWidth < 800) {
          return ForgetPssPhone();

        }
        else if (constrains.maxWidth < 1200) {
          return ForgetPssTablet();
        } else
        {
          return ForgetPssTablet();
        }
      }),
    );
  }
}

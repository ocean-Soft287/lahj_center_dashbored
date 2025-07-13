import 'package:flutter/material.dart';

import '../../../../core/const/widget/custom_button.dart';
import '../../../../core/const/widget/custom_column_slider.dart';
import '../../../../core/utils/appstyle/app_styles.dart';
import '../../../../core/utils/image/images.dart';

class DesktopLoginScreen extends StatefulWidget {
  const DesktopLoginScreen({super.key});

  @override
  _DesktopLoginScreenState createState() => _DesktopLoginScreenState();
}

class _DesktopLoginScreenState extends State<DesktopLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    Images.logo,
                    width: 200, // ضبط حجم الصورة
                  ),
                ),

                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "تسجيل الدخول",
                          style: AppStyles.styleLogin(context),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "الايميل",
                            labelStyle: AppStyles.textformfieldstyle(context),
                          ),
                        ),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "كلمه السر",
                            labelStyle: AppStyles.textformfieldstyle(context),
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomButton(name: 'تسجيل الدخول',onTap: (){
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => CustomColumnSlider()),
                                (route) => false,
                          );

                        },),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

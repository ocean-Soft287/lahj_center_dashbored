import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahj_center/core/utils/route/approutes.dart';

import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/utils/appstyle/app_styles.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../cubit/auth_cubit.dart';
import '../login_widget/mobile_loginscreen.dart';

class ForgetPssPhone extends StatefulWidget {
  const ForgetPssPhone({super.key});
  @override
  State<ForgetPssPhone> createState() => _ForgetPssPhoneState();
}

class _ForgetPssPhoneState extends State<ForgetPssPhone> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFE6F3EA), // Light green background as in the image
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TriangleContainer(),
            const SizedBox(height: 20),
            Container(
              width: 0.8 * MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Appcolors.kwhite,
                shape: BoxShape.rectangle,
                border: Border.all(color: Appcolors.kwhite),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "هل نسيت كلمة السر",
                      style: AppStyles.styleLogin(context),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller:emailController,
                      decoration: InputDecoration(
                        labelText: "الايميل",
                        labelStyle: AppStyles.textformfieldstyle(context),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green.shade700),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),
                    const SizedBox(height: 10),
                    const SizedBox(height: 20),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        } else if (state is AuthForgetPasswordSuccess) {
                          Navigator.pushNamed(context, Routes.resetpassword);


                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            name: 'فقدان كلمه السر',
                            onTap: () {
                              final email = emailController.text.trim();

                              if (email.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("يرجى إدخال الايميل"),
                                  ),
                                );
                              } else {
                                context.read<AuthCubit>().forgetPassword(
                                  email: email,
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),

                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


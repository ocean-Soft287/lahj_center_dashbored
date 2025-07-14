import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/utils/appstyle/app_styles.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/utils/route/approutes.dart';
import '../../cubit/auth_cubit.dart';
import '../login_widget/mobile_loginscreen.dart';

class ConfirmPasswordScreenphone extends StatefulWidget {
  const ConfirmPasswordScreenphone({super.key});

  @override
  State<ConfirmPasswordScreenphone> createState() => _ConfirmPasswordScreenphoneState();
}

class _ConfirmPasswordScreenphoneState extends State<ConfirmPasswordScreenphone> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController tokenController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    tokenController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F3EA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TriangleContainer(),
            const SizedBox(height: 20),
            Container(
              width: 0.8 * MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Appcolors.kwhite,
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
                  children: [
                    Text(
                      "تأكيد كلمة المرور الجديدة",
                      style: AppStyles.styleLogin(context),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: emailController,
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
                    TextField(
                      controller: tokenController,
                      decoration: InputDecoration(
                        labelText: "رمز التأكيد",
                        labelStyle: AppStyles.textformfieldstyle(context),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green.shade700),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "كلمة المرور الجديدة",
                        labelStyle: AppStyles.textformfieldstyle(context),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green.shade700),
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          } else if (state is AuthResetPasswordSuccess) {
                            Navigator.pushNamed(context, Routes.login);
                          }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            name: 'تحديث كلمة المرور',
                            onTap: () {
                              final email = emailController.text.trim();
                              final token = tokenController.text.trim();
                              final newPassword = passwordController.text;

                              if (email.isEmpty || token.isEmpty || newPassword.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("يرجى ملء جميع الحقول"),
                                  ),
                                );
                              } else {
                                context.read<AuthCubit>().resetPassword(
                                  email: email,
                                  token: token,
                                  newPassword: newPassword,
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

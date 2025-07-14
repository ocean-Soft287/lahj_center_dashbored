import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahj_center/feature/Auth/presentation/cubit/auth_cubit.dart';
import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/utils/image/images.dart';
import '../../../../../core/utils/route/approutes.dart';
import '../login_widget/tablet_loginscreen.dart';

class ConfirmPasswordTabletScreen extends StatefulWidget {
  const ConfirmPasswordTabletScreen({super.key});

  @override
  State<ConfirmPasswordTabletScreen> createState() => _ConfirmPasswordTabletScreenState();
}

class _ConfirmPasswordTabletScreenState extends State<ConfirmPasswordTabletScreen> {
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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [
          // Left side: Form
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "تأكيد كلمة المرور الجديدة",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 30),

                      // Email
                      TextField(
                        controller: emailController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          labelText: "البريد الالكتروني",
                          labelStyle: const TextStyle(color: Colors.grey),
                          hintText: "أدخل البريد الإلكتروني",
                          hintStyle: TextStyle(color: Colors.grey[300]),
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Token
                      TextField(
                        controller: tokenController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          labelText: "رمز التأكيد",
                          labelStyle: const TextStyle(color: Colors.grey),
                          hintText: "أدخل رمز التأكيد",
                          hintStyle: TextStyle(color: Colors.grey[300]),
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),

                      // New Password
                      TextField(
                        controller: passwordController,
                        textAlign: TextAlign.right,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "كلمة المرور الجديدة",
                          labelStyle: const TextStyle(color: Colors.grey),
                          hintText: "أدخل كلمة المرور الجديدة",
                          hintStyle: TextStyle(color: Colors.grey[300]),
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 30),

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
            ),
          ),

          // Right side: Logo with background
          Expanded(
            flex: 1,
            child: ClipPath(
              clipper: CustomTrapezoidClipper(),
              child: Container(
                color: Appcolors.kprimary.withOpacity(0.32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.logo,
                      fit: BoxFit.scaleDown,
                      width: width < 1200 ? 200 : 300,
                      height: width < 1200 ? 300 : 500,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

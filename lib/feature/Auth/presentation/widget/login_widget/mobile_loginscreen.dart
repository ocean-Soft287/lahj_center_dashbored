import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahj_center/core/utils/colors/colors.dart';
import 'package:lahj_center/core/const/widget/custom_button.dart';
import 'package:lahj_center/core/const/widget/custom_column_slider.dart';
import 'package:lahj_center/core/utils/appstyle/app_styles.dart';
import 'package:lahj_center/core/utils/image/images.dart';

import '../../cubit/auth_cubit.dart';

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({super.key, required this.emailController, required this.passwordController});
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  @override
  void dispose() {
    widget.emailController.dispose();
    widget.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F3EA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TriangleContainer(),
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
                  children: [
                    Text("تسجيل الدخول", style: AppStyles.styleLogin(context)),
                    const SizedBox(height: 20),
                    TextField(
                      controller: widget.emailController,
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
                      controller: widget.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "كلمه السر",
                        labelStyle: AppStyles.textformfieldstyle(context),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green.shade700),
                        ),
                        suffixIcon: const Icon(Icons.visibility_off),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // التوجه لنسيت كلمة السر
                        },
                        child: const Text(
                          "هل نسيت كلمة السر؟",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        } else if (state is AuthSuccess) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const CustomColumnSlider()),
                                (route) => false,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            name: 'تسجيل الدخول',
                            onTap: () {
                              final email = widget.emailController.text.trim();
                              final password = widget.passwordController.text.trim();

                              if (email.isEmpty || password.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("يرجى إدخال الايميل وكلمة السر"),
                                  ),
                                );
                              } else {
                                context.read<AuthCubit>().login(
                                  email: email,
                                  password: password,
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

class TriangleContainer extends StatelessWidget {
  const TriangleContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomShapeClipper(),
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        color: Appcolors.kprimary.withOpacity(0.30),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              Images.logo,
              height: 200,
              width: 200,
            ),
          ),
        ),
      ),
    );
  }
}
class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.6); // Mid-left
    path.lineTo(size.width, size.height); // Bottom-right
    path.lineTo(size.width, 0); // Top-right
    path.lineTo(0, 0); // Top-left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


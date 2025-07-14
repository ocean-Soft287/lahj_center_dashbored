import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahj_center/core/utils/colors/colors.dart';

import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/const/widget/custom_column_slider.dart';
import '../../../../../core/utils/image/images.dart';
import '../../../../../core/utils/route/approutes.dart';
import '../../cubit/auth_cubit.dart';



class TabletLoginScreen extends StatefulWidget {
  const TabletLoginScreen({super.key, required this.emailController, required this.passwordController});
  final TextEditingController emailController;
  final TextEditingController passwordController ;
  @override
  _TabletLoginScreenState createState() => _TabletLoginScreenState();
}

class _TabletLoginScreenState extends State<TabletLoginScreen> {

  @override
  void dispose() {
    widget.emailController.dispose();
    widget.passwordController.dispose();
    super.dispose();
  }
  @override

  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [

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
                        "تسجيل الدخول إلى حسابك",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller:widget. emailController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          labelText: "البريد الالكتروني",
                          labelStyle: TextStyle(color: Colors.grey),
                          hintText: "إدخال البريد الالكتروني",
                          hintStyle: TextStyle(color: Colors.grey[300]),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller:widget. passwordController,
                        obscureText: true,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          labelText: "كلمة السر",
                          labelStyle: TextStyle(color: Colors.grey),
                          hintText: "إدخال كلمة السر",
                          hintStyle: TextStyle(color: Colors.grey[300]),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.visibility_off),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.forgetPassword);

                        },
                        child: Text(
                          "هل نسيت كلمة السر؟",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 30),
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
            ),
          ),
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
                      fit: BoxFit.scaleDown,
                     Images.logo, // تأكد من تعديل مسار الصورة
                      width:width<1200?200: 300,
                    height:width<1200?300: 500,
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

class CustomTrapezoidClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0); // Start at top-left
    path.lineTo(size.width * 0.6, 0); // Go right 70% of width
    path.lineTo(size.width, size.height); // Go to bottom-right
    path.lineTo(0, size.height); // Go to bottom-left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
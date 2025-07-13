import 'package:flutter/material.dart';
import 'package:lahj_center/core/utils/colors/colors.dart';

import '../../../../core/const/widget/custom_button.dart';
import '../../../../core/const/widget/custom_column_slider.dart';
import '../../../../core/utils/image/images.dart';
import '../../../../core/utils/route/approutes.dart';


class TabletLoginScreen extends StatefulWidget {
  const TabletLoginScreen({super.key});

  @override
  _TabletLoginScreenState createState() => _TabletLoginScreenState();
}

class _TabletLoginScreenState extends State<TabletLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [
          // Left side with logo and background (now with left slant)
          // Right side with login form
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end, // لمحاذاة النص العربي لليمين
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
                        controller: emailController,
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
                        controller: passwordController,
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
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          name: 'تسجيل الدخول',
                          onTap: () {
                            if (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CustomColumnSlider()),
                                    (route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("يرجى إدخال الايميل وكلمة السر"),
                                ),
                              );
                            }
                          },
                        ),
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
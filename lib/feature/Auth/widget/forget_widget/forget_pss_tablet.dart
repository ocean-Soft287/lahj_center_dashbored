import 'package:flutter/material.dart';

import '../../../../core/utils/colors/colors.dart';
import '../../../../core/utils/image/images.dart';
import '../login_widget/tablet_loginscreen.dart'; // تأكد من استيراد مكتبة الماتيريال


class ForgetPssTablet extends StatefulWidget {
  const ForgetPssTablet({super.key});

  @override
  State<ForgetPssTablet> createState() => _ForgetPssTabletState();
}

class _ForgetPssTabletState extends State<ForgetPssTablet> {
  final TextEditingController emailController = TextEditingController();

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
                        "هل نسيت كلمة السر",
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
                      ElevatedButton(
                        onPressed: () {
                          // Action for forget password
                        },
                        child: Text("إرسال"),
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


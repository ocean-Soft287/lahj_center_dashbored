import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lahj_center/feature/Auth/presentation/cubit/auth_cubit.dart';
import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/utils/colors/colors.dart';
import '../../../../../core/utils/image/images.dart';
import '../../../../../core/utils/route/approutes.dart';
import '../login_widget/tablet_loginscreen.dart'; // تأكد من استيراد مكتبة الماتيريال


class ForgetPssTablet extends StatefulWidget {
  const ForgetPssTablet({super.key, });
  @override
  State<ForgetPssTablet> createState() => _ForgetPssTabletState();
}

class _ForgetPssTabletState extends State<ForgetPssTablet> {
@override
final TextEditingController emailController = TextEditingController();

@override
void dispose() {
  emailController.dispose();
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


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lahj_center/core/utils/colors/colors.dart';
import 'package:lahj_center/core/utils/font/fonts.dart';
import 'package:lahj_center/feature/users/data/model/user_model.dart';
import 'package:lahj_center/feature/users/presentation/manger/user_cubit.dart';
import 'package:lahj_center/feature/users/presentation/view/widget/user_dialoug.dart';
import '../../../../core/const/widget/search.dart';
import '../../../../core/const/widget/tab_header.dart';
import 'package:intl/intl.dart';

final TextEditingController firstNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController imageController = TextEditingController();
final TextEditingController activityController = TextEditingController();
final TextEditingController deviceTokenController = TextEditingController();
String selectedRole = 'Member';

class UserResponsive extends StatelessWidget {
  const UserResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();

    return BlocProvider(
      create: (context) => GetIt.instance<UserCubit>()..getUsers(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "إدارة المستخدمين",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: Fonts.cairo,
                                color: Appcolors.kblue,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "معلومات تفصيلية عن العناصر",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                fontFamily: Fonts.cairo,
                                color: Appcolors.kgrey3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Appcolors.kwhite,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 250,
                                height: 40,
                                child: SearchTextformfield(controller: search),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (_) => UserDialog(
                                          isEdit: false,
                                          firstNameController:
                                              firstNameController,
                                          lastNameController:
                                              lastNameController,
                                          emailController: emailController,
                                          passwordController:
                                              passwordController,
                                          phoneController: phoneController,
                                          imageController: imageController,
                                          activityController:
                                              activityController,
                                          deviceTokenController:
                                              deviceTokenController,
                                          selectedRole: selectedRole,
                                          onRoleChanged:
                                              (role) => selectedRole = role,
                                        ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Appcolors.blue,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  "إنشاء حساب",
                                  style: TextStyle(
                                    fontFamily: Fonts.cairo,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          color: const Color(0xffF9FAFB),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Row(
                              children: const [
                                TableHeader(text: "الاسم"),
                                TableHeader(text: "البريد الإلكتروني"),
                                TableHeader(text: "تاريخ التسجيل"),
                                TableHeader(text: "الإجراء", flex: 2),
                              ],
                            ),
                          ),
                        ),
                        Divider(height: 1, color: Colors.grey.shade300),
                        BlocConsumer<UserCubit, UserState>(
                          listener: (context, state) {
                            // TODO: implement listener
                          },
                          builder: (context, state) {
                            final cubit = context.read<UserCubit>();
                            if (state is UserLoaded) {
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: cubit.users.length,
                                separatorBuilder:
                                    (_, __) => Divider(
                                      height: 1,
                                      color: Colors.grey.shade200,
                                    ),
                                itemBuilder: (context, index) {
                                  User user = cubit.users[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Text(user.fullName),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(user.email),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              DateFormat(
                                                'yyyy-MM-dd',
                                              ).format(user.addDate),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                _actionButton(
                                                  context: context,
                                                  icon: Icons.block,
                                                  color: Colors.orange,
                                                  label: "حظر",
                                                  onPressed: () {
                                                    showConfirmationDialog(
                                                      context: context,
                                                      title: 'تأكيد الحظر',
                                                      content:
                                                          'هل أنت متأكد أنك تريد حظر هذا المستخدم؟',
                                                      onConfirm: () {
                                                        context.read<UserCubit>().block(user.id);

                                                        // ScaffoldMessenger.of(
                                                        //   context,
                                                        // ).showSnackBar(
                                                        //   const SnackBar(
                                                        //     content: Text(
                                                        //       'تم حظر المستخدم بنجاح',
                                                        //     ),
                                                        //   ),
                                                        // );
                                                      },
                                                    );
                                                  },
                                                ),
                                                const SizedBox(width: 6),
                                                _actionButton(
                                                  context: context,
                                                  icon: Icons.delete,
                                                  color: Colors.red,
                                                  label: "حذف",
                                                  onPressed: () {
                                                    showConfirmationDialog(
                                                      context: context,
                                                      title: 'تأكيد الحذف',
                                                      content:
                                                          'هل أنت متأكد أنك تريد حذف هذا المستخدم؟',
                                                      onConfirm: () {
                                                  context.read<UserCubit>().delete(user.id);
                                                        // ScaffoldMessenger.of(
                                                        //   context,
                                                        // ).showSnackBar(
                                                        //   const SnackBar(
                                                        //     content: Text(
                                                        //       'تم حذف المستخدم بنجاح',
                                                        //     ),
                                                        //   ),
                                                        // );
                                                      },
                                                    );
                                                  },
                                                ),
                                                const SizedBox(width: 6),
                                                _actionButton(
                                                  context: context,
                                                  icon: Icons.edit,
                                                  color: Colors.green,
                                                  label: "تعديل",
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,


                                                      builder:
                                                          (_) => UserDialog(
                                                        isEdit: true,                                                        firstNameController:
                                                        firstNameController,
                                                        lastNameController:
                                                        lastNameController,
                                                        emailController: emailController,
                                                        passwordController:
                                                        passwordController,
                                                        phoneController: phoneController,
                                                        imageController: imageController,
                                                        activityController:
                                                        activityController,
                                                        deviceTokenController:
                                                        deviceTokenController,
                                                        selectedRole: selectedRole,
                                                        onRoleChanged:
                                                            (role) => selectedRole = role,
                                                      ),
                                                    );                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  static Widget _actionButton({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onPressed,
  }) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 16),
            if (!isMobile) ...[
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

void showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              child: const Text('تأكيد'),
            ),
          ],
        ),
  );
}

import 'dart:io' show File;
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/class_helper/imagepicker_class.dart';
import '../../../../../core/utils/class_helper/validator_class.dart';
import '../../manger/user_cubit.dart';

class UserDialog extends StatelessWidget {
  final bool isEdit;

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;
  final TextEditingController imageController;
  final TextEditingController activityController;
  final TextEditingController deviceTokenController;

  final String selectedRole;
  final Function(String) onRoleChanged;

  const UserDialog({
    super.key,
    required this.isEdit,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
    required this.imageController,
    required this.activityController,
    required this.deviceTokenController,
    required this.selectedRole,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _roles = ['Admin', 'Member'];

    final selectedImage = ValueNotifier<Object?>(null);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(isEdit ? 'تعديل مستخدم' : 'إنشاء مستخدم'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(firstNameController, 'First Name', true,
                    validator: FormValidators.requiredField),
                _buildTextField(lastNameController, 'Last Name', true,
                    validator: FormValidators.requiredField),
                _buildTextField(emailController, 'Email', true,
                    validator: FormValidators.email),
                _buildTextField(passwordController, 'Password', !isEdit,
                    obscure: true, validator: FormValidators.password),
                _buildTextField(phoneController, 'Phone Number', true,
                    validator: FormValidators.phone),
                _buildTextField(deviceTokenController, 'Device Token', true,
                    validator: FormValidators.requiredField),
                _buildTextField(activityController, 'Activity', false),
                const SizedBox(height: 10),

                /// صورة
                ValueListenableBuilder<Object?>(
                  valueListenable: selectedImage,
                  builder: (context, image, _) {
                    return Row(
                      children: [
                        if (image != null)
                          if (image is File)
                            Image.file(
                              image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          else if (image is Uint8List)
                            Image.memory(
                              image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () async {
                            final pickedFile =
                            await ImagePickerHelper.pickImage();
                            if (pickedFile != null) {
                              selectedImage.value = pickedFile;
                              if (pickedFile is File) {
                                imageController.text =
                                    pickedFile.path.split('/').last;
                              } else if (pickedFile is Uint8List) {
                                imageController.text = 'web_selected_image';
                              }
                            }
                          },
                          icon: const Icon(Icons.photo),
                          label: const Text('اختر صورة'),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 10),

                /// الدور
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  items: _roles
                      .map((role) =>
                      DropdownMenuItem(value: role, child: Text(role)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) onRoleChanged(value);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Role',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<UserCubit>().addUser(
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                email: emailController.text,
                password: passwordController.text,
                phoneNumber: phoneController.text,
                activity: activityController.text,
                role: selectedRole,
                imageFile: selectedImage.value,
                imageName: imageController.text,
              );

              Navigator.pop(context);
            }
          },
          child: Text(isEdit ? 'تعديل' : 'إنشاء'),
        ),
      ],
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label,
      bool required, {
        bool obscure = false,
        String? Function(String?)? validator,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: required ? validator ?? FormValidators.requiredField : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/utils/class_helper/imagepicker_class.dart';
import '../../../../../core/utils/class_helper/validator_class.dart';
import '../../manger/user_cubit.dart';

class UserDialog extends StatelessWidget {
  final bool isEdit;
  final String? id; // ✅ Add id for edit mode

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
    this.id, // ✅ Optional in edit mode
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

    final ValueNotifier<XFile?> pickedXFile = ValueNotifier(null);
    final ValueNotifier<Uint8List?> pickedBytes = ValueNotifier(null);

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
                    obscure: true,
                    validator: !isEdit ? FormValidators.password : null),
                _buildTextField(phoneController, 'Phone Number', true,
                    validator: FormValidators.phone),
                _buildTextField(deviceTokenController, 'Device Token', true,
                    validator: FormValidators.requiredField),
                _buildTextField(activityController, 'Activity', false),
                const SizedBox(height: 10),

                // Image Picker
                ValueListenableBuilder2<XFile?, Uint8List?>(
                  firstNotifier: pickedXFile,
                  secondNotifier: pickedBytes,
                  builder: (context, file, bytes, _) {
                    final image = kIsWeb ? bytes : file;
                    return Row(
                      children: [
                        if (image != null)
                          if (image is XFile)
                            Image.file(
                              File(image.path),
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
                            final picked = await ImagePickerHelper.pickImage();
                            if (picked != null) {
                              if (picked is XFile) {
                                pickedXFile.value = picked;
                                pickedBytes.value = null;
                                imageController.text =
                                    picked.path.split('/').last;
                              } else if (picked is Uint8List) {
                                pickedBytes.value = picked;
                                pickedXFile.value = null;
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

                // Role Dropdown
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
              if (!isEdit) {
                context.read<UserCubit>().addUser(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  phoneNumber: phoneController.text,
                  activity: activityController.text,
                  role: selectedRole,
                  pickedXFile: pickedXFile.value,
                  pickedBytes: pickedBytes.value,
                );
              } else {
                context.read<UserCubit>().updateUser(
                  id: id!, // ✅ make sure caller passes id
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  phoneNumber: phoneController.text,
                  activity: activityController.text,
                  role: selectedRole,
                  pickedXFile: pickedXFile.value,
                  pickedBytes: pickedBytes.value,
                );
              }
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

class ValueListenableBuilder2<A, B> extends StatelessWidget {
  final ValueListenable<A> firstNotifier;
  final ValueListenable<B> secondNotifier;
  final Widget Function(BuildContext, A, B, Widget?) builder;

  const ValueListenableBuilder2({
    super.key,
    required this.firstNotifier,
    required this.secondNotifier,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: firstNotifier,
      builder: (context, a, _) {
        return ValueListenableBuilder<B>(
          valueListenable: secondNotifier,
          builder: (context, b, child) {
            return builder(context, a, b, child);
          },
        );
      },
    );
  }
}

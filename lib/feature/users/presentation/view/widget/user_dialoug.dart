import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
    final _roles = ['Admin', 'Member',];
    final ImagePicker picker = ImagePicker();

    File? selectedImage;
    Uint8List? webImageBytes;

    return StatefulBuilder(
      builder: (context, setState) => AlertDialog(
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
                  _buildTextField(firstNameController, 'First Name', true),
                  _buildTextField(lastNameController, 'Last Name', true),
                  _buildTextField(emailController, 'Email', true),
                  _buildTextField(passwordController, 'Password', !isEdit, obscure: true),
                  _buildTextField(phoneController, 'Phone Number', true),
                  _buildTextField(deviceTokenController, 'Device Token', true),
                  _buildTextField(activityController, 'Activity', false),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      if (kIsWeb && webImageBytes != null)
                        Image.memory(webImageBytes!, width: 50, height: 50, fit: BoxFit.cover)
                      else if (!kIsWeb && selectedImage != null)
                        Image.file(selectedImage!, width: 50, height: 50, fit: BoxFit.cover),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
                          if (picked != null) {
                            if (kIsWeb) {
                              final bytes = await picked.readAsBytes();
                              setState(() {
                                webImageBytes = bytes;
                                imageController.text = picked.name;
                              });
                            } else {
                              setState(() {
                                selectedImage = File(picked.path);
                                imageController.text = picked.path;
                              });
                            }
                          }
                        },
                        icon: const Icon(Icons.photo),
                        label: const Text('اختر صورة'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedRole,
                    items: _roles.map((role) => DropdownMenuItem(value: role, child: Text(role))).toList(),
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
                Navigator.pop(context);
              }
            },
            child: Text(isEdit ? 'تعديل' : 'إنشاء'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label,
      bool required, {
        bool obscure = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        enabled: required || !isEdit,
        validator: required ? (value) => (value == null || value.isEmpty) ? 'مطلوب' : null : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

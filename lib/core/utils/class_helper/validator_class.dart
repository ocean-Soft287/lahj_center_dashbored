class FormValidators {
  static String? requiredField(String? value, {String message = 'هذا الحقل مطلوب'}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'بريد إلكتروني غير صالح';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'رقم الهاتف مطلوب';
    }
    final phoneRegex = RegExp(r'^\d{7,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'رقم هاتف غير صالح';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    return null;
  }
  static String? arabicOnly(String? value, {String message = 'يرجى إدخال النص باللغة العربية فقط'}) {
    if (value == null || value.trim().isEmpty) return 'هذا الحقل مطلوب';
    final arabicRegex = RegExp(r'^[\u0600-\u06FF\s]+$');
    if (!arabicRegex.hasMatch(value.trim())) {
      return message;
    }
    return null;
  }

  /// ✅ تحقق إن النص إنجليزي فقط
  static String? englishOnly(String? value, {String message = 'Please enter English letters only'}) {
    if (value == null || value.trim().isEmpty) return 'This field is required';
    final englishRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!englishRegex.hasMatch(value.trim())) {
      return message;
    }
    return null;
  }
}

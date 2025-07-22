import 'dart:io' show File;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import 'dart:io' show File;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  /// Picks an image from gallery
  /// On mobile returns File, on web returns Uint8List
  static Future<Object?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return null;

    if (kIsWeb) {
      // على الويب نستخدم bytes
      final bytes = await pickedFile.readAsBytes();
      return bytes; // Uint8List
    } else {
      // على الموبايل نستخدم File
      return File(pickedFile.path);
    }
  }
}

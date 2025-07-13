import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors/colors.dart';

class SearchTextformfield extends StatelessWidget {
  const SearchTextformfield({super.key, required this.controller});
final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        labelText: "ابحث.....",

        fillColor: Appcolors.kwhite, // Fill color for the text field
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFD9E1E1), // Border color with hex code
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(10.0), // Adjust the border radius
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFD9E1E1),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFD9E1E1),
            width: 1.5, // Slightly thicker border when focused
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        prefixIcon: Icon(Icons.search, color: Color(0xFFD9E1E1)), // Add search icon
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextForm extends StatelessWidget {
  const AppTextForm({
    super.key,
    required this.hintText,
    required this.validator,
    required this.controller,
  });

  final String hintText;

  final String? Function(String?)? validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          fillColor: Color(0xffF1F1F1),
          filled: true,
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          hintStyle: GoogleFonts.inter(
              fontSize: 14, fontWeight: FontWeight.w300, color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          border: const OutlineInputBorder()),
      validator: validator,
    );
  }
}

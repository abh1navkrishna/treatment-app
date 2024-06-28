import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/colors.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({
    super.key,
    required this.text,
  });

  final Text text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration:
      BoxDecoration(color: green, borderRadius: BorderRadius.circular(9)),
      child: Center(
          child: text),
    );
  }
}

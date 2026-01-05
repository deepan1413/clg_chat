import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final Function(String)? onChanged;
  final int maxLines;

  const MyTextfield({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.onChanged,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: obscureText ? 1 : maxLines,
        onChanged: onChanged,

        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Color(0xfe21B3EC)),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xfe21B3EC),
              strokeAlign: 0.8,
              width: 2.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String? hint, labelText;
  final TextEditingController controller;

  final Color? borderColor;

   bool? obscureText;

  final double? borderRadius;
  final Function()? onTapObscure;
  final Function()? onTap;
  final Function(String)? onChanged;

   CustomTextField({
    required this.controller,
    this.onTapObscure,
    this.onChanged,
    this.onTap,
    this.hint,
    this.labelText,
    this.borderColor = Colors.grey,
    this.obscureText,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      onChanged:onChanged,
      textInputAction: TextInputAction.done,

      decoration: InputDecoration(
        fillColor: Theme.of(context).cardColor.withOpacity(0.2),
        filled: true,
        contentPadding: const EdgeInsets.only(right: 10, left: 10),
        counterText: "",
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: borderColor ?? Colors.grey.shade500, width: 1.2),
            borderRadius: BorderRadius.circular(borderRadius ?? 10)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: borderColor ?? Colors.grey.shade300, width: 1.2),
            borderRadius: BorderRadius.circular(borderRadius ?? 10)),
        labelText: labelText,
        hintText: hint,
        suffixIcon: obscureText!=null
            ? IconButton(
                onPressed: onTapObscure,
                icon: Icon(Icons.remove_red_eye),
              )
            : null,
      ),
      controller: controller,
      obscureText: obscureText??false,
      obscuringCharacter: "*",
    );
  }
}

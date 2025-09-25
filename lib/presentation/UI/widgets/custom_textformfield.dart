import 'package:auth_desktop_app/core/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/app_color.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String hintText;
  final TextInputType textInputType;
  final bool isPasswordField;
  final ValueChanged<String>? onChanged;
  final bool requiredField;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.textInputType,
    required this.isPasswordField,
    required this.textInputAction,
    this.onChanged,
    this.requiredField = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  String? _validate(String? value) {
    if (widget.requiredField && (value == null || value.trim().isEmpty)) {
      return '${widget.hintText} is required';
    }

    if (widget.textInputType == TextInputType.emailAddress && value != null) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (value.isNotEmpty && !emailRegex.hasMatch(value)) {
        return 'Enter a valid email';
      }
    }

    if (widget.hintText.toLowerCase().contains("name") && value != null) {
      if (value.isNotEmpty && value.length < 2) {
        return 'Enter a valid name';
      }
    }

    if (widget.isPasswordField && value != null) {
      if (value.isNotEmpty && value.length < 6) {
        return 'Password must be at least 6 characters';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveSize.isMobile
          ? ResponsiveSize.w(70)
          : ResponsiveSize.w(30),
      child: TextFormField(
        controller: widget.controller,
        textInputAction: widget.textInputAction,
        keyboardType: widget.textInputType,
        obscureText: widget.isPasswordField ? _obscureText : false,
        style: const TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppMainColor.primaryColor),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          errorStyle: TextStyle(fontSize: 14),
          label: RichText(
            text: TextSpan(
              text: widget.hintText,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
              children: widget.requiredField
                  ? const [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ]
                  : [],
            ),
          ),
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? CupertinoIcons.eye_slash_fill
                        : CupertinoIcons.eye,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
        validator: _validate,
        onChanged: widget.onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final String? mode;
  final bool enabled;

  const PasswordField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.mode,
    required this.enabled,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      validator: widget.validator,
      enabled: widget.enabled,
      style: const TextStyle(color: Colors.black54),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black54,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black54,
            width: 2,
          ),
        ),
        prefixIcon: const Icon(
          Icons.password,
          color: Colors.black54,
        ),
        hintText: "*********",
        hintStyle: const TextStyle(color: Colors.black54),
        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.black),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}

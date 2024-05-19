import 'package:flutter/material.dart';

Widget textField({
  required TextEditingController fieldController,
  required Function(String?) fieldValidate,
  required IconData icon,
  required String label,
  required String placeholder,
  bool? enabled = true,
}) {
  return TextFormField(
    controller: fieldController,
    validator: (value) => fieldValidate(value),
    enabled: enabled,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black54,
          width: 2,
        ),
      ),
      prefixIcon: Icon(
        icon,
        color: Colors.black54,
      ),
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.black,
      ),
      hintText: placeholder,
      hintStyle: const TextStyle(color: Colors.grey),
    ),
  );
}

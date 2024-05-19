import 'package:flutter/material.dart';

import '/utilities/constants/types.dart';

class RadioField extends StatefulWidget {
  final TextEditingController radioController;
  final List<RadioOption> radioOptions;
  final String? defaultValue;
  final String label;
  final bool enabled;

  const RadioField({
    super.key,
    required this.label,
    required this.radioController,
    required this.radioOptions,
    this.defaultValue,
    required this.enabled,
  });

  @override
  State<RadioField> createState() => _RadioFieldState();
}

class _RadioFieldState extends State<RadioField> {
  @override
  void initState() {
    super.initState();
    // Set the default value
    widget.radioController.text = (widget.defaultValue ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.label,
          style: const TextStyle(
            color: Colors.black,
          ),
          textAlign: TextAlign.left,
        ),
        Row(
          children: widget.radioOptions.map((option) {
            return Row(
              children: [
                Radio<String>(
                  value: option.value,
                  groupValue: widget.radioController.text,
                  onChanged: widget.enabled
                      ? (value) {
                          setState(() {
                            widget.radioController.text = value!;
                          });
                        }
                      : null,
                  activeColor: Colors.deepPurpleAccent,
                ),
                Text(
                  option.key,
                  style: TextStyle(
                      color: widget.radioController.text == option.value
                          ? Colors.black
                          : Colors.black54),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

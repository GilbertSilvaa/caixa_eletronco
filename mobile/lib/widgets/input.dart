import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    required this.label,
    this.hintText,
    this.keyBoard,
    this.controller,
    this.errorLabel,
    this.isPassword = false,
    this.handleOnChange,
  });

  final String label;
  final String? hintText;
  final bool isPassword;
  final String? errorLabel;
  final TextInputType? keyBoard;
  final TextEditingController? controller;
  final void Function(String)? handleOnChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF292929),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: errorLabel != null,
            fillColor: const Color(0x2CE66157),
            hintText: hintText,
            errorText: errorLabel,
          ),
          keyboardType: keyBoard,
          obscureText: isPassword,
          onChanged: handleOnChange,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.title,
    this.handleOnClick,
    this.isLoading = false,
  });

  final String title;
  final bool isLoading;
  final void Function()? handleOnClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: !isLoading ? handleOnClick : () {},
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Colors.red,
      ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white60,
                strokeWidth: 3,
              ),
            )
          : Text(
              title,
              style: const TextStyle(
                fontSize: 15.5,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }
}

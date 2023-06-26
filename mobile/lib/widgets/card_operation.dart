import 'package:flutter/material.dart';

class CardOperation extends StatelessWidget {
  const CardOperation({
    super.key,
    required this.title,
    required this.icon,
    this.handleOnTap,
  });

  final String title;
  final IconData icon;
  final void Function()? handleOnTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleOnTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.27,
        height: MediaQuery.of(context).size.width * 0.28,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Colors.grey[100],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.red,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardTransaction extends StatelessWidget {
  const CardTransaction({
    super.key,
    required this.typeTransaction,
    required this.dateTransaction,
    required this.valueTransaction,
    required this.positive,
  });

  final String typeTransaction;
  final DateTime dateTransaction;
  final String valueTransaction;
  final bool positive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Size.infinite.width,
      height: 80,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Color(0xFFE6EEFB),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  typeTransaction,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                positive
                    ? Text(
                        '+ $valueTransaction',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.green[800],
                        ),
                      )
                    : Text(
                        '- $valueTransaction',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.red[900],
                        ),
                      )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  DateFormat('dd/MM/yyyy HH:mm').format(dateTransaction),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

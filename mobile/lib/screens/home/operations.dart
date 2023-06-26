import 'package:flutter/material.dart';
import 'package:mobile/enums/operations.dart';
import 'package:mobile/models/cliente.dart';
import 'package:mobile/screens/operationForm/operation_screen.dart';
import 'package:mobile/widgets/card_operation.dart';

class Operations extends StatefulWidget {
  const Operations({super.key, required this.cliente});

  final Cliente cliente;

  @override
  State<Operations> createState() => _OperationsState();
}

class _OperationsState extends State<Operations> {
  void _openOperation(EOperations operation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OperationScreen(
          operation: operation,
          cliente: widget.cliente,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  'Operações',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                CardOperation(
                  icon: Icons.payments_outlined,
                  title: 'Saque',
                  handleOnTap: () {
                    _openOperation(EOperations.saque);
                  },
                ),
                CardOperation(
                  icon: Icons.savings_outlined,
                  title: 'Depósito',
                  handleOnTap: () {
                    _openOperation(EOperations.deposito);
                  },
                ),
                CardOperation(
                  icon: Icons.currency_exchange,
                  title: 'Transferência',
                  handleOnTap: () {
                    _openOperation(EOperations.transferencia);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

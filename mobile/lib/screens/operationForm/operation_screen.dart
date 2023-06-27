import 'package:flutter/material.dart';
import 'package:mobile/enums/operations.dart';
import 'package:mobile/models/cliente.dart';
import 'package:mobile/screens/operationForm/widgets/deposit.dart';
import 'package:mobile/screens/operationForm/widgets/transfer.dart';
import 'package:mobile/screens/operationForm/widgets/withdrawal.dart';

class OperationScreen extends StatefulWidget {
  const OperationScreen({
    super.key,
    required this.operation,
    required this.cliente,
  });

  final Cliente cliente;
  final EOperations operation;

  @override
  State<OperationScreen> createState() => _OperationScreenState();
}

class _OperationScreenState extends State<OperationScreen> {
  String _getTitle(EOperations operation) {
    switch (operation) {
      case EOperations.saque:
        return 'Saque';
      case EOperations.deposito:
        return 'Depósito';
      default:
        return 'Transferêcia';
    }
  }

  Widget getScreen(EOperations operation) {
    switch (operation) {
      case EOperations.saque:
        return Withdrawal(cliente: widget.cliente);
      case EOperations.deposito:
        return Deposit(cliente: widget.cliente);
      default:
        return Transfer(cliente: widget.cliente);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.red, size: 25),
        title: Text(
          _getTitle(widget.operation),
          style: const TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: getScreen(widget.operation),
    );
  }
}

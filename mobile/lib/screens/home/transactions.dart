import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/widgets/card_transaction.dart';

import '../../models/cliente.dart';
import '../../models/transaction.dart';

class Transactions extends StatelessWidget {
  const Transactions({
    super.key,
    required this.transactions,
    required this.cliente,
  });

  final List<Transaction> transactions;
  final Cliente cliente;

  String _verifyTransactionType(int type) {
    switch (type) {
      case 1:
        return 'Saque';
      case 2:
        return 'Depósito';
      default:
        return 'Transferência';
    }
  }

  bool _verifyTransactionPositive(Transaction transac) {
    switch (transac.tipo) {
      case 1:
        return false;
      case 2:
        return true;
      default:
        return cliente.id != transac.idCliente;
    }
  }

  @override
  Widget build(BuildContext context) {
    var moneyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: const [
                  Text(
                    'Transações',
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
                runSpacing: 20,
                children: transactions
                    .map((transac) => CardTransaction(
                          dateTransaction: transac.dtTransacao,
                          typeTransaction: _verifyTransactionType(transac.tipo),
                          valueTransaction: moneyFormat.format(transac.valor),
                          positive: _verifyTransactionPositive(transac),
                        ))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mobile/widgets/card_transaction.dart';

import '../../models/transaction.dart';

class Transactions extends StatelessWidget {
  const Transactions({super.key, required this.transactions});

  final List<Transaction> transactions;

  String _verifyType(int index) {
    switch (index) {
      case 1:
        return 'Saque';
      case 2:
        return 'Depósito';
      default:
        return 'Tranferência';
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          typeTransaction: _verifyType(transac.tipo),
                          valueTransaction: 'R\$ ${transac.valor}',
                          positive: transac.tipo == 2,
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

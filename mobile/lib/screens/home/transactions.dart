import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/http/dio_client.dart';
import 'package:mobile/widgets/card_transaction.dart';

import '../../models/cliente.dart';
import '../../models/transaction.dart';

class Transactions extends StatefulWidget {
  const Transactions({
    super.key,
    required this.cliente,
  });

  final Cliente cliente;

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
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
        return widget.cliente.id != transac.idCliente;
    }
  }

  Future<List<Transaction>?> _getTransactions() async {
    try {
      var dio = await DioClient.getInstance();
      var res =
          await dio.get('/transacao/buscar?idCliente=${widget.cliente.id}');

      if (res.statusCode == 200) {
        return res.data
            .map<Transaction>((tr) => Transaction.fromMap(tr))
            .toList();
      }
    } on DioException catch (_) {
      debugPrint('erro na requisicao');
    }
    return null;
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
              FutureBuilder(
                future: _getTransactions(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Ops! houve um erro');
                    } else if (snapshot.hasData) {
                      return Wrap(
                        runSpacing: 20,
                        children: snapshot.data!
                            .map((transac) => CardTransaction(
                                  dateTransaction: transac.dtTransacao,
                                  typeTransaction:
                                      _verifyTransactionType(transac.tipo),
                                  valueTransaction:
                                      moneyFormat.format(transac.valor),
                                  positive: _verifyTransactionPositive(transac),
                                ))
                            .toList(),
                      );
                    } else {
                      return const Text('Nenhuma transação registrada');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

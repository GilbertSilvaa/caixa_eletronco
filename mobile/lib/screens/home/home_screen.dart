import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/transaction.dart';
import 'package:mobile/screens/home/operations.dart';
import 'package:mobile/screens/home/transactions.dart';
import '../../http/dio_client.dart';
import '../../models/cliente.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.cliente});

  final Cliente cliente;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Dio _dio;
  late List<Transaction> _transactions;
  var _sectionSelected = 0;

  void _changeSection(int index) {
    setState(() => _sectionSelected = index);
  }

  void _getTransactions() async {
    try {
      var res = await _dio.get('/Transacao/buscar?idCliente=8');

      if (res.statusCode == 200) {
        _transactions =
            res.data.map<Transaction>((tr) => Transaction.fromMap(tr)).toList();
      }
    } on DioException catch (_) {
      debugPrint('erro na requisicao');
    }
  }

  @override
  void initState() {
    Future(() async {
      _dio = await DioClient.getInstance();
      _getTransactions();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 75),
            const Text(
              'Saldo',
              style: TextStyle(fontSize: 24, color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Text(
              'R\$ ${widget.cliente.saldo.toString()}',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24),
                  ),
                ),
                child: _sectionSelected == 0
                    ? const Operations()
                    : Transactions(transactions: _transactions),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          onTap: _changeSection,
          currentIndex: _sectionSelected,
          selectedItemColor: Colors.red,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home, size: 30),
            ),
            BottomNavigationBarItem(
              label: 'Transações',
              icon: Icon(
                Icons.list_alt,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/http/dio_client.dart';
import 'package:mobile/screens/home/operations.dart';
import 'package:mobile/screens/home/transactions.dart';
import 'package:mobile/screens/login_screen.dart';
import '../../models/cliente.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.cliente});

  final Cliente cliente;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _sectionSelected = 0;

  void _changeSection(int index) {
    if (index == 2) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        ModalRoute.withName('/'),
      );
      return;
    }

    setState(() => _sectionSelected = index);
  }

  Future<Cliente> _getBalance() async {
    try {
      var dio = await DioClient.getInstance();
      var res = await dio
          .get('/Cliente/buscarPorConta?conta=${widget.cliente.conta}');

      if (res.statusCode == 200) {
        return Cliente.fromMap(res.data);
      }
    } on DioException catch (_) {
      debugPrint('erro na requisicao');
    }

    return widget.cliente;
  }

  Widget? getSection(int index) {
    switch (index) {
      case 0:
        return Operations(cliente: widget.cliente);
      case 1:
        return Transactions(cliente: widget.cliente);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var moneyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

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
            FutureBuilder(
              future: _getBalance(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return Text(
                  moneyFormat.format(snapshot.data!.saldo),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                );
              },
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
                child: getSection(_sectionSelected),
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
            BottomNavigationBarItem(
              label: 'Sair',
              icon: Icon(
                Icons.logout,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

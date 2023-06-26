import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/http/dio_client.dart';
import 'package:mobile/models/cliente.dart';
import 'package:mobile/screens/home/home_screen.dart';
import 'package:mobile/widgets/button.dart';
import 'package:mobile/widgets/input.dart';

class Deposit extends StatefulWidget {
  const Deposit({
    super.key,
    required this.cliente,
  });

  final Cliente cliente;

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  late Dio _dio;
  final _valueController = TextEditingController();
  bool _formLoading = false;
  String? _valueError;

  bool _validateForm() {
    setState(() => _valueError = null);
    if (_valueController.text.isEmpty) {
      setState(() => _valueError = 'campo obrigatório');
      return false;
    }
    return true;
  }

  void _sendForm() async {
    if (!_validateForm()) return;

    try {
      setState(() => _formLoading = true);
      var params = {
        'idCliente': widget.cliente.id,
        'valor': num.parse(_valueController.text)
      };
      var response = await _dio.post('/Transacao/deposito', data: params);

      if (response.statusCode == 200) {
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(cliente: widget.cliente),
            ),
            ModalRoute.withName('/'),
          );
        }
      }
    } on DioException catch (_) {
      setState(() => _valueError = 'saldo insuficiente');
    } finally {
      setState(() => _formLoading = false);
    }
  }

  @override
  void initState() {
    DioClient.getInstance().then((instance) => _dio = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Input(
            label: 'Valor',
            hintText: 'R\$ 99.99',
            keyBoard: TextInputType.number,
            controller: _valueController,
            errorLabel: _valueError,
          ),
          const SizedBox(height: 28),
          Expanded(
            child: Container(),
          ),
          Button(
            title: 'Depositar',
            handleOnClick: _sendForm,
            isLoading: _formLoading,
          )
        ],
      ),
    );
  }
}

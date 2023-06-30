import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/http/dio_client.dart';
import 'package:mobile/models/cliente.dart';
import 'package:mobile/screens/home/home_screen.dart';
import 'package:mobile/widgets/button.dart';
import 'package:mobile/widgets/input.dart';
import 'package:mobile/widgets/success.dart';

class Withdrawal extends StatefulWidget {
  const Withdrawal({super.key, required this.cliente});

  final Cliente cliente;

  @override
  State<Withdrawal> createState() => _WithdrawalState();
}

class _WithdrawalState extends State<Withdrawal> {
  late Dio _dio;
  final _valueController = TextEditingController();
  bool _formLoading = false;
  String? _valueError;

  bool _validateForm() {
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
      var response = await _dio.post('/transacao/saque', data: params);

      if (response.statusCode == 200) {
        if (context.mounted) {
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Success(cliente: widget.cliente),
              ),
            );
          }
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
            handleOnChange: (v) => setState(() => _valueError = null),
          ),
          const SizedBox(height: 28),
          Expanded(
            child: Container(),
          ),
          Button(
            title: 'Sacar',
            handleOnClick: _sendForm,
            isLoading: _formLoading,
          )
        ],
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/http/dio_client.dart';
import 'package:mobile/models/cliente.dart';
import 'package:mobile/screens/home/home_screen.dart';
import 'package:mobile/widgets/button.dart';
import 'package:mobile/widgets/input.dart';
import 'package:mobile/widgets/success.dart';

class Transfer extends StatefulWidget {
  const Transfer({super.key, required this.cliente});

  final Cliente cliente;

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  late Dio _dio;
  final _valueController = TextEditingController();
  final _accountController = TextEditingController();
  String? _valueError;
  String? _accountError;
  bool _formLoading = false;

  bool _validateForm() {
    if (_accountController.text.isEmpty) {
      setState(() => _accountError = 'campo obrigatório');
      return false;
    }
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
      var account = num.parse(_accountController.text);

      var responseCli =
          await _dio.get('/Cliente/buscarPorConta?conta=$account');
      Cliente clientTranf = Cliente.fromMap(responseCli.data);

      if (responseCli.statusCode == 200) {
        if (context.mounted) {
          showAlertDialog(context, clientTranf);
        }
      }
    } on DioException catch (error) {
      setState(() => _accountError = error.response.toString());
    } finally {
      setState(() => _formLoading = false);
    }
  }

  void _sendTransfer(Cliente cliente) async {
    try {
      setState(() => _formLoading = true);
      var params = {
        'idCliente': widget.cliente.id,
        'idClienteTransf': cliente.id,
        'valor': num.parse(_valueController.text)
      };

      var responseTrasac =
          await _dio.post('/Transacao/transferencia', data: params);

      if (responseTrasac.statusCode == 200) {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Success(cliente: widget.cliente),
            ),
          );
        }
      }
    } on DioException catch (error) {
      setState(() => _accountError = error.response.toString());
    } finally {
      setState(() => _formLoading = false);
    }
  }

  showAlertDialog(BuildContext context, Cliente cliente) {
    Widget cancelButton = TextButton(
      child: const Text('Cancelar'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        'Confirmar',
        style: TextStyle(color: Colors.green),
      ),
      onPressed: () {
        _sendTransfer(cliente);
      },
    );

    AlertDialog alert = AlertDialog(
      content: Text('Realizar Transferência para ${cliente.nome} ?'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
            label: 'Conta',
            hintText: 'xxxx xxxx xxxx xxxx',
            keyBoard: TextInputType.number,
            controller: _accountController,
            errorLabel: _accountError,
            handleOnChange: (v) => setState(() => _accountError = null),
          ),
          const SizedBox(height: 25),
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
            title: 'Transferir',
            handleOnClick: _sendForm,
            isLoading: _formLoading,
          )
        ],
      ),
    );
  }
}

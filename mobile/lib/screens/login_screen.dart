import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/http/dio_client.dart';
import 'package:mobile/models/cliente.dart';
import 'package:mobile/screens/home/home_screen.dart';
import 'package:mobile/widgets/button.dart';
import 'package:mobile/widgets/input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Dio _dio;
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _formLoading = false;
  String? _accountError;
  String? _passwordError;

  bool validationForm() {
    if (_accountController.text.isEmpty) {
      setState(() => _accountError = 'campo obrigatório');
      return false;
    }
    if (_passwordController.text.isEmpty) {
      setState(() => _passwordError = 'campo obrigatório');
      return false;
    }
    return true;
  }

  void sendForm() async {
    if (!validationForm()) return;

    try {
      setState(() => _formLoading = true);
      var params = {
        'conta': int.parse(_accountController.text),
        'senha': _passwordController.text
      };
      var response = await _dio.post('/cliente/login', data: params);

      if (response.statusCode == 200) {
        var cliente = Cliente.fromMap(response.data);

        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(cliente: cliente),
            ),
          );
        }
      }
    } on DioException catch (_) {
      setState(() => _accountError = 'conta ou senha incorreta');
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
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/images/bank_icon.png')),
              const SizedBox(height: 52),
              Input(
                label: 'Conta',
                hintText: 'xxxx xxxx xxxx xxxxx',
                keyBoard: TextInputType.number,
                controller: _accountController,
                errorLabel: _accountError,
                handleOnChange: (_) => setState(() => _accountError = null),
              ),
              const SizedBox(height: 16),
              Input(
                label: 'Senha',
                hintText: 'informe sua senha',
                isPassword: true,
                controller: _passwordController,
                errorLabel: _passwordError,
                handleOnChange: (_) => setState(() => _passwordError = null),
              ),
              const SizedBox(height: 36),
              Button(
                title: 'Entrar',
                isLoading: _formLoading,
                handleOnClick: sendForm,
              )
            ],
          ),
        ),
      ),
    );
  }
}

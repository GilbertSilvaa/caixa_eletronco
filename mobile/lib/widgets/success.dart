import 'package:flutter/material.dart';
import 'package:mobile/models/cliente.dart';
import 'package:mobile/screens/home/home_screen.dart';
import 'package:mobile/widgets/button.dart';

class Success extends StatelessWidget {
  const Success({super.key, required this.cliente});

  final Cliente cliente;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Icon(
                Icons.task_alt,
                size: MediaQuery.of(context).size.width * 0.3,
                color: Colors.red,
              ),
              const SizedBox(height: 30),
              const Text(
                'Realizado com sucesso',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
              Expanded(child: Container()),
              Button(
                title: 'Prosseguir',
                handleOnClick: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(cliente: cliente),
                    ),
                    ModalRoute.withName('/'),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

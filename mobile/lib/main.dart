import 'package:flutter/material.dart';
import 'package:mobile/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Color.fromARGB(29, 154, 154, 154),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 2.5, color: Color(0xFF4E4E4E)),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2.5, color: Color(0xFF646464)),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2.5, color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

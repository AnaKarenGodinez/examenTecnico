import 'package:flutter/material.dart';
import 'screens/RegisterScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autenticación Web',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RegisterScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

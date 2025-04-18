import 'package:flutter/material.dart';

class UploadFile extends StatelessWidget {
  const UploadFile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cargar Archivos')),
      body: const Center(
        child: Text('Aquí puedes cargar archivos'),
      ),
    );
  }
}


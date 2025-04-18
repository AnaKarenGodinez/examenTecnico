import 'package:flutter/material.dart';
import 'package:web_auth_app/screens/Employees.dart';
import 'package:web_auth_app/screens/Services.dart';
import 'package:web_auth_app/screens/UploadFile.dart';
import 'package:web_auth_app/screens/colaborador.dart';

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla Principal')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 190, 159, 71),
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            
            ListTile(
              title: const Text('Cargar Archivos'),
              onTap: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UploadFile()),
                );
              },
            ),
            ListTile(
              title: const Text('Colaborador'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Colaborador()),
                );
              },
            ),
            ListTile(
              title: const Text('Empleados'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Employees()),
                );
              },
            ),
            ListTile(
              title: const Text('Servicios'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Services()),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          '¡Bienvenido!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

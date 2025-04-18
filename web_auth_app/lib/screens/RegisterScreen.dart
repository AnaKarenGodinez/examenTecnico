import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'Login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final rfcController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

String? validateRFC(String? value) {
  final rfcRegExp = RegExp(r'^([A-ZÑ&]{3,4})[0-9]{6}[A-Z0-9]{3}$');
  if (value == null || value.isEmpty) return 'Campo requerido';
  if (!rfcRegExp.hasMatch(value)) return 'RFC inválido';
  return null;
}

Future<void> registrarUsuario(String nombre, String correo, String rfc, String password) async {
  final url = Uri.parse('http://localhost:3000/api/register');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': nombre,
        'correo': correo,
        'rfc': rfc,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('Usuario registrado');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } else {
      final data = jsonDecode(response.body);
      print('Error en el registro: ${data['error']}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${data['error']}')),
      );
    }
  } catch (e) {
    print('❌ Error de red: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error de conexión con el servidor')),
    );
  }
}

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      registrarUsuario(
      nameController.text,
      emailController.text,
      rfcController.text,
      passwordController.text,
    );
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField('Nombre', nameController),
              buildTextField('Correo electrónico', emailController, keyboardType: TextInputType.emailAddress),
              buildTextField('RFC', rfcController, validator: validateRFC),
              buildTextField('Contraseña', passwordController, isPassword: true),
              buildTextField(
                'Confirmar contraseña',
                confirmPasswordController,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo requerido';
                  if (value != passwordController.text) return 'Las contraseñas no coinciden';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Registrarse'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()), // Redirige a la pantalla de login
                  );
                },
                child: const Text(
                  '¿Ya tienes cuenta? Inicia sesión',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    bool isPassword = false,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Campo requerido';
              }
              return null;
            },
      ),
    );
  }
}

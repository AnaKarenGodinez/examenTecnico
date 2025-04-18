import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:web_auth_app/screens/Colaborador.dart';


class Employees extends StatefulWidget {
  const Employees({super.key});

  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  List colaboradores = [];
  List colaboradoresFiltrados = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    fetchColaboradores();
  }

  Future<void> fetchColaboradores() async {
    final url = Uri.parse('http://localhost:3000/api/colaborador');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        colaboradores = data;
        colaboradoresFiltrados = data;
      });
    }
  }

  void filtrar(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      colaboradoresFiltrados = colaboradores.where((col) {
        return col['nombre'].toLowerCase().contains(searchQuery) ||
              col['rfc'].toLowerCase().contains(searchQuery) ||
              col['curp'].toLowerCase().contains(searchQuery) ||
              col['fecha_inicio_laboral'].contains(searchQuery);
      }).toList();
    });
  }

  void eliminarColaborador(int id) async {
    final url = Uri.parse('http://localhost:3000/api/colaborador/$id');
    await http.delete(url);
    fetchColaboradores();
  }

String _formatearFecha(String fecha) {
  try {
    final date = DateTime.parse(fecha);
    return DateFormat('yyyy-MM-dd').format(date);
  } catch (e) {
    return fecha;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Empleados')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar por nombre, RFC, CURP o fecha',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: filtrar,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: colaboradoresFiltrados.length,
              itemBuilder: (context, index) {
                final col = colaboradoresFiltrados[index];
                return Card(
                  child: ListTile(
                    title: Text(col['nombre']),
                    subtitle: Text('RFC: ${col['rfc']} | CURP: ${col['curp']}\nFecha Inicio Laboral: ${_formatearFecha(col['fecha_inicio_laboral'])}'),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Colaborador(colaborador: col),
                              ),
                            ).then((_) => fetchColaboradores());
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Confirmar eliminación'),
                                content: Text('¿Deseas eliminar al colaborador "${col['nombre']}"?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, false),
                                    child: const Text('Cancelar'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(context, true),
                                      child: const Text('Eliminar'),
                                    ),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              eliminarColaborador(col['id']);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

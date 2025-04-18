import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Services extends StatefulWidget {
  const Services({super.key});

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  List<dynamic> publicaciones = [];

  Future<void> cargarPublicaciones() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      setState(() {
        publicaciones = json.decode(response.body);
      });
    } else {
      throw Exception('Error al cargar las publicaciones');
    }
  }

  @override
  void initState() {
    super.initState();
    cargarPublicaciones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Servicios')),
      body: ListView.builder(
        itemCount: publicaciones.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(publicaciones[index]['title']),
            subtitle: Text(publicaciones[index]['body']),
            onTap: () => _editarPublicacion(publicaciones[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _eliminarPublicacion(publicaciones[index]['id']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _crearPublicacion,
        child: Icon(Icons.add),
      ),
    );
  }

  void _crearPublicacion() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Crear Publicación'),
        content: CrearPublicacionDialog(onCrear: (title, body) {
          _agregarPublicacion(title, body);
        }),
      ),
    );
  }

  Future<void> _agregarPublicacion(String title, String body) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': title, 'body': body, 'userId': 1}),
    );

    if (response.statusCode == 201) {
      final newPost = json.decode(response.body);
      setState(() {
        publicaciones.insert(0, newPost);
      });
    }
  }

  void _editarPublicacion(Map<String, dynamic> publicacion) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Publicación'),
        content: CrearPublicacionDialog(
          title: publicacion['title'],
          body: publicacion['body'],
          onCrear: (title, body) {
            _actualizarPublicacion(publicacion['id'], title, body);
          },
        ),
      ),
    );
  }

  Future<void> _actualizarPublicacion(int id, String title, String body) async {
    final response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': title, 'body': body, 'userId': 1}),
    );

    if (response.statusCode == 200) {
      final updatedPost = json.decode(response.body);
      setState(() {
        final index = publicaciones.indexWhere((p) => p['id'] == id);
        publicaciones[index] = updatedPost;
      });
    }
  }

  Future<void> _eliminarPublicacion(int id) async {
    final response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
    );

    if (response.statusCode == 200) {
      setState(() {
        publicaciones.removeWhere((p) => p['id'] == id);
      });
    }
  }
}

class CrearPublicacionDialog extends StatefulWidget {
  final String? title;
  final String? body;
  final Function(String, String) onCrear;

  CrearPublicacionDialog({this.title, this.body, required this.onCrear});

  @override
  _CrearPublicacionDialogState createState() => _CrearPublicacionDialogState();
}

class _CrearPublicacionDialogState extends State<CrearPublicacionDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _bodyController = TextEditingController(text: widget.body);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Título'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El título es obligatorio';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _bodyController,
            decoration: InputDecoration(labelText: 'Contenido'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El contenido es obligatorio';
              }
              return null;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    widget.onCrear(_titleController.text, _bodyController.text);
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


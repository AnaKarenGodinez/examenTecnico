import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class Colaborador extends StatefulWidget {
  final Map<String, dynamic>? colaborador;

  const Colaborador({super.key, this.colaborador});

  @override
  State<Colaborador> createState() => _ColaboradorState();
}

class _ColaboradorState extends State<Colaborador> {
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final correoController = TextEditingController();
  final rfcController = TextEditingController();
  final domicilioController = TextEditingController();
  final curpController = TextEditingController();
  final nssController = TextEditingController();
  final fechaInicioController = TextEditingController();
  final tipoContratoController = TextEditingController();
  final departamentoController = TextEditingController();
  final puestoController = TextEditingController();
  final salarioDiarioController = TextEditingController();
  final salarioController = TextEditingController();
  final claveEntidadController = TextEditingController();
  String? selectedEstado;

  final estadosMexicos = [
    "Aguascalientes", "Baja California", "Baja California Sur", "Campeche", "Chiapas", "Chihuahua","Ciudad de México", "Coahuila", "Colima", "Durango", "Guanajuato", 
    "Guerrero", "Hidalgo", "Jalisco", "Estado de México", "Michoacán", "Morelos", "Nayarit", "Nuevo León", "Oaxaca", "Puebla", "Querétaro", "Quintana Roo", 
    "San Luis Potosí", "Sinaloa", "Sonora", "Tabasco", "Tamaulipas", "Tlaxcala", "Veracruz", "Yucatán", "Zacatecas"
  ];

@override
void initState() {
  super.initState();

  if (widget.colaborador != null) {
    final c = widget.colaborador!;
    nombreController.text = c['nombre'] ?? '';
    correoController.text = c['correo'] ?? '';
    rfcController.text = c['rfc'] ?? '';
    domicilioController.text = c['domicilio_fiscal'] ?? '';
    curpController.text = c['curp'] ?? '';
    nssController.text = c['nss'] ?? '';

    String fechaInicio = c['fecha_inicio_laboral'] ?? '';
    if (fechaInicio.isNotEmpty) {
      DateTime parsedDate = DateTime.parse(fechaInicio);
      String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
      fechaInicioController.text = formattedDate;
    } else {
      fechaInicioController.text = ''; 
    }

    tipoContratoController.text = c['tipo_contrato'] ?? '';
    departamentoController.text = c['departamento'] ?? '';
    puestoController.text = c['puesto'] ?? '';
    salarioDiarioController.text = c['salario_diario']?.toString() ?? '';
    salarioController.text = c['salario']?.toString() ?? '';
    claveEntidadController.text = c['clave_entidad'] ?? '';
    selectedEstado = c['estado'];
  }
}

  Future<void> guardarColaborador() async {
  final esEdicion = widget.colaborador != null;
  final url = esEdicion
      ? Uri.parse('http://localhost:3000/api/colaborador/${widget.colaborador!['id']}')
      : Uri.parse('http://localhost:3000/api/colaborador');

  final response = await (esEdicion
      ? http.put(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'nombre': nombreController.text,
            'correo': correoController.text,
            'rfc': rfcController.text,
            'domicilioFiscal': domicilioController.text,
            'curp': curpController.text,
            'nss': nssController.text,
            'fechaInicioLaboral': fechaInicioController.text,
            'tipoContrato': tipoContratoController.text,
            'departamento': departamentoController.text,
            'puesto': puestoController.text,
            'salarioDiario': salarioDiarioController.text,
            'salario': salarioController.text,
            'claveEntidad': claveEntidadController.text,
            'estado': selectedEstado,
          }))
      : http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'nombre': nombreController.text,
            'correo': correoController.text,
            'rfc': rfcController.text,
            'domicilioFiscal': domicilioController.text,
            'curp': curpController.text,
            'nss': nssController.text,
            'fechaInicioLaboral': fechaInicioController.text,
            'tipoContrato': tipoContratoController.text,
            'departamento': departamentoController.text,
            'puesto': puestoController.text,
            'salarioDiario': salarioDiarioController.text,
            'salario': salarioController.text,
            'claveEntidad': claveEntidadController.text,
            'estado': selectedEstado,
          })));

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(esEdicion ? 'Cambios guardados correctamente' : 'Colaborador guardado exitosamente')),
    );

    if (!esEdicion) {
      //si fue nuevo registro
      nombreController.clear();
      correoController.clear();
      rfcController.clear();
      domicilioController.clear();
      curpController.clear();
      nssController.clear();
      fechaInicioController.clear();
      tipoContratoController.clear();
      departamentoController.clear();
      puestoController.clear();
      salarioDiarioController.clear();
      salarioController.clear();
      claveEntidadController.clear();
      setState(() {
        selectedEstado = null;
      });
    } else {
      Navigator.pop(context, true);
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error al guardar el colaborador')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Colaborador')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField('Nombre', nombreController),
              buildTextField('Correo', correoController, keyboardType: TextInputType.emailAddress),
              buildTextField('RFC', rfcController),
              buildTextField('Domicilio Fiscal', domicilioController),
              buildTextField('CURP', curpController),
              buildTextField('Número de Seguro Social', nssController),
              buildTextField('Fecha de Inicio Laboral (yyyy-mm-dd)', fechaInicioController, keyboardType: TextInputType.datetime),
              buildTextField('Tipo de Contrato', tipoContratoController),
              buildTextField('Departamento', departamentoController),
              buildTextField('Puesto', puestoController),
              buildTextField('Salario Diario', salarioDiarioController, keyboardType: TextInputType.number),
              buildTextField('Salario', salarioController, keyboardType: TextInputType.number),
              buildTextField('Clave Entidad', claveEntidadController),
              DropdownButtonFormField<String>(
                value: selectedEstado,
                decoration: InputDecoration(labelText: 'Estado'),
                onChanged: (newValue) {
                  setState(() {
                    selectedEstado = newValue!;
                  });
                },
                items: estadosMexicos.map((estado) {
                  return DropdownMenuItem(
                    value: estado,
                    child: Text(estado),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    guardarColaborador();
                  }
                },
                child: Text(widget.colaborador != null ? 'Guardar Cambios' : 'Guardar Colaborador'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo requerido';
        }
        return null;
      },
    );
  }
}

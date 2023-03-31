import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:asistente_virtual/src/api/enviroment.dart';
import 'package:flutter/material.dart';

class CatMateriaProvider {
  //URL de la api
  final String _url = Enviroment.api;

  BuildContext? context;

  Future? init(BuildContext context) {
    this.context = context;
  }

  //respuesta de la solicitud materia especifica
  Future<Map<String, dynamic>> oneMateria(String name) async {
  try {
    // URL para el get
    Uri url = Uri.https(_url, '/materias/$name');

    // Petición GET de login
    final res = await http.get(url);

    // Obtener la respuesta como JSON
    final data = json.decode(res.body);

    // Imprimir la respuesta en la consola
    print(data);

    // Convertir la respuesta JSON en un Map<String, dynamic>
    return data as Map<String, dynamic>;
  } catch (e) {
    print('Error: $e');
    return null!;
    }
  }

  //respuesta de la solicitud todas las materias
  Future<List<dynamic>> allMaterias() async {
  try {
    // URL para el get
    Uri url = Uri.https(_url, '/materias');

    // Petición GET de login
    final res = await http.get(url);

    // Obtener la respuesta como JSON
    final data = json.decode(res.body);

    // Imprimir la respuesta en la consola
    print(data);

    // Convertir la respuesta JSON en un Map<String, dynamic>
    return data as List<dynamic>;
  } catch (e) {
    print('Error: $e');
    return null!;
    }
  }
}

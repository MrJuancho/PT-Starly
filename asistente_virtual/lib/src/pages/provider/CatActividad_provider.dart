import 'dart:convert';
import 'package:asistente_virtual/src/api/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CatActividadesProvider {
  //URL de la api
  final String _url = Enviroment.api;

  BuildContext? context;

  Future? init(BuildContext context) {
    this.context = context;
  }

  //respuesta de las solicitudes
  Future<Map<String, dynamic>> oneActividad(String user) async {
  try {
    // URL para el get
    Uri url = Uri.https(_url, '/actividades/$user');

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

  Future<List<dynamic>> allActividades() async {
  try {
    // URL para el get
    Uri url = Uri.https(_url, '/actividades');

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

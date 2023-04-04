import 'dart:convert';
import 'package:asistente_virtual/src/api/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CatDatoCuriosoProvider {
  //URL de la api
  final String _url = Enviroment.api;

  BuildContext? context;

  Future? init(BuildContext context) {
    this.context = context;
  }

  //respuesta de las solicitudes
  Future<String> oneDatoCurioso(int idDatoCurioso) async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/datoCurioso/$idDatoCurioso');

      // Petición GET de login
      final res = await http.get(url);

      // Obtener la respuesta como JSON
      final data = json.decode(res.body);
      final frase = data["descripcionDatos"];
      // Imprimir la respuesta en la consola
      print(frase);

      // Convertir la respuesta JSON en un Map<String, dynamic>
      return frase;
    } catch (e) {
      print('Error: $e');
      return null!;
    }
  }

  Future<List<dynamic>> allDatosCuriosos() async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/datoCurioso');

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

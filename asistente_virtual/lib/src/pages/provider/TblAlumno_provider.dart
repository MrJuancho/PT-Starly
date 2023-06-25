// ignore_for_file: null_check_always_fails, unnecessary_null_comparison, file_names

import 'dart:convert';
import 'package:asistente_virtual/src/api/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TblAlumnoProvider {
  //URL de la api
  final String _url = Enviroment.api;

  BuildContext? context;

  Future<void> init(BuildContext context) async {
    this.context = context;
  }

  void dispose(){
  }

  //respuesta de las solicitudes
  Future<Map<String, dynamic>> login(String user) async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/alumno/$user');

      // Petición GET de login
      final res = await http.get(url);

      // Obtener la respuesta como JSON
      final data = json.decode(res.body);

      // Imprimir la respuesta en la consola
      //print(data);

      // Convertir la respuesta JSON en un Map<String, dynamic>
      return data as Map<String, dynamic>;
    } catch (e) {
      //print('Error: $e');
      return {};
    }
  }

  Future<List<dynamic>> allAlumnos() async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/alumno');

      // Petición GET de todos los alumnos existentes
      final res = await http.get(url);

      // Obtener la respuesta como JSON
      final data = json.decode(res.body);

      // Imprimir la respuesta en la consola
      //print(data);

      // Convertir la respuesta JSON en un Map<String, dynamic>
      return data as List<dynamic>;
    } catch (e) {
      //print('Error: $e');
      return [];
    }
  }

  void putMonedasEstrellas(String username, int monedas, int estrellas) async {
    try {
      if (estrellas == 0 || estrellas == null) {
        estrellas = 0;
      } else if (monedas == 0 || monedas == null) {
        monedas = 0;
      }
      Map<String, dynamic> datos = {'username': username, 'monedas': monedas, 'estrellas': estrellas};
      String body = jsonEncode(datos);
      // URL para el get
      Uri url = Uri.https(_url, '/alumno/$username');

      // Petición POST de settear monedas y/o estrellas
      await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
    } catch (e) {
      //print("Error: $e");
    }
  }
}

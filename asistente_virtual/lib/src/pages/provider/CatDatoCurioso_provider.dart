// ignore_for_file: null_check_always_fails

import 'dart:convert';
import 'package:asistente_virtual/src/api/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CatDatoCuriosoProvider {
  //URL de la api
  final String _url = Enviroment.api;

  BuildContext? context;

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

  Future<List<Map<String, dynamic>>> datoCuriosobyContenido(int idDatoCurioso) async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/datoCuriosoContenido/$idDatoCurioso');

      // Petición GET de login
      final res = await http.get(url);

      // Obtener la respuesta como JSON
      final data = json.decode(res.body);

      // Convertir la respuesta JSON en una lista de Map<String, dynamic>
      List<Map<String, dynamic>> datosCuriosos = List<Map<String, dynamic>>.from(data);

      // Imprimir la respuesta en la consola
      print(datosCuriosos);

      return datosCuriosos;
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

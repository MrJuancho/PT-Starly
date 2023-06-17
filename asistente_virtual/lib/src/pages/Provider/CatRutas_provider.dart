// ignore_for_file: null_check_always_fails, file_names

import 'dart:convert';
import 'package:asistente_virtual/src/api/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CatRutasProvider {
  //URL de la api
  final String _url = Enviroment.api;

  BuildContext? context;

  //respuesta de las solicitudes
  Future<Map<String, dynamic>> oneRuta(int id) async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/rutas/$id');

      // Petición GET de login
      final res = await http.get(url);

      // Obtener la respuesta como JSON
      final data = json.decode(res.body);

      // Convertir la respuesta JSON en un Map<String, dynamic>
      return data as Map<String, dynamic>;
    } catch (e) {
      //print('Error: $e');
      return null!;
    }
  }

  Future<String> onlyRuta(int id) async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/rutas/$id');

      // Petición GET de login
      final res = await http.get(url);

      // Obtener la respuesta como JSON
      Map<String, dynamic> data = json.decode(res.body);
      String ruta = data['rutas'];
      // Convertir la respuesta JSON en un Map<String, dynamic>
      return ruta;
    } catch (e) {
      //print('Error: $e');
      return null!;
    }
  }

  Future<List<dynamic>> allRutas() async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/rutas');

      // Petición GET de login
      final res = await http.get(url);

      // Obtener la respuesta como JSON
      final data = json.decode(res.body);

      // Imprimir la respuesta en la consola
      //print(data);

      // Convertir la respuesta JSON en un Map<String, dynamic>
      return data as List<dynamic>;
    } catch (e) {
      //print('Error: $e');
      return null!;
    }
  }
}

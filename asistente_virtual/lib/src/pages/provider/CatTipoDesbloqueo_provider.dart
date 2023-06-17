// ignore_for_file: null_check_always_fails, file_names

import 'dart:convert';
import 'package:asistente_virtual/src/api/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CatTipoDesbloqueoProvider {
  //URL de la api
  final String _url = Enviroment.api;

  BuildContext? context;

  //respuesta de las solicitudes
  Future<String> oneTipoDesbloqueo(String user) async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/tiposDesbloqueo/$user');

      // Petición GET de login
      final res = await http.get(url);

      // Obtener la respuesta como JSON
      final data = json.decode(res.body);

      final desbloqueo = data['descTipoDebloqueo'];
      // Imprimir la respuesta en la consola
      //print(desbloqueo);

      // Convertir la respuesta JSON en un Map<String, dynamic>
      return desbloqueo;
    } catch (e) {
      //print('Error: $e');
      return null!;
    }
  }

  Future<List<dynamic>> allTiposDesbloqueo() async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/tiposDesbloqueo');

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

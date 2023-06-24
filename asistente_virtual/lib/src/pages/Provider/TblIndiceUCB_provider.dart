// ignore_for_file: null_check_always_fails, unnecessary_null_comparison, file_names

import 'dart:convert';
import 'package:asistente_virtual/src/api/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TblIndiceUCBProvider {
  //URL de la api
  final String _url = Enviroment.api;

  BuildContext? context;

  Future? init(BuildContext context) async {
    this.context = context;
  }

  //respuesta de las solicitudes
  Future<List<dynamic>> indices(int idAlumno) async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/indiceUCB/$idAlumno');

      // Petición GET de login
      final res = await http.get(url);

      // Obtener la respuesta como JSON
      final data = json.decode(res.body);

      // Imprimir la respuesta en la consola
      //print(data);

      // Convertir la respuesta JSON en un Map<String, dynamic>
      return data;
    } catch (e) {
      //print('Error: $e');
      return null!;
    }
  }

}

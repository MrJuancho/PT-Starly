// ignore_for_file: null_check_always_fails, file_names

import 'dart:convert';
import 'package:asistente_virtual/src/api/enviroment.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TblSeleccionAVProvider {
  //URL de la api
  final String _url = Enviroment.api;

  BuildContext? context;

  //respuesta de las solicitudes
  Future<Map<String, dynamic>> selectedAV(int idAlumno) async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/seleccionAV/$idAlumno');

      // Petición GET de login
      final res = await http.get(url);

      // Obtener la respuesta como JSON
      final data = json.decode(res.body);

      // Imprimir la respuesta en la consola
      if (kDebugMode) {
        print(data);
      }

      // Convertir la respuesta JSON en un Map<String, dynamic>
      return data as Map<String, dynamic>;
    } catch (e) {
      ////print('Error: $e');
      return null!;
    }
  }

  void putNewAVselected(int idAlumno, int idAV) async {
    try {
      Map<String, dynamic> datos = {"idAlumno": idAlumno, "idAV": idAV};
      String body = jsonEncode(datos);
      if (kDebugMode) {
        print(datos);
      }
      // URL para el get
      Uri url = Uri.https(_url, '/seleccionAV/$idAlumno');

      // Petición POST de settear asistente
      await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }
}

// ignore_for_file: null_check_always_fails, file_names

import 'dart:convert';
import 'package:asistente_virtual/src/api/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TblResultadosActividadProvider {
  //URL de la api
  final String _url = Enviroment.api;

  BuildContext? context;

  //respuesta de las solicitudes
  Future<Map<String, dynamic>> oneresultadoActividad(int idActividad) async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/resultadoActividad/$idActividad');

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
      return null!;
    }
  }

  void postResultadoActividad(int idActividad, int idAlumno, String tiempo, int intentos, int asistencias) async {
    DateTime currentdatetime = DateTime.now().toLocal();
    try {
      Map<String, dynamic> datos = {
        'idActividad': idActividad,
        'idAlumno': idAlumno,
        'tiempoResolucion': tiempo,
        'intentos': intentos,
        'asistencias': asistencias,
        'fecha': currentdatetime.toString()
      };
      String body = jsonEncode(datos);
      // URL para el get
      Uri url = Uri.https(_url, '/resultadoActividad');

      // Petición POST de settear monedas y/o estrellas
      await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
    } catch (e) {
      //print("Error: $e");
    }
  }
}

// ignore_for_file: null_check_always_fails, file_names

import 'dart:convert';
import 'package:asistente_virtual/src/api/enviroment.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TblAlumnoAVProvider {
  //URL de la api
  final String _url = Enviroment.api;

  BuildContext? context;

  //respuesta de las solicitudes
  Future<List<dynamic>> allAVsAdquiered(int idAlumno) async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/alumnoAV/$idAlumno');

      // Petición GET de login
      final res = await http.get(url);

      // Obtener la respuesta como JSON
      final data = json.decode(res.body);

      // Convertir la respuesta JSON en un Map<String, dynamic>
      return data as List<dynamic>;
    } catch (e) {
      ////print('Error: $e');
      return null!;
    }
  }

  void postNewAVacquired(int idAlumno, int idAV) async {
    DateTime currentdatetime = DateTime.now().toLocal();
    String fechaString = DateFormat('yyyy-MM-dd').format(currentdatetime);
    try {
      Map<String, dynamic> datos = {"idAlumno": idAlumno, "idAv": idAV, "FechaDesbloqueo": fechaString};
      String body = jsonEncode(datos);
      if (kDebugMode) {
        print(datos);
      }
      // URL para el get
      Uri url = Uri.https(_url, '/alumnoAV');

      // Petición POST de settear monedas y/o estrellas
      await http.post(url,
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

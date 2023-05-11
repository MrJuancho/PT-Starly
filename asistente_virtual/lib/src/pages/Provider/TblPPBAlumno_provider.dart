import 'dart:convert';
import 'package:asistente_virtual/src/api/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TblAlumnoPPBProvider {
  //URL de la api
  final String _url = Enviroment.api;

  BuildContext? context;

  //No esta terminada
  /* void putPPBAlumno(String username, int atencion, int memoria,int percepcion) async {
    try {
      if (atencion == 0 || atencion == null) {
        atencion = 0;
      } else if (memoria == 0 || memoria == null) {
        memoria = 0;
      }
      Map<String, dynamic> datos = {
        'username': username,
        'monedas': monedas,
        'estrellas': estrellas
      };
      String body = jsonEncode(datos);
      // URL para el get
      Uri url = Uri.https(_url, '/alumnoppb/$username');

      // Petición POST de settear monedas y/o estrellas
      await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
    } catch (e) {
      print("Error: $e");
    }
  } */
}

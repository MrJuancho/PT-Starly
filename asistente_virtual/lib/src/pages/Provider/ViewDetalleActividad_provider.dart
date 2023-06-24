// ignore_for_file: null_check_always_fails, file_names

import 'dart:convert';
import 'package:asistente_virtual/src/api/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewDetalleActividadProvider {
  //URL de la api
  final String _url = Enviroment.api;

  BuildContext? context;

  //respuesta de las solicitudes
  Future<Map<String, dynamic>> onlyInfo(int id) async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/detalleActividad/$id');

      // Petición GET de login
      final res = await http.get(url);

      // Obtener la respuesta como JSON
      Map<String, dynamic> data = json.decode(res.body);
      String actividad = data['NombreActividad'];
      String descripcion = data['Descripcion'];
      Map<String, dynamic> info = {'NombreActividad': actividad, 'Descripcion': descripcion};
      // Convertir la respuesta JSON en un Map<String, dynamic>
      return info;
    } catch (e) {
      //print('Error: $e');
      return null!;
    }
  }

  Future<List<dynamic>> allDetalles() async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/detalleActividad');

      // Petición GET de login
      final res = await http.get(url);

      // Obtener la respuesta como JSON
      List<dynamic> data = json.decode(res.body);

      // Imprimir la respuesta en la consola
      //print(data);

      // Convertir la respuesta JSON en un Map<String, dynamic>
      return data;
    } catch (e) {
      //print('Error: $e');
      return null!;
    }
  }

  Future<Map<String, dynamic>> oneDetallesPorNombre(String nombre) async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/detalleActividadTipoActividad/$nombre');

      // Petición GET de login
      final res = await http.get(url);

      // Obtener la respuesta como JSON
      Map<String, dynamic> data = json.decode(res.body);

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

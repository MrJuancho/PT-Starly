// ignore_for_file: null_check_always_fails, file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:asistente_virtual/src/api/enviroment.dart';
import 'package:flutter/material.dart';

class CatTipoPersonalizacionProvider {
  //URL de la api
  final String _url = Enviroment.api;

  BuildContext? context;

  //respuesta de la solicitud materia especifica
  Future<String> oneTipoPersonalizacion(String name) async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/tipospersonalizacion/$name');

      // Petición GET de login
      final res = await http.get(url);

      // Obtener la respuesta como JSON
      final data = json.decode(res.body);

      final personalizacion = data['descTipoPersonalizacion'];
      // Imprimir la respuesta en la consola
      //print(personalizacion);

      // Convertir la respuesta JSON en un string de lo que utilizaremos
      return personalizacion;
    } catch (e) {
      //print('Error: $e');
      return null!;
    }
  }

  //respuesta de la solicitud todas las materias
  Future<List<dynamic>> allTiposPersonalizacion() async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/tipospersonalizacion');

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

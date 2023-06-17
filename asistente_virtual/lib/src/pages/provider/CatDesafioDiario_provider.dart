// ignore_for_file: null_check_always_fails, file_names

import 'dart:convert';
import 'package:asistente_virtual/src/api/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CatDesafioDiarioProvider {
  //URL de la api
  final String _url = Enviroment.api;

  BuildContext? context;

  //respuesta de las solicitudes
  Future<Map<String, dynamic>> oneDesafioDiario(int idDesafioDiario) async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/desafioDiario/$idDesafioDiario');

      // Petición GET de login
      final res = await http.get(url);

      // Obtener la respuesta como JSON
      final data = json.decode(res.body);

      DateTime fecha = DateTime.now();
      data['Expiracion'] = DateTime(fecha.year, fecha.month, fecha.day, 23, 59, 59).toString();
      // Imprimir la respuesta en la consola
      data['Conteo'] = 0;
      // Convertir la respuesta JSON en un Map<String, dynamic>
      return data as Map<String, dynamic>;
    } catch (e) {
      //print('Error: $e');
      return null!;
    }
  }

  Future<List<dynamic>> allDesafiosDiarios() async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/desafioDiario');

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

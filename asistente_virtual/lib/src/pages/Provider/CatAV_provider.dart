// ignore_for_file: null_check_always_fails, file_names

import 'dart:convert';
import 'package:asistente_virtual/src/api/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CatAVProvider {
  //URL de la api
  final String _url = Enviroment.api;

  BuildContext? context;


  void dispose() {
    
  }

  //respuesta de las solicitudes
  Future<Map<String, dynamic>> allAVs() async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/AVs');

      // Petición GET de login
      final res = await http.get(url);

      // Obtener la respuesta como JSON
      final data = json.decode(res.body);

      // Convertir la respuesta JSON en un Map<String, dynamic>
      return data as Map<String, dynamic>;
    } catch (e) {
      ////print('Error: $e');
      return null!;
    }
  }

  Future<List<dynamic>> allTipoAVs(int idTipoAv) async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/AVs/tipo/$idTipoAv');

      // Petición GET de login
      final res = await http.get(url);

      // Obtener la respuesta como JSON
      final data = json.decode(res.body);

      // Convertir la respuesta JSON en un Map<String, dynamic>
      return data as List<dynamic>;
    } catch (e) {
      //print('Error: $e');
      return null!;
    }
  }

  Future<Map<String, dynamic>> oneAV(int idAv) async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/AVs/av/$idAv');

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
}

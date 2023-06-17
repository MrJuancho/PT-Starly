// ignore_for_file: null_check_always_fails, unnecessary_null_comparison, file_names

import 'dart:convert';
import 'package:asistente_virtual/src/api/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TblRegistroDiarioProvider {
  //URL de la api
  final String _url = Enviroment.api;

  BuildContext? context;

  Future? init(BuildContext context) async {
    this.context = context;
  }

  //respuesta de las solicitudes
  Future<Map<String, dynamic>> registroFecha(int user, DateTime fecha) async {
    try {
      // URL para el get
      Uri url = Uri.https(_url, '/registroDiario/$user');

      // Petición GET de login
      final res = await http.get(url);

      // Obtener la respuesta como JSON
      final data = json.decode(res.body);
      String fechaString = DateFormat('yyyy-MM-dd').format(fecha);
      List<dynamic> filteredList = data.where((item) => item['fecha'] == fechaString).toList();
      if (filteredList.isEmpty) {
        return {};
      }

      // Obtener los valores de tareasCompletadas y desafioCompletado de los elementos filtrados
      List<int> tareasCompletadasList = filteredList.map<int>((item) => item['tareasCompletadas']).toList();
      List<bool> desafioCompletadoList = filteredList.map<bool>((item) => item['desafioCompletado']).toList();

      Map<String, dynamic> completados = {
        'tareasCompletadas': tareasCompletadasList[0],
        'desafioCompletado': desafioCompletadoList[0]
      };

      // Imprimir la respuesta en la consola
      //print(completados);

      // Convertir la respuesta JSON en un Map<String, dynamic>
      return completados;
    } catch (e) {
      //print('Error: $e');
      return null!;
    }
  }

  void postRegistroDiario(
      int idAlumno, int idDesafioDiario, int idTareaDiaria1, int idTareaDiaria2, int idTareaDiaria3) async {
    DateTime currentdatetime = DateTime.now().toLocal();
    try {
      Map<String, dynamic> datos = {
        "idAlumno": idAlumno,
        "idDesafioDiario": idDesafioDiario,
        "idTareaDiaria1": idTareaDiaria1,
        "idTareaDiaria2": idTareaDiaria2,
        "idTareaDiaria3": idTareaDiaria3,
        "Fecha": currentdatetime.toString()
      };
      String body = jsonEncode(datos);
      //print(datos);
      // URL para el get
      Uri url = Uri.https(_url, '/registroDiario');

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

  void putTareasyDesafio(int idAlumno, DateTime fecha, int tareasCompletadas, bool desafio) async {
    try {
      String fechaString = DateFormat('yyyy-MM-dd').format(fecha);
      Map<String, dynamic> datos = {
        "idAlumno": idAlumno,
        "fecha": fechaString,
        "tareasCompletadas": tareasCompletadas,
        "desafioCompletado": desafio
      };
      String body = jsonEncode(datos);
      // URL para el put
      Uri url = Uri.https(_url, '/registroDiario/$idAlumno');

      // Petición POST de settear monedas y/o estrellas
      await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
    } catch (e) {
      //print("Error: $e");
    }
  }
}

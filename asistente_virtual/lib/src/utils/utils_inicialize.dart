import 'dart:async';
import 'dart:convert';
import 'package:asistente_virtual/src/pages/Controllers/TareasDiarias_controller.dart';
import 'package:asistente_virtual/src/pages/Provider/TblRegistroDiario_provider.dart';
import 'package:asistente_virtual/src/pages/Provider/ping_provider.dart';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';
import 'package:flutter/foundation.dart';

class UtilsInicialize {
  final UtilsSharedPref _sharedPref = UtilsSharedPref();
  final TareasDiariasController _tareasDiariasController = TareasDiariasController();
  final PingProvider _pingProvider = PingProvider();
  final TblRegistroDiarioProvider _registroDiarioProvider = TblRegistroDiarioProvider();

  Future<String> initapi() async {
    final pong = await _pingProvider.ping();
    return pong['message'];
  }

  Future initTareasyDesafio() async {
    int desafio = 0;

    int tarea1 = 1;
    int tarea2 = 2;
    int tarea3 = 3;

    int idalumno = await _sharedPref.readtodato('Alumno', 'idAlumno');

    if (await _sharedPref.contains('DesafioDiario')) {
      if (kDebugMode) {
        print('Existe un desafio asignado');
      }
      if (await _sharedPref.existField('DesafioDiario', 'Expiracion')) {
        DateTime fecha = DateTime.now();
        final fechajson = await _sharedPref.readtodato('DesafioDiario', 'Expiracion');
        final fechastring = fechajson.toString();
        DateTime conversion = DateTime.parse(fechastring);
        if (fecha.isAfter(conversion)) {
          if (kDebugMode) {
            print('Desafio anterior eliminado, creando nuevo');
          }
          _sharedPref.remove('DesafioDiario');
          _tareasDiariasController.desafioRandom();
        }
      }
    } else {
      if (kDebugMode) {
        print('No hay desafio y se va a crear');
      }
      _tareasDiariasController.desafioRandom();
    }
    await Future.delayed(const Duration(seconds: 1));

    //print(await _sharedPref.read('DesafioDiario'));

    if (await _sharedPref.contains('Tareas')) {
      if (kDebugMode) {
        print('Existe shared de tareas diarias');
      }
      if (await _sharedPref.existField('Tareas', 'Expiracion')) {
        DateTime fecha = DateTime.now();
        final fechajson = await _sharedPref.readtodato('Tareas', 'Expiracion');
        final fechastring = fechajson.toString();
        DateTime conversion = DateTime.parse(fechastring);
        if (fecha.isAfter(conversion)) {
          if (kDebugMode) {
            print('Tareas anterior eliminado y se creo nuevo');
          }
          _sharedPref.remove('Tareas');
          Map<String, dynamic> tareas = {
            'Actividades': 0,
            'Interacciones': 0,
            'TareasCom': 0,
            'Expiracion': DateTime(fecha.year, fecha.month, fecha.day, 23, 59, 59).toString()
          };
          _sharedPref.save('Tareas', json.encode(tareas));
        }
      }
    } else {
      if (kDebugMode) {
        print('Creando json de tareas');
      }
      DateTime fecha = DateTime.now();
      Map<String, dynamic> tareas = {
        'Actividades': 0,
        'Interacciones': 0,
        'TareasCom': 0,
        'Expiracion': DateTime(fecha.year, fecha.month, fecha.day, 23, 59, 59).toString()
      };
      _sharedPref.save('Tareas', json.encode(tareas));
    }

    desafio = await _sharedPref.readtodato('DesafioDiario', 'idDesafio');

    Map<String, dynamic> informaciones = await _registroDiarioProvider.registroFecha(idalumno, DateTime.now());
    if (informaciones.isEmpty) {
      if (kDebugMode) {
        print('Hoy existe un registro');
      }
      _registroDiarioProvider.postRegistroDiario(idalumno, desafio, tarea1, tarea2, tarea3);
    }
  }
}

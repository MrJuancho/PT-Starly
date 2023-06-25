// ignore_for_file: file_names

import 'package:asistente_virtual/src/pages/Provider/TblRegistroDiario_provider.dart';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';
import 'package:flutter/material.dart';

class RegistroDiarioController {
  BuildContext? context;
  Function? refresh;

  final TblRegistroDiarioProvider _registroDiarioProvider = TblRegistroDiarioProvider();
  final UtilsSharedPref _sharedPref = UtilsSharedPref();

  Future<List<dynamic>> informacion(DateTime fecha) async {
    final idalumno = await _sharedPref.readtodato('Alumno', 'idAlumno');
    Map<String, dynamic> informaciones = await _registroDiarioProvider.registroFecha(idalumno, fecha);
    if (informaciones.isEmpty) {
      return [];
    } else {
      List<dynamic> resultados = [informaciones['tareasCompletadas'], informaciones['desafioCompletado']];
      return resultados;
    }
  }

  void putRegistroDiario() async {
    int idalumno = await _sharedPref.readtodato('Alumno', 'idAlumno');
    DateTime fecha = DateTime.now();

    int tareasCompletadas = await _sharedPref.readtodato('Tareas', 'TareasCom');
    int desafioConteo = await _sharedPref.readtodato('DesafioDiario', 'Conteo');
    bool desafio = false;
    if (desafioConteo == 10) {
      desafio = true;
    }
    _registroDiarioProvider.putTareasyDesafio(idalumno, fecha, tareasCompletadas, desafio);
  }

  void dispose() {
    _sharedPref.dispose();
    _registroDiarioProvider.dispose();
  }
}

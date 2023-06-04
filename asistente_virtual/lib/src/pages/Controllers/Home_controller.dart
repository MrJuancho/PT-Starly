import 'dart:convert';
import 'dart:math';
import 'package:asistente_virtual/src/pages/Controllers/TareasDiarias_controller.dart';
import 'package:asistente_virtual/src/pages/Provider/CatDatoCurioso_provider.dart';
import 'package:asistente_virtual/src/pages/Provider/TblAlumno_provider.dart';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';
import 'package:flutter/material.dart';

class HomeController {
  BuildContext? context;
  Function? refresh;

  //Controladores
  final CatDatoCuriosoProvider _catDatoCuriosoProvider = CatDatoCuriosoProvider();
  final UtilsSharedPref _sharedPref = UtilsSharedPref();
  final TblAlumnoProvider _alumnoProvider = TblAlumnoProvider();
  final TareasDiariasController _tareasDiariasController = TareasDiariasController();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    refresh();
  }

  Future<String> fraseRandom() async {
    final numero = Random().nextInt(435) + 1;
    final frase = await _catDatoCuriosoProvider.oneDatoCurioso(numero);
    final fraseString = frase.toString();
    return fraseString;
  }

  void interaccionesAV() async {
    if (await _sharedPref.contains('Tareas')) {
      print('Existe shared de actividades');
      if (await _sharedPref.existField('Tareas', 'TareasCom')) {
        Map<String, dynamic> tareas = json.decode(await _sharedPref.read('Tareas'));
        tareas['Interacciones'] += 1;
        final userAlumno = await _sharedPref.readtodato('Alumno', 'nombreUsuario');
        if (tareas['Interacciones'] == 3) {
          _alumnoProvider.putMonedasEstrellas(userAlumno, 100, 1);
        } else if (await _tareasDiariasController.tareaDD() == 'Interactua con el AV 10 veces') {
          if (tareas['TareasCom'] >= 3) {
            Map<String, dynamic> desafiosDiarios = json.decode(await _sharedPref.read('DesafioDiario'));
            desafiosDiarios['Conteo'] += 1;
            _sharedPref.save('DesafioDiario', json.encode(desafiosDiarios));
            if (desafiosDiarios['Conteo'] == 10) {
              _alumnoProvider.putMonedasEstrellas(userAlumno, 200, 3);
            }
          }
        }
        _sharedPref.save('Tareas', json.encode(tareas));
      }
    }
  }
}

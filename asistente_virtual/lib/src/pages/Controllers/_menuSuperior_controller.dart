import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:asistente_virtual/src/pages/Provider/TblAlumno_provider.dart';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';

class MenuSuperiorController {
  BuildContext? context;
  TblAlumnoProvider usersProvider = TblAlumnoProvider();
  final UtilsSharedPref _sharedPref = UtilsSharedPref();

  //constructort de clase - puede requerir await si se necesita esperar algo
  Future init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);
  }

  Future<String> stars() async {
    final estrellas = await _sharedPref.readtodato('Alumno', 'balanceEstrellas');
    final estrellasString = estrellas.toString();
    return estrellasString;
  }

  Future<String> coins() async {
    final monedas = await _sharedPref.readtodato('Alumno', 'balanceMonedas');
    final monedasString = monedas.toString();
    return monedasString;
  }

  void tareasDiarias(BuildContext context) async {
    //pasar a otra pantalla sin eliminar historial de pantallas
    Navigator.pushNamed(context, 'login');
  }
}

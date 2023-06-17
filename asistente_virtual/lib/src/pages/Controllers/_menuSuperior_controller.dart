// ignore_for_file: file_names

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
    final usuario = await _sharedPref.readtodato('Alumno', 'nombreUsuario');
    final datos = await usersProvider.login(usuario);
    final estrellas = datos['balanceEstrellas'];
    return estrellas.toString();
  }

  Future<String> coins() async {
    final usuario = await _sharedPref.readtodato('Alumno', 'nombreUsuario');
    final datos = await usersProvider.login(usuario);
    final estrellas = datos['balanceMonedas'];
    return estrellas.toString();
  }

  void tareasDiarias(BuildContext context) async {
    //pasar a otra pantalla sin eliminar historial de pantallas
    Navigator.pushNamed(context, 'tareasdiarias');
  }
}

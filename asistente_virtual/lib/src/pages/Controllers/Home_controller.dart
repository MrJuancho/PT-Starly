import 'package:flutter/material.dart';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';
import 'package:asistente_virtual/src/utils/utils_snackbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:asistente_virtual/src/pages/provider/TblAlumno_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomeController {
  BuildContext? context;
  Function? refresh;

  //Controladores
  UtilsSharedPref _sharedpref = new UtilsSharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    final data = await _sharedpref.readtodato('Alumno', 'nombre');
    /* print("Bandera de datos");
    print(data);
    if (data != null) {
      final datos = json.decode(data1) as Map<String, dynamic>;
      final nombre = datos['nombre'];
      print(nombre);
    } else {
      print("No hay datos");
    } */
    refresh();
  }
}

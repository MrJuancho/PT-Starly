import 'dart:math';
import 'package:asistente_virtual/src/pages/Provider/CatDatoCurioso_provider.dart';
import 'package:asistente_virtual/src/pages/Provider/CatPropPersonalizacion_provider.dart';
import 'package:flutter/material.dart';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:asistente_virtual/src/pages/provider/TblAlumno_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomeController {
  BuildContext? context;
  Function? refresh;

  //Controladores
  final UtilsSharedPref _sharedpref = UtilsSharedPref();
  final CatDatoCuriosoProvider _catDatoCuriosoProvider =
      CatDatoCuriosoProvider();

  

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    final data = await _sharedpref.readtodato('Alumno', 'nombre');
    refresh();
  }

  Future<String> fraseRandom() async {
    final numero = Random().nextInt(435) + 1;
    final frase = await _catDatoCuriosoProvider.oneDatoCurioso(numero);
    final fraseString = frase.toString();
    return fraseString;
  }

  /* Future<Map<String, dynamic>> props(String nombre) async {
    final personalizacion =
        await _catPropPersonalizacionProvider.oneProp(nombre);
    return personalizacion;
  } */
}

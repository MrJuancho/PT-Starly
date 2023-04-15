import 'dart:convert';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';
import 'package:flutter/material.dart';

class ActividadesController {
  BuildContext? context;
  Function? refresh;

  //Controllers
  UtilsSharedPref _sharedPref = UtilsSharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    //final data = await _sharedPref.readtodato('Alumno', 'nombre');
    refresh();
  }

  void pantallaanterior(BuildContext context) {
    Navigator.pop(context);
  }

  /* Future <String> nombreycosto() async{
    final numero = Arra
  } */
}

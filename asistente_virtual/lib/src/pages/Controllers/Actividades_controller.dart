// ignore_for_file: file_names, null_check_always_fails

import 'dart:convert';
/* import 'package:asistente_virtual/src/pages/Provider/CatActividad_provider.dart';
import 'package:asistente_virtual/src/pages/Provider/CatRutas_provider.dart'; */
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';
import 'package:flutter/material.dart';

class ActividadesController {
  BuildContext? context;
  Function? refresh;

  //Controllers
  final UtilsSharedPref _sharedPref = UtilsSharedPref();
  /* final CatActividadesProvider _actividadesProvider = CatActividadesProvider();
  final CatRutasProvider _catRutasProvider = CatRutasProvider(); */

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    refresh();
  }

  Future<List<dynamic>> actividadYRuta() async {
    List<dynamic> actividadesFinales = [];
    if (await _sharedPref.contains('ActPostEntrenamiento')) {
      String actividadesJson = await _sharedPref.read('ActPostEntrenamiento');
      final actividades = json.decode(actividadesJson);

      for (var element in actividades) {
        if (element['Completada'] == 0) {
          actividadesFinales.add(element);
        }
      }

      return actividadesFinales;
    } else {
      String actividadesJson = await _sharedPref.read('ActPreEntrenamiento');
      final actividades = json.decode(actividadesJson);
      for (var element in actividades) {
        if (element['Completada'] == 0) {
          actividadesFinales.add(element);
        }
      }
      return actividadesFinales;
    }
  }
}

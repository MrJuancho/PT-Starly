// ignore_for_file: file_names

import 'package:asistente_virtual/src/pages/Provider/CatRutas_provider.dart';
import 'package:asistente_virtual/src/pages/Provider/ViewDetalleActividad_provider.dart';
import 'package:flutter/material.dart';

class ActividadesController {
  BuildContext? context;
  Function? refresh;

  //Controllers
  final CatRutasProvider _catRutasProvider = CatRutasProvider();
  final ViewDetalleActividadProvider _detalleActividadProvider = ViewDetalleActividadProvider();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    //final data = await _sharedPref.readtodato('Alumno', 'nombre');
    refresh();
  }

  List actividades() {
    final entrenamiento = <List>[
      ['Especies en peligro de extinción', 'Se muestra una variedad de especies en peligro de extincion, haz pares.'],
      ['Encontrar las rectas idénticas', 'Encuentra las rectas iguales en un conjunto de rectas.'],
      ['Sopa de letras de adverbios, verbos y adjetivos', 'Sopa de letras con adverbios, adjetivos y verbos'],
      ['Serie lógica principante', 'Identificar la figura que sigue en la serie; dificultad principante'],
      ['Paralelogramo Intruso', 'Identifica de las figuras que se muestran cual no es un paralelogramo.'],
    ];

    return entrenamiento;
  }

  Future<List<List<String>>> actividadYRuta(List<int> idList) async {
    List<List<String>> result = [];

    for (int id in idList) {
      final ruta = await _catRutasProvider.onlyRuta(id);
      final info = await _detalleActividadProvider.onlyInfo(id);

      List<String> array = [info['NombreActividad'], info['Descripcion'], ruta];
      result.add(array);
    }

    //print(result);

    return result;
  }
}

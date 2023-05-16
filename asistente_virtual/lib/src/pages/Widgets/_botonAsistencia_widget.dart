import 'package:asistente_virtual/src/pages/Controllers/Estadistics_controller.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:flutter/material.dart';

import '../../utils/utils_snackbar.dart';

class AyudasWidget {
  static FloatingActionButton build(
      BuildContext context, EstadisticsController _estadisticsController, int idcontenido, Function incrementarAyudas) {
    //final EstadisticsController _estadisticsController = EstadisticsController();
    return FloatingActionButton(
      backgroundColor: PersonalTheme.of(context).alternate,
      foregroundColor: PersonalTheme.of(context).primary,
      onPressed: () async {
        UtilsSnackbar.show(context, await _estadisticsController.asistencia(idcontenido));
        incrementarAyudas();
      },
      child: const Icon(Icons.assistant_rounded),
    );
  }
}

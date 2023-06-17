// ignore_for_file: file_names

import 'package:asistente_virtual/src/pages/Controllers/Estadistics_controller.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:flutter/material.dart';

import '../../utils/utils_snackbar.dart';

class AyudasWidget {
  static FloatingActionButton build(
      BuildContext context, EstadisticsController estadisticsController, int idcontenido, Function incrementarAyudas) {
    return FloatingActionButton(
      backgroundColor: PersonalTheme.of(context).alternate,
      foregroundColor: PersonalTheme.of(context).primary,
      onPressed: () async {
        UtilsSnackbar.show(context, await estadisticsController.asistencia(idcontenido));
        incrementarAyudas();
      },
      child: const Icon(Icons.assistant_rounded),
    );
  }
}

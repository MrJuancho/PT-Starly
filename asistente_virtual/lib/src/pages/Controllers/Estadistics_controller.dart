import 'dart:math';

import 'package:asistente_virtual/src/pages/Provider/CatDatoCurioso_provider.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Resultados_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class EstadisticsController {
  BuildContext? context;
  StopWatchTimer timerController = StopWatchTimer(mode: StopWatchMode.countUp);
  final CatDatoCuriosoProvider _catDatoCuriosoProvider =
      CatDatoCuriosoProvider();
  int elapsedMilliseconds = 0;
  //constructort de clase - puede requerir await si se necesita esperar algo
  Future init(BuildContext context) async {
    this.context = context;
  }

  void dispose() {
    timerController.dispose();
  }

  String formatMilliseconds() {
    elapsedMilliseconds = timerController.rawTime.value;
    int minutes = (elapsedMilliseconds / 60000).truncate();
    int seconds = ((elapsedMilliseconds % 60000) / 1000).truncate();
    int ms = (elapsedMilliseconds % 1000).truncate();
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.$ms';
  }

  void startTimer() {
    timerController.onStartTimer();
  }

  void stopTimer() {
    timerController.onStopTimer();
  }

  Future<dynamic> asistencia(int idContenido) async {
    List<Map<String, dynamic>> datosCuriosos = await _catDatoCuriosoProvider
        .datoCuriosobyContenido(idContenido); // Obtener datos curiosos
    Random random = Random(); // Crear instancia de la clase Random
    Map<String, dynamic> datoCurioso = datosCuriosos[random.nextInt(
        datosCuriosos.length)]; // Seleccionar aleatoriamente un elemento
    String descripcionDatos = datoCurioso[
        "descripcionDatos"]; // Obtener la descripción del elemento seleccionado
    return descripcionDatos; // retornar la descripción
  }

  void regreso(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, 'actividades', (route) => false);
  }
}

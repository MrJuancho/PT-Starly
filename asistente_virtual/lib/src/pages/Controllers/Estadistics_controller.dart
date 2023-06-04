import 'dart:convert';
import 'dart:math';
import 'package:asistente_virtual/src/pages/Controllers/TareasDiarias_controller.dart';
import 'package:asistente_virtual/src/pages/Provider/CatDatoCurioso_provider.dart';
import 'package:asistente_virtual/src/pages/Provider/TblAlumno_provider.dart';
import 'package:asistente_virtual/src/pages/Provider/TblResultadosActividad_provider.dart';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';
import 'package:flutter/cupertino.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class EstadisticsController {
  BuildContext? context;
  StopWatchTimer timerController = StopWatchTimer(mode: StopWatchMode.countUp);
  final CatDatoCuriosoProvider _catDatoCuriosoProvider = CatDatoCuriosoProvider();
  final UtilsSharedPref _sharedPref = UtilsSharedPref();
  final TblResultadosActividadProvider _resultadosActividadProvider = TblResultadosActividadProvider();
  final TblAlumnoProvider _alumnoProvider = TblAlumnoProvider();
  final TareasDiariasController _tareasDiariasController = TareasDiariasController();
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
    List<Map<String, dynamic>> datosCuriosos =
        await _catDatoCuriosoProvider.datoCuriosobyContenido(idContenido); // Obtener datos curiosos
    Random random = Random(); // Crear instancia de la clase Random
    Map<String, dynamic> datoCurioso =
        datosCuriosos[random.nextInt(datosCuriosos.length)]; // Seleccionar aleatoriamente un elemento
    String descripcionDatos = datoCurioso["descripcionDatos"]; // Obtener la descripción del elemento seleccionado
    return descripcionDatos; // retornar la descripción
  }

  void regreso(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, 'actividades', (route) => false);
  }

  void registroResultados(int idActividad, int intentos, int ayudas, String tiempo) async {
    final idAlumno = await _sharedPref.readtodato('Alumno', 'idAlumno');
    //print(tiempo);
    List<String> parts = tiempo.split(':');
    int minutes = int.parse(parts[0]);
    double seconds = double.parse(parts[1]);

    int milliseconds = (seconds * 1000).round();

    DateTime dateTime = DateTime(0, 1, 1, 0, minutes, 0, milliseconds);

    String formattedTime =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}.${dateTime.millisecond.toString().padLeft(3, '0')}';

    if (await _sharedPref.contains('Tareas')) {
      print('Existe shared de actividades');
      if (await _sharedPref.existField('Tareas', 'Actividades')) {
        Map<String, dynamic> tareas = json.decode(await _sharedPref.read('Tareas'));
        tareas['Actividades'] += 1;
        final userAlumno = await _sharedPref.readtodato('Alumno', 'nombreUsuario');
        if (tareas['Actividades'] == 3) {
          _alumnoProvider.putMonedasEstrellas(userAlumno, 300, 1);
        } else if (tareas['Actividades'] == 5) {
          _alumnoProvider.putMonedasEstrellas(userAlumno, 500, 1);
        } else if (await _tareasDiariasController.tareaDD() == 'Completa 10 actividades') {
          if (tareas['TareasCom'] >= 3) {
            Map<String, dynamic> desafiosDiarios = json.decode(await _sharedPref.read('DesafioDiario'));
            desafiosDiarios['Conteo'] += 1;
            _sharedPref.save('DesafioDiario', json.encode(desafiosDiarios));
            if (desafiosDiarios['Conteo'] == 10) {
              _alumnoProvider.putMonedasEstrellas(userAlumno, 1000, 5);
            }
          }
        }

        _sharedPref.save('Tareas', json.encode(tareas));
      }
    } else {
      Map<String, dynamic> tareas = {'Actividades': 0, 'Interacciones': 0, 'TareasCom': 0};
      _sharedPref.save('Tareas', json.encode(tareas));
    }

    _resultadosActividadProvider.postResultadoActividad(idActividad, idAlumno, formattedTime, intentos, ayudas);
  }

  void sumamonedas() async {
    final userAlumno = await _sharedPref.readtodato('Alumno', 'nombreUsuario');
    _alumnoProvider.putMonedasEstrellas(userAlumno, 100, 0);
  }
}

import 'dart:convert';
import 'package:asistente_virtual/src/pages/Controllers/TareasDiarias_controller.dart';
import 'package:asistente_virtual/src/pages/Provider/ping_provider.dart';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';

class UtilsInicialize {
  final UtilsSharedPref _sharedPref = UtilsSharedPref();
  final TareasDiariasController _tareasDiariasController = TareasDiariasController();
  final PingProvider _pingProvider = PingProvider();

  Future initDD(String key, String value) async {
    if (await _sharedPref.contains(key)) {
      print('Desafio asignado');
      if (await _sharedPref.existField(key, value)) {
        DateTime fecha = DateTime.now();
        //DateTime fecha = DateTime(2023, 5, 4, 13, 30);
        //_sharedPref.printAllSharedPreferences(key);
        final fechajson = await _sharedPref.readtodato(key, value);
        final fechastring = fechajson.toString();
        DateTime conversion = DateTime.parse(fechastring);
        print(conversion);
        print(fecha);
        if (fecha.isAfter(conversion)) {
          print('desafio anterior eliminado y se creo nuevo');
          _sharedPref.remove(key);
          _tareasDiariasController.desafioRandom();
        }
      }
    } else {
      print('no hay desafio y se va a crear');
      _tareasDiariasController.desafioRandom();
    }
  }

  Future<String> initapi() async {
    final pong = await _pingProvider.ping();
    return pong['message'];
  }

  Future initTareas() async {
    if (await _sharedPref.contains('Tareas')) {
      print('Existe shared de actividades');
      if (await _sharedPref.existField('Tareas', 'Expiracion')) {
        DateTime fecha = DateTime.now();
        //DateTime fecha = DateTime(2023, 5, 4, 13, 30);
        //_sharedPref.printAllSharedPreferences('Tareas');
        final fechajson = await _sharedPref.readtodato('Tareas', 'Expiracion');
        final fechastring = fechajson.toString();
        DateTime conversion = DateTime.parse(fechastring);
        print(conversion);
        print(fecha);
        if (fecha.isAfter(conversion)) {
          print('desafio anterior eliminado y se creo nuevo');
          _sharedPref.remove('Tareas');
          DateTime fecha = DateTime.now();
          Map<String, dynamic> tareas = {
            'Actividades': 0,
            'Interacciones': 0,
            'TareasCom': 0,
            'Expiracion': DateTime(fecha.year, fecha.month, fecha.day, 23, 59, 59).toString()
          };
          _sharedPref.save('Tareas', json.encode(tareas));
        }
      }
    } else {
      print('creando json de tareas');
      DateTime fecha = DateTime.now();
      Map<String, dynamic> tareas = {
        'Actividades': 0,
        'Interacciones': 0,
        'TareasCom': 0,
        'Expiracion': DateTime(fecha.year, fecha.month, fecha.day, 23, 59, 59).toString()
      };
      _sharedPref.save('Tareas', json.encode(tareas));
    }
  }

}

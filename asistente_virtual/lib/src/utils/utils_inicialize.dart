import 'package:asistente_virtual/src/pages/Controllers/TareasDiarias_controller.dart';
import 'package:asistente_virtual/src/pages/Provider/ping_provider.dart';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';
import 'package:flutter/material.dart';

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

  Future<int> tareaUno() async {
    return 1;
  }
}

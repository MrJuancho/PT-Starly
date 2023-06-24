import 'dart:async';
import 'dart:convert';
import 'package:asistente_virtual/src/pages/Controllers/TareasDiarias_controller.dart';
import 'package:asistente_virtual/src/pages/Provider/CatActividad_provider.dart';
import 'package:asistente_virtual/src/pages/Provider/CatRutas_provider.dart';
import 'package:asistente_virtual/src/pages/Provider/TblIndiceUCB_provider.dart';
import 'package:asistente_virtual/src/pages/Provider/TblRegistroDiario_provider.dart';
import 'package:asistente_virtual/src/pages/Provider/ping_provider.dart';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';
import 'package:flutter/foundation.dart';

class UtilsInicialize {
  final UtilsSharedPref _sharedPref = UtilsSharedPref();
  final TareasDiariasController _tareasDiariasController = TareasDiariasController();
  final PingProvider _pingProvider = PingProvider();
  final TblRegistroDiarioProvider _registroDiarioProvider = TblRegistroDiarioProvider();
  final CatRutasProvider _catRutasProvider = CatRutasProvider();
  final CatActividadesProvider _actividadesProvider = CatActividadesProvider();
  final TblIndiceUCBProvider _indiceUCBProvider = TblIndiceUCBProvider();

  Future<String> initapi() async {
    final pong = await _pingProvider.ping();
    return pong['message'];
  }

  Future initTareasyDesafio() async {
    int desafio = 0;

    int tarea1 = 1;
    int tarea2 = 2;
    int tarea3 = 3;

    int idalumno = await _sharedPref.readtodato('Alumno', 'idAlumno');

    if (await _sharedPref.contains('DesafioDiario')) {
      if (kDebugMode) {
        print('Existe un desafio asignado');
      }
      if (await _sharedPref.existField('DesafioDiario', 'Expiracion')) {
        DateTime fecha = DateTime.now();
        final fechajson = await _sharedPref.readtodato('DesafioDiario', 'Expiracion');
        final fechastring = fechajson.toString();
        DateTime conversion = DateTime.parse(fechastring);
        if (fecha.isAfter(conversion)) {
          if (kDebugMode) {
            print('Desafio anterior eliminado, creando nuevo');
          }
          _sharedPref.remove('DesafioDiario');
          _tareasDiariasController.desafioRandom();
        }
      }
    } else {
      if (kDebugMode) {
        print('No hay desafio y se va a crear');
      }
      _tareasDiariasController.desafioRandom();
    }
    await Future.delayed(const Duration(seconds: 1));

    //print(await _sharedPref.read('DesafioDiario'));

    if (await _sharedPref.contains('Tareas')) {
      if (kDebugMode) {
        print('Existe shared de tareas diarias');
      }
      if (await _sharedPref.existField('Tareas', 'Expiracion')) {
        DateTime fecha = DateTime.now();
        final fechajson = await _sharedPref.readtodato('Tareas', 'Expiracion');
        final fechastring = fechajson.toString();
        DateTime conversion = DateTime.parse(fechastring);
        if (fecha.isAfter(conversion)) {
          if (kDebugMode) {
            print('Tareas anterior eliminado y se creo nuevo');
          }
          _sharedPref.remove('Tareas');
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
      if (kDebugMode) {
        print('Creando json de tareas');
      }
      DateTime fecha = DateTime.now();
      Map<String, dynamic> tareas = {
        'Actividades': 0,
        'Interacciones': 0,
        'TareasCom': 0,
        'Expiracion': DateTime(fecha.year, fecha.month, fecha.day, 23, 59, 59).toString()
      };
      _sharedPref.save('Tareas', json.encode(tareas));
    }

    desafio = await _sharedPref.readtodato('DesafioDiario', 'idDesafio');

    Map<String, dynamic> informaciones = await _registroDiarioProvider.registroFecha(idalumno, DateTime.now());
    if (informaciones.isEmpty) {
      if (kDebugMode) {
        print('Hoy existe un registro');
      }
      _registroDiarioProvider.postRegistroDiario(idalumno, desafio, tarea1, tarea2, tarea3);
    }
  }

  Future<void> actividadesprime() async {
    int idalumno = await _sharedPref.readtodato('Alumno', 'idAlumno');
    //Si no existe ActPreEntrenamiento se crea y se guardan las primeras 20 actividades dejadas
    if (!await _sharedPref.contains('ActPreEntrenamiento')) {
      List<dynamic> result = [];
      final info = await _actividadesProvider.allActividades();

      List<dynamic> mezclados = info..shuffle();
      result = mezclados.take(20).toList();
      List<int> idActividadDone = [];

      for (int i = 0; i < result.length; i++) {
        final rutas = await _catRutasProvider.oneRuta(result[i]['idActividad']);
        result[i]['Ruta'] = rutas['rutas'];
        result[i]['Completada'] = 0;
        idActividadDone.add(result[i]['idActividad']);
      }

      _sharedPref.save('ActividadesHechas', json.encode(idActividadDone));

      List<Map<String, dynamic>> modifiedResult = result.map((jsonData) {
        return {
          'idActividad': jsonData['idActividad'],
          'nombreActividad': jsonData['nombreActividad'],
          'descripcion': jsonData['descripcion'],
          'Ruta': jsonData['Ruta'],
          'Completada': jsonData['Completada'],
        };
      }).toList();

      //Guardado de esas 20 actividades ya mapeadas como json
      _sharedPref.save('ActPreEntrenamiento', json.encode(modifiedResult));
    } else {
      String actividadesJson = await _sharedPref.read('ActPreEntrenamiento');
      final actividadesPreTrain = json.decode(actividadesJson);

      num suma = 0;

      for (var element in actividadesPreTrain) {
        suma += element['Completada'];
      }
      if (suma == 20) {
        final actPostTrain = json.decode(await _sharedPref.read('ActividadesHechas'));
        if (!await _sharedPref.contains('ActPostEntrenamiento')) {
          createBatch(idalumno);
        } else {
          num sumaPost = 0;
          for (var element in actPostTrain) {
            sumaPost += element['Completada'];
          }
          if (sumaPost == 5) {
            await _sharedPref.remove('ActPostEntrenamiento');
            createBatch(idalumno);
          }
        }
      }
    }
  }

  void createBatch(int idalumno) async {
    final actHechas = json.decode(await _sharedPref.read('ActividadesHechas'));
    List<dynamic> allActividades = await _actividadesProvider.allActividades();
    List<dynamic> allActividadesNoResult = [];

    //SELECCIONAR ACTIVIDADES QUE QUEDARON FUERA DEL RESTO DE ACTIVIDADES YA HECHAS
    for (var element in allActividades) {
      if (!actHechas.contains(int.parse(element['idActividad'].toString()))) {
        final rutas = await _catRutasProvider.oneRuta(element['idActividad']);
        element['Ruta'] = rutas['rutas'];
        element['Completada'] = 0;
        allActividadesNoResult.add(element);
      }
    }
    //Seleccion de 2 actividades que estan fuera de las que no se han realizado
    List<dynamic> mezclados = allActividadesNoResult..shuffle();
    List<dynamic> actividadesNewBatch = mezclados.take(2).toList();

    //Actividades que se tomaran para el nuevo batch de 5 actividades
    for (var element in actividadesNewBatch) {
      //Incluyendo esas 2 actividades fueras de las de shared preferences
      actHechas.add(element['idActividad']);
    }
    _sharedPref.save('ActividadesHechas', json.encode(actHechas));

    //RECOPILACION DE LAS 3 ACTIVIDADES DADAS POR EL ALGORITMO
    List<dynamic> indicesUCB = await _indiceUCBProvider.indices(idalumno);
    List<dynamic> indicesUCB_3 = indicesUCB.sublist(0, 3);

    List<int> actTemp = [];
    for (var element in indicesUCB_3) {
      actTemp.add(element['TblIndiceUcbAlumno_idActividad']);
    }

    for (var element in allActividades) {
      if (actTemp.contains(element['idActividad'])) {
        final rutas = await _catRutasProvider.oneRuta(element['idActividad']);
        element['Ruta'] = rutas['rutas'];
        element['Completada'] = 0;
        actividadesNewBatch.add(element);
      }
    }

    List<Map<String, dynamic>> modifiedResult = actividadesNewBatch.map((jsonData) {
      return {
        'idActividad': jsonData['idActividad'],
        'nombreActividad': jsonData['nombreActividad'],
        'descripcion': jsonData['descripcion'],
        'Ruta': jsonData['Ruta'],
        'Completada': jsonData['Completada'],
      };
    }).toList();

    _sharedPref.save('ActPostEntrenamiento', json.encode(modifiedResult));
  }
}

import 'package:asistente_virtual/src/pages/Controllers/TareasDiarias_controller.dart';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UtilsInicialize {
  UtilsSharedPref _sharedPref = UtilsSharedPref();
  TareasDiariasController _tareasDiariasController = TareasDiariasController();
  
  Future init(BuildContext context,String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('DesafioDiario')){

    }else{
      _tareasDiariasController.desafioRandom();
    }
  }
}
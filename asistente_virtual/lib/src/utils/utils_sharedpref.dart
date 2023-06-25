import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UtilsSharedPref {
  void save(String key, value) async {
    //obtener instancia de shared para usar métodos
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  //método para leer la información
  Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) == null) return null;
    return json.decode(prefs.getString(key)!);
  }

  //método para leer la información
  Future<dynamic> readtodato(String key, String dato) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) == null) {
      // ignore: null_check_always_fails
      return null!;
    } else {
      final jsonString = prefs.getString(key);
      final decodificacionJSONAPI = json.decode(jsonString!);
      final conversionJSON = json.decode(decodificacionJSONAPI) as Map<String, dynamic>;
      final informacion = conversionJSON[dato];
      return informacion;
    }
  }

  

  //método para verificar si existe algún dato
  Future<bool> contains(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<bool> existField(String key, String campo) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) == null) {
      return false;
    } else {
      final decodificacionJSONAPI = json.decode(prefs.getString(key)!);
      final conversionJSON = json.decode(decodificacionJSONAPI) as Map<String, dynamic>;
      return conversionJSON.containsKey(campo);
    }
  }

  Future<void> printAllSharedPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(key);

    if (jsonData != null) {
      final data = json.decode(jsonData);
      if (kDebugMode) {
        print(data);
      }
    } else {
      if (kDebugMode) {
        print('La clave $key no existe en SharedPreferences.');
      }
    }
  }

  //método para eliminar datos de shared preferences
  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  void logout(BuildContext context) async {
    //borramos el key user para cerrar sesión
    await remove('Alumno');
    //eliminar historial de pantallas
    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }

  void dispose(){
  }
}

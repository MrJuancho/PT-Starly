import 'package:asistente_virtual/src/pages/Screens/Actividades_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Personalizacion_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/TareasDiarias_screen.dart';
import 'package:asistente_virtual/src/utils/utils_colors.dart';
import 'package:flutter/material.dart';
import 'package:asistente_virtual/src/pages/Screens/Login_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/PaginaInicio_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/PruebasAPI_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Titulo de la app
      title: 'Asistente Virtual',
      //Quitar bandera de debug
      debugShowCheckedModeBanner: false,
      //Ruta inicial de la aplicación
      initialRoute: 'login',
      //rutas de la aplicacion
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'personalizacion': (BuildContext context) => PersonalizacionPage(),
        'actividades':(BuildContext context) => ActividadesPage(),
        'tareasdiarias':(BuildContext context) => TareasDiariasPage(),
        //'registroDiario':(BuildContext context) => RegistroDiario(),
        
        'pruebasapi': (BuildContext context) => const MyTextFieldAndButton(),
      },

      theme: ThemeData(
        colorScheme:
            ColorScheme.dark(primary: UtilsColors.primaryBackgroundColor),
      ),
    );
  }
}

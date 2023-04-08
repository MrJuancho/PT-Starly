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

class _MyAppState extends State<MyApp>{

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Titulo de la app
      title: 'Asistente Virtual',
      //Quitar bandera de debug
      debugShowCheckedModeBanner: false,
      //Ruta inicial de la aplicación 
      initialRoute: 'home',
      //rutas de la aplicacion
      routes: {
        //pagina de login
        
        'login':(BuildContext context) => LoginPage(),
        'home':(BuildContext context) => HomePage(),
        //'actividades':(BuildContext context) => Actividades(),
        //'registroDiario':(BuildContext context) => RegistroDiario(),
        //'personalizacion':(BuildContext context) => Personalizacion(),
        'pruebasapi':(BuildContext context) => const MyTextFieldAndButton(),
      },

      theme: ThemeData(
        colorScheme: ColorScheme.dark(primary: UtilsColors.primaryBackgroundColor),
      ),
    );
  }
}


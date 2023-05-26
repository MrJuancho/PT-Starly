import 'package:asistente_virtual/src/pages/Screens/Actividades/Intruso/act_intruso_aislantes_conductores_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Intruso/act_intruso_angulos_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Intruso/act_intruso_biodiversidad_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Intruso/act_intruso_climas_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Intruso/act_intruso_medidas_basicas_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Intruso/act_intruso_paises_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Intruso/act_intruso_paralelogramos_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Intruso/act_intruso_personajes_historicos_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Intruso/act_intruso_sistema_solar_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Memorama/act_memorama_areas_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Memorama/act_memorama_especies_peligro_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Memorama/act_memorama_guerra_reforma_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Memorama/act_memorama_paises_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Memorama/act_memorama_personajes_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Memorama/act_memorama_peso_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Memorama/act_memorama_planetas_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Memorama/act_memorama_rectas_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Memorama/act_memorama_revolucion_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Misma%20Imagen/act_encuentra_caminos.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Misma%20Imagen/act_encuentra_cuidado_medio_ambiente_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Misma%20Imagen/act_encuentra_expresiones_algebraicas_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Misma%20Imagen/act_encuentra_partido_politico_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Misma%20Imagen/act_encuentra_reciclaje_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Misma%20Imagen/act_encuentra_recta_secante_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Misma%20Imagen/act_encuentra_simbolos_ciudad.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Series/act_series_avanzado_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Series/act_series_experto_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Series/act_series_extra_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Series/act_series_facil_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Series/act_series_medio_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Series/act_series_principiante_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Sopa%20de%20Letras/act_sopa_adverbios_verbos_adjetivos_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Sopa%20de%20Letras/act_sopa_anticonceptivos_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Sopa%20de%20Letras/act_sopa_apellidos_celebres_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Sopa%20de%20Letras/act_sopa_esdrujulas_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Sopa%20de%20Letras/act_sopa_extensiones_territoriales_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Sopa%20de%20Letras/act_sopa_metodo_cientifico_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Sopa%20de%20Letras/act_sopa_movimiento_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Sopa%20de%20Letras/act_sopa_probabilidad_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Sopa%20de%20Letras/act_sopa_revolucion_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Sopa%20de%20Letras/act_sopa_sentimientos_emociones_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Sopa%20de%20Letras/act_sopa_triangulos_cuadrilateros.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Personalizacion_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/TareasDiarias_screen.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:asistente_virtual/src/utils/utils_inicialize.dart';
import 'package:flutter/material.dart';
import 'package:asistente_virtual/src/pages/Screens/Login_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/PaginaInicio_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/PruebasAPI_screen.dart';

void main() async {
  runApp(MyApp());
  UtilsInicialize _utilsInicialize = UtilsInicialize();
  await _utilsInicialize.initDD('DesafioDiario', 'Expiracion');
  print(await _utilsInicialize.initapi());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeMode _themeMode = PersonalTheme.themeMode;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Titulo de la app
      title: 'Asistente Virtual',
      //Quitar bandera de debug
      debugShowCheckedModeBanner: false,
      //Ruta inicial de la aplicación
      initialRoute: 'act_series_extra',
      //rutas de la aplicacion
      routes: {
        //CORE APP
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'personalizacion': (BuildContext context) => PersonalizacionPage(),
        'actividades': (BuildContext context) => ActividadesPage(),
        'tareasdiarias': (BuildContext context) => TareasDiariasPage(),
        //'registroDiario':(BuildContext context) => RegistroDiario(),

        //ACTIVIDADES ENCUENTRA MISMA IMAGEN
        'act_encuentra_recta_secante': (BuildContext context) => const ActEncuentraRectaSecantePage(),
        'act_encuentra_partidos_politicos': (BuildContext context) => const ActEncuentraPartidosPoliticosPage(),
        'act_encuentra_expresiones_algebraicas': (BuildContext context) =>
            const ActEncuentraExpresionesAlgebraicasPage(),
        'act_encuentra_cuidado_medio_ambiente': (BuildContext context) => const ActEncuentraCuidadoMedioAmbientePage(),
        'act_encuentra_reciclaje': (BuildContext context) => const ActEncuentraReciclajePage(),
        'act_encuentra_simbolos_ciudad': (BuildContext context) => const ActEncuentraSimbolosCiudadPage(),
        'act_encuentra_caminos': (BuildContext context) => const ActEncuentraCaminosPage(),

        //ACTIVIDADES INTRUSO
        'act_intruso_angulos': (BuildContext context) => const ActIntrusoAngulosPage(),
        'act_intruso_paralelogramos': (BuildContext context) => const ActIntrusoParalelogramosPage(),
        'act_intruso_aislantesconductores': (BuildContext context) => const ActIntrusoAislantesConductoresPage(),
        'act_intruso_biodiversidad': (BuildContext context) => const ActIntrusoBiodiverdidadPage(),
        'act_intruso_climas': (BuildContext context) => const ActIntrusoClimasPage(),
        'act_intruso_medidasbasicas': (BuildContext context) => const ActIntrusoMedidasBasicasPage(),
        'act_intruso_paises': (BuildContext context) => const ActIntrusoPaisesPage(),
        'act_intruso_personajeshistoricos': (BuildContext context) => const ActIntrusoPersonajesHistoricosPage(),
        'act_intruso_sistemasolar': (BuildContext context) => const ActIntrusoSistemaSolarPage(),

        //MEMORAMA
        'act_memorama_sistemasolar': (BuildContext context) => const ActMemoramaSistemaSolarPage(),
        'act_memorama_especiespeligro': (BuildContext context) => const ActMemoramaEspeciosPeligroPage(),
        'act_memorama_areas': (BuildContext context) => const ActMemoramaAreasPage(),
        'act_memorama_guerra_reforma': (BuildContext context) => const ActMemoramaGuerraReformaPage(),
        'act_memorama_rectas': (BuildContext context) => const ActMemoramaRectasPage(),
        'act_memorama_paises': (BuildContext context) => const ActMemoramaPaisesPage(),
        'act_memorama_personajes': (BuildContext context) => const ActMemoramaPersonajesPage(),
        'act_memorama_revolucion': (BuildContext context) => const ActMemoramaRevolucionPage(),
        'act_memorama_peso': (BuildContext context) => const ActMemoramaPesoPage(),

        //SOPAS DE LETRAS
        'act_sopa_sentimientos_emociones': (BuildContext context) => ActSopaSentimientosEmocionesPage(),
        'act_sopa_adverbios_verbos': (BuildContext context) => ActSopaAdjetivosVerbosPage(),
        'act_sopa_triangulos_cuadrilateros': (BuildContext context) => ActSopaTriangulosCuadrilaterosPage(),
        'act_sopa_probabilidad': (BuildContext context) => ActSopaProbabilidadPage(),
        'act_sopa_movimiento': (BuildContext context) => ActSopaMovimientoPage(),
        'act_sopa_revolucion': (BuildContext context) => ActSopaRevolucionPage(),
        'act_sopa_extensiones': (BuildContext context) => ActSopaExtensionesTerritorialesPage(),
        'act_sopa_metodo_cientifico': (BuildContext context) => ActSopaMetodoCientificoPage(),
        'act_sopa_esdrujulas': (BuildContext context) => ActSopaEsdrujulasPage(),
        'act_sopa_apellidos_reforma': (BuildContext context) => ActSopaApellidosCelebresPage(),
        'act_sopa_anticonceptivos': (BuildContext context) => ActSopaAnticonceptivosPage(),

        //SERIES LOGICAS
        'act_series_principiante': (BuildContext context) => const ActSeriesPrincipiantePage(),
        'act_series_facil': (BuildContext context) => const ActSeriesFacilPage(),
        'act_series_medio': (BuildContext context) => const ActSeriesMedioPage(),
        'act_series_avanzado': (BuildContext context) => const ActSeriesAvanzadoPage(),
        'act_series_experto': (BuildContext context) => const ActSeriesExpertoPage(),
        'act_series_extra': (BuildContext context) => const ActSeriesExtraPage(),

        //PANTALLA PRUEBAS DE API
        'pruebasapi': (BuildContext context) => const MyTextFieldAndButton(),
      },

      theme: ThemeData(brightness: Brightness.dark),
      themeMode: _themeMode,
    );
  }
}

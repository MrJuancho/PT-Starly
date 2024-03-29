// ignore_for_file: library_private_types_in_public_api

import 'package:asistente_virtual/src/pages/Controllers/Estadistics_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Instrucciones_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Resultados_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_botonAsistencia_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Estadisticas_widget.dart';
import 'package:asistente_virtual/src/utils/utils_snackbar.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:flutter/material.dart';
import '../../../../utils/utils_preferences.dart';
import '../../../flutter_flow/Theme_Personal.dart';

class ActEncuentraPartidosPoliticosPage extends StatefulWidget {
  const ActEncuentraPartidosPoliticosPage({
    Key? key,
    String? counter,
  })  : counter = counter ?? '0',
        super(key: key);

  final String counter;

  @override
  _ActEncuentraPartidosPoliticosState createState() => _ActEncuentraPartidosPoliticosState();
}

class _ActEncuentraPartidosPoliticosState extends State<ActEncuentraPartidosPoliticosPage> {
  final EstadisticsController _estadisticsController = EstadisticsController();
  bool _startPressed = false;
  bool _activityFinished = false;
  bool _onefound = false;
  int intentos = 0;
  int ayudas = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _estadisticsController.dispose();
    _unfocusNode.dispose();
    super.dispose();
  }

  void incrementarIntentos() {
    setState(() {
      intentos++;
    });
  }

  void incrementarAyudas() {
    setState(() {
      ayudas++;
    });
  }

  void presionado() {
    setState(() {
      _startPressed = true;
      _estadisticsController.startTimer();
    });
  }

  void resultados() {
    setState(() {
      _startPressed = false;
      _activityFinished = true;
      _estadisticsController.sumamonedas();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    const reducedwindowWidth = 500.00;
    const reducedwindowHeight = 810.00;

    if (screenWidth >= 450) {
      return SizedBox(
        height: reducedwindowHeight,
        width: reducedwindowWidth,
        child: Center(child: eleccion(reducedwindowWidth, reducedwindowHeight)),
      );
    } else {
      return eleccion(screenWidth, screenHeight);
    }
  }

  Widget eleccion(double screenWidth, double screenHeight) {
    return _startPressed
        ? _actividad(context, screenWidth, screenHeight)
        : _activityFinished
            ? ResultadosWidget.show(context, intentos, ayudas, _estadisticsController.formatMilliseconds(),
                _estadisticsController, screenWidth, screenHeight)
            : InstruccionesWidget.show(
                context,
                _estadisticsController,
                presionado,
                'Se muestran una variedad de partidos politicos, encontrar el que es igual.',
                screenWidth,
                screenHeight);
  }

  Widget _actividad(BuildContext context, double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: PersonalTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: PersonalTheme.of(context).primary,
          elevation: 2,
          centerTitle: true,
          title: Marquee(
            forwardAnimation: Curves.easeIn,
            autoRepeat: true,
            direction: Axis.horizontal,
            textDirection: TextDirection.ltr,
            animationDuration: const Duration(seconds: 2),
            backDuration: const Duration(milliseconds: 1000),
            pauseDuration: const Duration(milliseconds: 1000),
            directionMarguee: DirectionMarguee.TwoDirection,
            child: Text(
              'Encontrar al mismo partido político',
              style: PersonalTheme.of(context).headlineMedium.override(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 22.0,
                  ),
            ),
          ),
        ),
        body: SafeArea(
          child: Visibility(
            visible: responsiveVisibility(
              context: context,
              tablet: false,
              tabletLandscape: false,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1.0,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [PersonalTheme.of(context).primary, PersonalTheme.of(context).tertiary],
                        stops: const [0.0, 1.0],
                        begin: const AlignmentDirectional(0.0, -1.0),
                        end: const AlignmentDirectional(0, 1.0),
                      ),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: SizedBox(
                        width: screenWidth * 1.0,
                        height: screenHeight * 0.7,
                        child: Stack(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0.6, -0.5),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PAS.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.6, -1.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PCM.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.8, -0.75),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/CTM.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.6, -1.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    //AQUI
                                    if (_onefound) {
                                      incrementarIntentos();
                                      UtilsSnackbar.show(context, 'Correcto!', 1);
                                      _estadisticsController.stopTimer();
                                      resultados();
                                      _estadisticsController.registroResultados(
                                          6, intentos, ayudas, _estadisticsController.formatMilliseconds());
                                    } else {
                                      UtilsSnackbar.show(context, 'Correcto!', 1);
                                      _onefound = true;
                                    }
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PRD.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.2, -1.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PT.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.2, -1.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PNA.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, -0.76),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PSD.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.4, -0.75),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/Convergencia.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.4, -0.75),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PLM.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.8, -0.75),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PST.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.6, -0.5),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/FuerzaMexico.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.2, -0.5),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/Flor.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.2, -0.5),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/NuevaAlianza.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-1.0, -0.5),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/FC.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(1.0, -0.5),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/MovimientoCiudadano.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.8, -0.25),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PCN.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.4, -0.25),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PDMR.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.4, -0.25),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PLMA.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.8, -0.25),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PMT.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.6, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PNR.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/MP.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.2, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PNM.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.2, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/Humanista.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.6, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    //AQUI
                                    if (_onefound) {
                                      incrementarIntentos();
                                      UtilsSnackbar.show(context, 'Correcto!', 1);
                                      _estadisticsController.stopTimer();
                                      resultados();
                                      _estadisticsController.registroResultados(
                                          6, intentos, ayudas, _estadisticsController.formatMilliseconds());
                                    } else {
                                      UtilsSnackbar.show(context, 'Correcto!', 1);
                                      _onefound = true;
                                    }
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PRD.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(1.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PP.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.8, 0.25),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/Morena.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.4, 0.25),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PD.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.4, 0.25),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PRI.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.8, 0.25),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PSN.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.6, 0.5),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PDN.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-1.0, 0.5),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PRT.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.2, 0.5),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PAN.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.2, 0.5),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PRM.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.6, 0.5),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PSUM.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(1.0, 0.5),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PCD.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.8, 0.75),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/EncuentroSocial.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.8, 0.75),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/RSP.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.4, 0.75),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PVM.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.75),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PES.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.4, 0.75),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PDM.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.6, 1.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PMS.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.6, 1.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PFCRN.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.2, 1.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PN.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.2, 1.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Partidos_Politicos/PARM.png',
                                    width: 60.0,
                                    height: 60.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                EstadisticasWidget.build(context, intentos, ayudas, _estadisticsController),
              ],
            ),
          ),
        ),
        floatingActionButton: AyudasWidget.build(context, _estadisticsController, 31, incrementarAyudas),
        //bottomNavigationBar: MenuInferior(),
      ),
    );
  }
}

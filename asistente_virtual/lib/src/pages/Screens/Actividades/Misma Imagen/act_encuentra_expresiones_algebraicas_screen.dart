// ignore_for_file: library_private_types_in_public_api

import 'package:asistente_virtual/src/pages/Controllers/Estadistics_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Instrucciones_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Resultados_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_botonAsistencia_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Estadisticas_widget.dart';
import 'package:asistente_virtual/src/utils/utils_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import '../../../../utils/utils_preferences.dart';
import '../../../flutter_flow/Theme_Personal.dart';

class ActEncuentraExpresionesAlgebraicasPage extends StatefulWidget {
  const ActEncuentraExpresionesAlgebraicasPage({
    Key? key,
    String? counter,
  })  : counter = counter ?? '0',
        super(key: key);

  final String counter;

  @override
  _ActEncuentraExpresionesAlgebraicasState createState() => _ActEncuentraExpresionesAlgebraicasState();
}

class _ActEncuentraExpresionesAlgebraicasState extends State<ActEncuentraExpresionesAlgebraicasPage> {
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
                'Se muestran elementos basicos de operaciones algebraicas, que busque el que es el mismo.',
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
              'Encontrar las misma expresión algebraica',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/6.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/35.png',
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
                                    //AQUI
                                    if (_onefound) {
                                      incrementarIntentos();
                                      UtilsSnackbar.show(context, 'Correcto!', 1);
                                      _estadisticsController.stopTimer();
                                      resultados();
                                      _estadisticsController.registroResultados(
                                          4, intentos, ayudas, _estadisticsController.formatMilliseconds());
                                    } else {
                                      UtilsSnackbar.show(context, 'Correcto!', 1);
                                      _onefound = true;
                                    }
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/39.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/2.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/37.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/34.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/36.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/38.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/3.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/4.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/5.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/1.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/7.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/8.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/9.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/10.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/11.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/13.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/12.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/14.png',
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
                                    //AQUI
                                    if (_onefound) {
                                      incrementarIntentos();
                                      UtilsSnackbar.show(context, 'Correcto!', 1);
                                      _estadisticsController.stopTimer();
                                      resultados();
                                      _estadisticsController.registroResultados(
                                          4, intentos, ayudas, _estadisticsController.formatMilliseconds());
                                    } else {
                                      UtilsSnackbar.show(context, 'Correcto!', 1);
                                      _onefound = true;
                                    }
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/39.png',
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
                                    incrementarIntentos();
                                    UtilsSnackbar.show(context, 'Seleccion Incorrecta', 1);
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/15.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/16.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/17.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/18.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/19.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/20.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/22.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/21.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/24.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/23.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/26.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/25.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/31.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/27.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/28.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/29.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/30.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/33.png',
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Expresiones_Algebraicas/32.png',
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
        floatingActionButton: AyudasWidget.build(context, _estadisticsController, 16, incrementarAyudas),
        //bottomNavigationBar: MenuInferior(),
      ),
    );
  }
}

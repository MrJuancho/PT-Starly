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

class ActEncuentraRectaSecantePage extends StatefulWidget {
  const ActEncuentraRectaSecantePage({
    Key? key,
    String? counter,
  })  : counter = counter ?? '0',
        super(key: key);

  final String counter;

  @override
  _ActEncuentraRectaSecanteWidgetState createState() => _ActEncuentraRectaSecanteWidgetState();
}

class _ActEncuentraRectaSecanteWidgetState extends State<ActEncuentraRectaSecantePage> {
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
                'Se muestran una variedad de rectas paralelas, perpendiculares y secantes; Deberas encontrar la que es igual.',
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
              'Encontrar la misma recta secante',
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
                              alignment: const AlignmentDirectional(-1.0, -1.0),
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
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_034003542.png',
                                    width: 100.0,
                                    height: 100.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.33, -1.0),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_034346758.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.33, -1.0),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_034622280.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.68, -0.66),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_040258977.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(1.0, -1.0),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_035940804.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, -0.66),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_112933406.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.68, -0.66),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113024669.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.03),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113644786.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(1.0, -0.32),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113305908.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.33, -0.32),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113349611.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.33, -0.32),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113424570.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.68, 0.03),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113518301.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-1.0, -0.32),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113104570.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.68, 0.03),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113725228.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-1.0, 0.35),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113807413.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.33, 0.35),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113837837.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.33, 0.35),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113917513.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(1.0, 0.35),
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
                                          2, intentos, ayudas, _estadisticsController.formatMilliseconds());
                                    } else {
                                      _onefound = true;
                                      UtilsSnackbar.show(context, 'Correcto!', 1);
                                    }
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113947706.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.68, 0.68),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_114056401.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.68),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_114227250.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.68, 0.68),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_114215515.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-1.04, 1.0),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_115537831.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-0.33, 1.0),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_115602377.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.33, 1.0),
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
                                          2, intentos, ayudas, _estadisticsController.formatMilliseconds());
                                    } else {
                                      UtilsSnackbar.show(context, 'Correcto!', 1);
                                      _onefound = true;
                                    }
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_115728143.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(1.0, 1.0),
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
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_115744199.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
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
        floatingActionButton: AyudasWidget.build(context, _estadisticsController, 11, incrementarAyudas),
        //bottomNavigationBar: MenuInferior(),
      ),
    );
  }
}

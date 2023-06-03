import 'package:asistente_virtual/src/pages/Controllers/Estadistics_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Instrucciones_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Resultados_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_botonAsistencia_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Estadisticas_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_vistaImagenExpandida.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import '../../../../utils/utils_preferences.dart';
import '../../../flutter_flow/Theme_Personal.dart';

class ActIntrusoAislantesConductoresPage extends StatefulWidget {
  const ActIntrusoAislantesConductoresPage({
    Key? key,
    String? counter,
  })  : this.counter = counter ?? '0',
        super(key: key);

  final String counter;

  @override
  _ActIntrusoAislantesConductoresState createState() => _ActIntrusoAislantesConductoresState();
}

class _ActIntrusoAislantesConductoresState extends State<ActIntrusoAislantesConductoresPage> {
  final EstadisticsController _estadisticsController = EstadisticsController();
  bool _startPressed = false;
  bool _activityFinished = false;
  int correctas = 0;
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
    return _startPressed
        ? _actividad(context)
        : _activityFinished
            ? ResultadosWidget.show(
                context, intentos, ayudas, _estadisticsController.formatMilliseconds(), _estadisticsController)
            : InstruccionesWidget.show(context, _estadisticsController, presionado,
                'Encontrar el intruso en series que muestren materiales conductores y aislantes asi como herramientas de manejo electrico.');
  }

  Widget _actividad(BuildContext context) {
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
            animationDuration: Duration(seconds: 2),
            backDuration: Duration(milliseconds: 1000),
            pauseDuration: Duration(milliseconds: 1000),
            directionMarguee: DirectionMarguee.TwoDirection,
            child: Text(
              'Intruso en conductores y aislantes',
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
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(0.0, -1.0),
                        end: AlignmentDirectional(0, 1.0),
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: GridView(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 3.0,
                          mainAxisSpacing: 40.0,
                          childAspectRatio: 1.0,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              incrementarIntentos();
                            },
                            onLongPress: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ExpandedImageView(
                                    image: Image.asset(
                                      'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac1.png',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag1',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag1',
                              transitionOnUserGestures: true,
                              child: Image.asset(
                                'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac1.png',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              incrementarIntentos();
                            },
                            onLongPress: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ExpandedImageView(
                                    image: Image.asset(
                                      'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac2.png',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag2',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag2',
                              transitionOnUserGestures: true,
                              child: Image.asset(
                                'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac2.png',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              //AQUI
                                incrementarIntentos();
                                if (correctas == 3) {
                                  _estadisticsController.stopTimer();
                                  resultados();
                                  _estadisticsController.registroResultados(
                                      17,
                                      intentos,
                                      ayudas,
                                      _estadisticsController
                                          .formatMilliseconds());
                                } else {
                                  correctas += 1;
                                }
                            },
                            onLongPress: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ExpandedImageView(
                                    image: Image.asset(
                                      'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac3.png',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag3',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag3',
                              transitionOnUserGestures: true,
                              child: Image.asset(
                                'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac3.png',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              incrementarIntentos();
                            },
                            onLongPress: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ExpandedImageView(
                                    image: Image.asset(
                                      'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac4.png',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag4',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag4',
                              transitionOnUserGestures: true,
                              child: Image.asset(
                                'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac4.png',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              incrementarIntentos();
                            },
                            onLongPress: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ExpandedImageView(
                                    image: Image.asset(
                                      'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac5.png',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag5',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag5',
                              transitionOnUserGestures: true,
                              child: Image.asset(
                                'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac5.png',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              incrementarIntentos();
                            },
                            onLongPress: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ExpandedImageView(
                                    image: Image.asset(
                                      'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac6.png',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag6',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag6',
                              transitionOnUserGestures: true,
                              child: Image.asset(
                                'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac6.png',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              //AQUI
                                incrementarIntentos();
                                if (correctas == 3) {
                                  _estadisticsController.stopTimer();
                                  resultados();
                                  _estadisticsController.registroResultados(
                                      17,
                                      intentos,
                                      ayudas,
                                      _estadisticsController
                                          .formatMilliseconds());
                                } else {
                                  correctas += 1;
                                }
                            },
                            onLongPress: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ExpandedImageView(
                                    image: Image.asset(
                                      'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac7.png',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag7',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag7',
                              transitionOnUserGestures: true,
                              child: Image.asset(
                                'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac7.png',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              incrementarIntentos();
                            },
                            onLongPress: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ExpandedImageView(
                                    image: Image.asset(
                                      'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac8.png',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag8',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag8',
                              transitionOnUserGestures: true,
                              child: Image.asset(
                                'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac8.png',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              incrementarIntentos();
                            },
                            onLongPress: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ExpandedImageView(
                                    image: Image.asset(
                                      'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac9.png',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag9',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag9',
                              transitionOnUserGestures: true,
                              child: Image.asset(
                                'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac9.png',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              incrementarIntentos();
                            },
                            onLongPress: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ExpandedImageView(
                                    image: Image.asset(
                                      'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac10.png',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag10',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag10',
                              transitionOnUserGestures: true,
                              child: Image.asset(
                                'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac10.png',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              incrementarIntentos();
                            },
                            onLongPress: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ExpandedImageView(
                                    image: Image.asset(
                                      'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac11.png',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag11',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag11',
                              transitionOnUserGestures: true,
                              child: Image.asset(
                                'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac11.png',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              //AQUI
                                incrementarIntentos();
                                if (correctas == 3) {
                                  _estadisticsController.stopTimer();
                                  resultados();
                                  _estadisticsController.registroResultados(
                                      17,
                                      intentos,
                                      ayudas,
                                      _estadisticsController
                                          .formatMilliseconds());
                                } else {
                                  correctas += 1;
                                }
                            },
                            onLongPress: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ExpandedImageView(
                                    image: Image.asset(
                                      'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac12.png',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag12',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag12',
                              transitionOnUserGestures: true,
                              child: Image.asset(
                                'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac12.png',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              incrementarIntentos();
                            },
                            onLongPress: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ExpandedImageView(
                                    image: Image.asset(
                                      'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac13.png',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag13',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag13',
                              transitionOnUserGestures: true,
                              child: Image.asset(
                                'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac13.png',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              //AQUI
                                incrementarIntentos();
                                if (correctas == 3) {
                                  _estadisticsController.stopTimer();
                                  resultados();
                                  _estadisticsController.registroResultados(
                                      17,
                                      intentos,
                                      ayudas,
                                      _estadisticsController
                                          .formatMilliseconds());
                                } else {
                                  correctas += 1;
                                }
                            },
                            onLongPress: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ExpandedImageView(
                                    image: Image.asset(
                                      'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac14.png',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag14',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag14',
                              transitionOnUserGestures: true,
                              child: Image.asset(
                                'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac14.png',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              incrementarIntentos();
                            },
                            onLongPress: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ExpandedImageView(
                                    image: Image.asset(
                                      'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac15.png',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag15',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag15',
                              transitionOnUserGestures: true,
                              child: Image.asset(
                                'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac15.png',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              incrementarIntentos();
                            },
                            onLongPress: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ExpandedImageView(
                                    image: Image.asset(
                                      'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac16.png',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag16',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag16',
                              transitionOnUserGestures: true,
                              child: Image.asset(
                                'assets/images/Actividades/Intruso/Act_Intruso_Aislantes_Conductores/ac16.png',
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
                EstadisticasWidget.build(context, intentos, ayudas, _estadisticsController),
              ],
            ),
          ),
        ),
        floatingActionButton: AyudasWidget.build(context, _estadisticsController, 24, incrementarAyudas),
        //bottomNavigationBar: MenuInferior(),
      ),
    );
  }
}

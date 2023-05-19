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

class ActIntrusoPersonajesHistoricosPage extends StatefulWidget {
  const ActIntrusoPersonajesHistoricosPage({
    Key? key,
    String? counter,
  })  : this.counter = counter ?? '0',
        super(key: key);

  final String counter;

  @override
  _ActIntrusoPersonajesHistoricosState createState() => _ActIntrusoPersonajesHistoricosState();
}

class _ActIntrusoPersonajesHistoricosState extends State<ActIntrusoPersonajesHistoricosPage> {
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
                'Se presentan dentro de los sets diferentes momentos dentro de la epoca (1920 a 1982) seleccionar el que no corresponde.');
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
              'Encontrar el intruso en época (1920-1982)',
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
                                      'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph1.png',
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
                                'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph1.png',
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
                                      'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph2.png',
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
                                'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph2.png',
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
                                      'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph3.png',
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
                                'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph3.png',
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
                                if (correctas == 4) {
                                  _estadisticsController.stopTimer();
                                  resultados();
                                  _estadisticsController.registroResultados(
                                      22,
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
                                      'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph4.png',
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
                                'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph4.png',
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
                                if (correctas == 4) {
                                  _estadisticsController.stopTimer();
                                  resultados();
                                  _estadisticsController.registroResultados(
                                      22,
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
                                      'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph5.jpg',
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
                                'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph5.jpg',
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
                                      'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph6.jpg',
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
                                'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph6.jpg',
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
                                      'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph7.png',
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
                                'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph7.png',
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
                                      'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph8.png',
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
                                'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph8.png',
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
                                if (correctas == 4) {
                                  _estadisticsController.stopTimer();
                                  resultados();
                                  _estadisticsController.registroResultados(
                                      22,
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
                                      'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph9.jpg',
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
                                'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph9.jpg',
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
                                      'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph10.png',
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
                                'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph10.png',
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
                                      'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph11.png',
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
                                'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph11.png',
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
                                      'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph12.jpg',
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
                                'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph12.jpg',
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
                                      'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph14.png',
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
                                'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph14.png',
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
                                      'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph15.png',
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
                                'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph15.png',
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
                                if (correctas == 4) {
                                  _estadisticsController.stopTimer();
                                  resultados();
                                  _estadisticsController.registroResultados(
                                      22,
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
                                      'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph16.png',
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
                                'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph16.png',
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
                                      'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph13.png',
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
                                'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph13.png',
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
                                      'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph17.png',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag17',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag17',
                              transitionOnUserGestures: true,
                              child: Image.asset(
                                'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph17.png',
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
                                if (correctas == 4) {
                                  _estadisticsController.stopTimer();
                                  resultados();
                                  _estadisticsController.registroResultados(
                                      22,
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
                                      'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph18.jpg',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag18',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag18',
                              transitionOnUserGestures: true,
                              child: Image.asset(
                                'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph18.jpg',
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
                                      'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph19.png',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag19',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag19',
                              transitionOnUserGestures: true,
                              child: Image.asset(
                                'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph19.png',
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
                                      'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph20.png',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag20',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag20',
                              transitionOnUserGestures: true,
                              child: Image.asset(
                                'assets/images/Actividades/Intruso/Act_Intruso_Personajes_Historicos/ph20.png',
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
        floatingActionButton: AyudasWidget.build(context, _estadisticsController, 28, incrementarAyudas),
        //bottomNavigationBar: MenuInferior(),
      ),
    );
  }
}

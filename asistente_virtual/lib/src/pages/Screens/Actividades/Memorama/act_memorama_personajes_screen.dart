import 'dart:math';
import 'package:asistente_virtual/src/pages/Controllers/Estadistics_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Instrucciones_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Resultados_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_botonAsistencia_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Estadisticas_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_vistaImagenExpandida.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import '../../../../utils/utils_preferences.dart';
import '../../../flutter_flow/Theme_Personal.dart';

class ActMemoramaPersonajesPage extends StatefulWidget {
  const ActMemoramaPersonajesPage({
    Key? key,
    String? counter,
  })  : this.counter = counter ?? '0',
        super(key: key);

  final String counter;

  @override
  _ActMemoramaPersonajesState createState() => _ActMemoramaPersonajesState();
}

class _ActMemoramaPersonajesState extends State<ActMemoramaPersonajesPage> {
  final EstadisticsController _estadisticsController = EstadisticsController();
  bool _startPressed = false;
  bool _activityFinished = false;
  int correctas = 0;
  int intentos = 0;
  int ayudas = 0;

  List<String> cardImages = [
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod1.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod2.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod3.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod4.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod5.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod6.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod7.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod8.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod9.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod10.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod11.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod12.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod1.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod2.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod3.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod4.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod5.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod6.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod7.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod8.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod9.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod10.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod11.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Personajes/mod12.png',
  ];

  List<String> flippedCards = [];
  List<int> flippedCardsnumbers = [];
  List<GlobalKey<FlipCardState>> cardKeys = [];
  List<bool> flippedStatus = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    cardImages.shuffle(Random());
    cardKeys = List.generate(
      cardImages.length,
      (_) => GlobalKey<FlipCardState>(),
    );
    flippedStatus = List.generate(cardImages.length, (_) => false);
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

  void flipCard(int index) {
    if (flippedCards.length < 2) {
      setState(() {
        flippedCards.add(cardImages[index]);
        flippedCardsnumbers.add(index);
      });

      if (flippedCards.length == 2) {
        if (flippedCards[0] != flippedCards[1]) {
          // Si las cartas no coinciden, se voltean después de un breve retraso
          Future.delayed(const Duration(milliseconds: 500), () {
            List<GlobalKey<FlipCardState>> flippedCardKeys = [];
            for (var i = 0; i < flippedCards.length; i++) {
              int cardIndex = flippedCardsnumbers[i];
              flippedCardKeys.add(cardKeys[cardIndex]);
            }
            for (var key in flippedCardKeys) {
              key.currentState!.toggleCard();
            }
            setState(() {
              flippedCards.clear();
              flippedCardsnumbers.clear();
              incrementarIntentos();
            });
          });
        } else {
          // Si las cartas coinciden, se mantienen volteadas y se reinicia el contador
          setState(() {
            flippedCardsnumbers.forEach((index) {
              flippedStatus[index] = true;
            });
            flippedCards.clear();
            flippedCardsnumbers.clear();
            incrementarIntentos();
          });
        }
        if (flippedStatus.every((status) => status == true)) {
          resultados();
          _estadisticsController.stopTimer();
          _estadisticsController.registroResultados(29, intentos, ayudas, _estadisticsController.formatMilliseconds());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _startPressed
        ? _actividad(context)
        : _activityFinished
            ? ResultadosWidget.show(
                context, intentos, ayudas, _estadisticsController.formatMilliseconds(), _estadisticsController)
            : InstruccionesWidget.show(
                context, _estadisticsController, presionado, 'Hacer pares de personajes celebres que participaron y fueron parte de la vida despues de la independencia.');
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
            animationDuration: const Duration(seconds: 2),
            backDuration: const Duration(milliseconds: 1000),
            pauseDuration: const Duration(milliseconds: 1000),
            directionMarguee: DirectionMarguee.TwoDirection,
            child: Text(
              'Personajes después de la independencia',
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
                    child: GridView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.75,
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: cardImages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            speed: 400,
                            key: cardKeys[index],
                            onFlipDone: (isFront) {
                              if (isFront) {
                                flipCard(index);
                              }
                            },
                            front: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: PersonalTheme.of(context).tertiary,
                                borderRadius: BorderRadius.circular(12.0),
                                shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    'assets/images/home/cardBack.png',
                                    width: 100.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            back: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: PersonalTheme.of(context).tertiary,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 5.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onLongPress: () async {
                                    await Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: ExpandedImageView(
                                          image: Image.asset(
                                            cardImages[index],
                                            fit: BoxFit.contain,
                                          ),
                                          allowRotation: false,
                                          useHeroAnimation: false,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: '$index',
                                    transitionOnUserGestures: true,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset(
                                        cardImages[index],
                                        width: 100.0,
                                        height: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                EstadisticasWidget.build(context, intentos, ayudas, _estadisticsController),
              ],
            ),
          ),
        ),
        floatingActionButton: AyudasWidget.build(context, _estadisticsController, 27, incrementarAyudas),
        //bottomNavigationBar: MenuInferior(),
      ),
    );
  }
}

// ignore_for_file: null_check_always_fails

import 'package:asistente_virtual/src/pages/Controllers/Estadistics_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Estadisticas_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Instrucciones_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Resultados_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_botonAsistencia_widget.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:asistente_virtual/src/utils/utils_preferences.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';

class ActSopaMetodoCientificoPage extends StatefulWidget {
  @override
  _ActSopaMetodoCientificoState createState() => _ActSopaMetodoCientificoState();
}

class _ActSopaMetodoCientificoState extends State<ActSopaMetodoCientificoPage> {
  final EstadisticsController _estadisticsController = EstadisticsController();
  bool _startPressed = false;
  bool _activityFinished = false;
  int correctas = 0;
  int intentos = 0;
  int ayudas = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  List<String> words = [
    'ANALISIS',
    'CONCLUSION',
    'DATOS',
    'EXPERIMENTACION',
    'HIPOTESIS',
    'INVESTIGACION',
    'OBSERVACION',
    'ORGANIZACION',
    'PLANTEAMIENTO',
    'REGISTRO',
  ];

  List<String> selectedWords = [];

  List<List<String>> letterGrid = [
    ['Q', 'O', 'I', 'R', 'E', 'M', 'B', 'A', 'G', 'L', 'Q', 'O', 'U', 'R', 'R'],
    ['R', 'S', 'R', 'E', 'B', 'N', 'N', 'G', 'P', 'T', 'K', 'J', 'A', 'H', 'Y'],
    ['L', 'Q', 'P', 'X', 'Ñ', 'O', 'O', 'K', 'I', 'O', 'Z', 'C', 'O', 'E', 'H'],
    ['W', 'M', 'X', 'P', 'D', 'I', 'I', 'W', 'E', 'T', 'V', 'U', 'J', 'A', 'I'],
    ['P', 'M', 'N', 'E', 'S', 'C', 'C', 'C', 'H', 'N', 'R', 'T', 'M', 'I', 'P'],
    ['P', 'Ñ', 'O', 'R', 'Z', 'A', 'A', 'O', 'K', 'E', 'K', 'N', 'S', 'F', 'O'],
    ['Y', 'P', 'I', 'I', 'U', 'G', 'Z', 'N', 'G', 'I', 'L', 'T', 'N', 'D', 'T'],
    ['W', 'U', 'C', 'M', 'P', 'I', 'I', 'C', 'B', 'M', 'X', 'R', 'P', 'L', 'E'],
    ['U', 'M', 'A', 'E', 'S', 'T', 'N', 'L', 'P', 'A', 'S', 'S', 'W', 'C', 'S'],
    ['H', 'C', 'V', 'N', 'G', 'S', 'A', 'U', 'W', 'E', 'T', 'O', 'O', 'Q', 'I'],
    ['I', 'Z', 'R', 'T', 'U', 'E', 'G', 'S', 'K', 'T', 'Z', 'T', 'J', 'V', 'S'],
    ['M', 'H', 'E', 'A', 'W', 'V', 'R', 'I', 'Ñ', 'N', 'J', 'A', 'N', 'Y', 'N'],
    ['Y', 'O', 'S', 'C', 'A', 'N', 'O', 'O', 'Y', 'A', 'X', 'D', 'Ñ', 'O', 'P'],
    ['F', 'B', 'B', 'I', 'P', 'I', 'A', 'N', 'A', 'L', 'I', 'S', 'I', 'S', 'T'],
    ['R', 'F', 'O', 'O', 'R', 'H', 'A', 'A', 'S', 'P', 'M', 'Y', 'V', 'T', 'C'],
    ['M', 'F', 'L', 'N', 'X', 'T', 'I', 'W', 'Ñ', 'G', 'W', 'Y', 'X', 'I', 'R'],
    ['O', 'R', 'T', 'S', 'I', 'G', 'E', 'R', 'C', 'U', 'B', 'B', 'M', 'R', 'E'],
  ];

  String currentWord = '';
  bool isDragging = false;
  Offset startPoint = Offset.zero;
  List<Offset> path = [];

  List<List<bool>> selectedCells = List.generate(
    5,
    (_) => List<bool>.filled(7, false),
  );

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

  bool checkString(List<String> words, String searchString) {
    if (words.contains(searchString)) {
      return true;
    } else {
      String reversedString = searchString.split('').reversed.join();
      return words.contains(reversedString);
    }
  }

  String currentString(List<String> words, String searchString) {
    if (words.contains(searchString)) {
      return searchString;
    } else {
      String reversedString = searchString.split('').reversed.join();
      if (words.contains(reversedString)) {
        return reversedString;
      } else {
        return null!;
      }
    }
  }

  bool haveSameContent(List<String> list1, List<String> list2) {
    return list1.toSet().containsAll(list2.toSet()) && list2.toSet().containsAll(list1.toSet());
  }

  @override
  Widget build(BuildContext context) {
    return _startPressed
        ? _actividad(context)
        : _activityFinished
            ? ResultadosWidget.show(
                context, intentos, ayudas, _estadisticsController.formatMilliseconds(), _estadisticsController)
            : InstruccionesWidget.show(context, _estadisticsController, presionado,
                'Identificar en la sopa de letras los pasos del metodo cientifico.');
  }

  Scaffold _actividad(BuildContext context) {
    final cellSize = (MediaQuery.of(context).size.width * 0.95) / letterGrid.first.length;
    return Scaffold(
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
            'Pasos del método científico',
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
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        height: cellSize * letterGrid.length,
                        width: MediaQuery.of(context).size.width * 0.95,
                        color: PersonalTheme.of(context).primaryText,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onPanStart: (details) {
                            setState(() {
                              currentWord = '';
                              isDragging = true;
                              startPoint = details.localPosition;
                            });
                          },
                          onPanUpdate: (details) {
                            if (!isDragging) return;

                            setState(() {
                              final row = (startPoint.dy / cellSize).floor();
                              final column = (startPoint.dx / cellSize).floor();
                              final currentRow = (details.localPosition.dy / cellSize).floor();
                              final currentColumn = (details.localPosition.dx / cellSize).floor();

                              currentWord = '';

                              if (row >= 0 &&
                                  row < letterGrid.length &&
                                  column >= 0 &&
                                  column < letterGrid[row].length &&
                                  currentRow >= 0 &&
                                  currentRow < letterGrid.length &&
                                  currentColumn >= 0 &&
                                  currentColumn < letterGrid[currentRow].length) {
                                if (row == currentRow) {
                                  final start = column < currentColumn ? column : currentColumn;
                                  final end = column > currentColumn ? column : currentColumn;

                                  for (int i = start; i <= end; i++) {
                                    currentWord += letterGrid[row][i];
                                  }
                                } else if (column == currentColumn) {
                                  final start = row < currentRow ? row : currentRow;
                                  final end = row > currentRow ? row : currentRow;

                                  for (int i = start; i <= end; i++) {
                                    currentWord += letterGrid[i][column];
                                  }
                                } else if ((currentColumn - column).abs() == (currentRow - row).abs()) {
                                  final stepRow = currentRow > row ? 1 : -1;
                                  final stepColumn = currentColumn > column ? 1 : -1;

                                  int i = row;
                                  int j = column;

                                  while (i != currentRow || j != currentColumn) {
                                    final selectedLetter = letterGrid[i][j];
                                    currentWord += selectedLetter;

                                    i += stepRow;
                                    j += stepColumn;
                                  }

                                  final selectedLetter = letterGrid[currentRow][currentColumn];
                                  currentWord += selectedLetter;
                                }
                              }
                            });
                          },
                          onPanEnd: (details) {
                            setState(() {
                              if (checkString(words, currentWord)) {
                                if (!selectedWords.contains(currentWord)) {
                                  currentWord = currentString(words, currentWord);
                                  selectedWords.add(currentWord);
                                }
                              }
                              incrementarIntentos();
                              if (haveSameContent(selectedWords, words)) {
                                _estadisticsController.stopTimer();
                                resultados();
                                _estadisticsController.registroResultados(
                                    57, intentos, ayudas, _estadisticsController.formatMilliseconds());
                              } else {
                                print('Current word: $currentWord');
                                currentWord = '';
                                isDragging = false;
                              }
                            });
                          },
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: letterGrid.first.length,
                              childAspectRatio: 1.0, // Asegura que las celdas tengan un aspecto cuadrado
                            ),
                            itemCount: letterGrid.length * letterGrid.first.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final row = index ~/ letterGrid.first.length;
                              final column = index % letterGrid.first.length;

                              if (row < letterGrid.length && column < letterGrid[row].length) {
                                final letter = letterGrid[row][column];

                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                  ),
                                  child: Center(
                                    child: Text(
                                      letter,
                                      style: PersonalTheme.of(context)
                                          .bodyMedium
                                          .override(fontFamily: 'Poppins', color: PersonalTheme.of(context).primary),
                                    ),
                                  ),
                                );
                              } else {
                                return Container(); // Celda vacía
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            //constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('Palabras a encontrar', style: PersonalTheme.of(context).bodySmall),
                                    Text('Palabras encontradas', style: PersonalTheme.of(context).bodySmall),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      words.join('\n'),
                                      style: PersonalTheme.of(context).bodySmall,
                                    ),
                                    Text(
                                      selectedWords.join('\n'),
                                      style: PersonalTheme.of(context).bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              EstadisticasWidget.build(context, intentos, ayudas, _estadisticsController),
            ],
          ),
        ),
      ),
      floatingActionButton: AyudasWidget.build(context, _estadisticsController, 26, incrementarAyudas),
      //bottomNavigationBar: MenuInferior(),
    );
  }
}

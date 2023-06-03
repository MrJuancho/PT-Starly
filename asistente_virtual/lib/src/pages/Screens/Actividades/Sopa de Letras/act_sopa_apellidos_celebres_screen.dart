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

class ActSopaApellidosCelebresPage extends StatefulWidget {
  @override
  _ActSopaApellidosCelebresState createState() => _ActSopaApellidosCelebresState();
}

class _ActSopaApellidosCelebresState extends State<ActSopaApellidosCelebresPage> {
  final EstadisticsController _estadisticsController = EstadisticsController();
  bool _startPressed = false;
  bool _activityFinished = false;
  int correctas = 0;
  int intentos = 0;
  int ayudas = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  List<String> words = [
    'COMONFORT',
    'DEGOLLADO',
    'GONZALEZ',
    'JUAREZ',
    'LOPEZ',
    'MEJIA',
    'MIRAMON',
    'ORTEGA',
    'ZARAGOZA',
    'ZULOAGA',
  ];

  List<String> selectedWords = [];

  List<List<String>> letterGrid = [
    ['J', 'A', 'E', 'L', 'Ñ', 'A', 'X', 'Ñ', 'J', 'X', 'O', 'R', 'U', 'F', 'W', 'Y'],
    ['F', 'T', 'A', 'C', 'S', 'E', 'J', 'Z', 'G', 'U', 'N', 'T', 'C', 'A', 'Ñ', 'K'],
    ['U', 'P', 'G', 'I', 'R', 'Z', 'N', 'Y', 'A', 'Z', 'O', 'G', 'A', 'R', 'A', 'Z'],
    ['M', 'R', 'R', 'M', 'Y', 'F', 'H', 'E', 'A', 'Y', 'W', 'V', 'I', 'I', 'D', 'Y'],
    ['R', 'S', 'T', 'E', 'A', 'G', 'U', 'W', 'A', 'U', 'E', 'L', 'L', 'V', 'B', 'P'],
    ['J', 'E', 'W', 'J', 'F', 'E', 'F', 'N', 'O', 'I', 'O', 'Q', 'O', 'S', 'M', 'D'],
    ['U', 'R', 'W', 'I', 'I', 'Z', 'N', 'P', 'W', 'C', 'D', 'W', 'N', 'T', 'T', 'Q'],
    ['I', 'Z', 'J', 'A', 'W', 'O', 'U', 'L', 'F', 'O', 'A', 'W', 'O', 'A', 'F', 'V'],
    ['K', 'Q', 'B', 'M', 'M', 'K', 'O', 'S', 'Y', 'M', 'L', 'B', 'R', 'R', 'H', 'X'],
    ['B', 'C', 'H', 'A', 'Q', 'P', 'U', 'F', 'C', 'O', 'L', 'U', 'Z', 'A', 'Ñ', 'M'],
    ['W', 'Q', 'R', 'O', 'E', 'U', 'A', 'K', 'S', 'N', 'O', 'Y', 'Z', 'G', 'E', 'W'],
    ['Ñ', 'I', 'U', 'Z', 'H', 'X', 'D', 'A', 'X', 'F', 'G', 'Ñ', 'U', 'E', 'T', 'Z'],
    ['M', 'S', 'S', 'P', 'V', 'K', 'B', 'U', 'I', 'O', 'E', 'N', 'L', 'T', 'E', 'Z'],
    ['E', 'V', 'K', 'P', 'P', 'K', 'H', 'Y', 'N', 'R', 'D', 'N', 'O', 'R', 'M', 'E'],
    ['Y', 'L', 'N', 'O', 'O', 'C', 'K', 'Z', 'I', 'T', 'U', 'Q', 'A', 'O', 'U', 'C'],
    ['X', 'P', 'E', 'P', 'H', 'K', 'A', 'N', 'K', 'T', 'B', 'U', 'G', 'Ñ', 'Q', 'A'],
    ['P', 'M', 'I', 'X', 'F', 'L', 'U', 'B', 'M', 'X', 'J', 'H', 'A', 'Y', 'E', 'Z'],
    ['Y', 'O', 'W', 'R', 'E', 'Z', 'C', 'L', 'N', 'Z', 'G', 'P', 'B', 'A', 'F', 'N'],
    ['N', 'J', 'L', 'Z', 'Ñ', 'E', 'M', 'G', 'L', 'Ñ', 'R', 'Ñ', 'D', 'E', 'Y', 'G'],
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
      _estadisticsController.sumamonedas();
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
                'Seleccionar apellidos de personajes celebres que participaron en la guerra de reforma.');
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
            'Apellidos de personajes celebres',
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
                                    59, intentos, ayudas, _estadisticsController.formatMilliseconds());
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
      floatingActionButton: AyudasWidget.build(context, _estadisticsController, 28, incrementarAyudas),
      //bottomNavigationBar: MenuInferior(),
    );
  }
}

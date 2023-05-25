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

class ActSopaTriangulosCuadrilaterosPage extends StatefulWidget {
  @override
  _ActSopaTriangulosCuadrilaterosState createState() => _ActSopaTriangulosCuadrilaterosState();
}

class _ActSopaTriangulosCuadrilaterosState extends State<ActSopaTriangulosCuadrilaterosPage> {
  final EstadisticsController _estadisticsController = EstadisticsController();
  bool _startPressed = false;
  bool _activityFinished = false;
  int correctas = 0;
  int intentos = 0;
  int ayudas = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  List<String> words = [
    'ALTURA',
    'ANGULO',
    'CATETO',
    'EQUILATERO',
    'ESCALENO',
    'HIPOTENUSA',
    'ORTOCENTRO',
    'PARALELOS',
    // Agrega aquí más palabras
  ];

  List<String> selectedWords = [];

  List<List<String>> letterGrid = [
    ['W', 'A', 'L', 'T', 'U', 'R', 'A', 'Ñ', 'M', 'S', 'J', 'M', 'I', 'G', 'J'],
    ['R', 'A', 'F', 'H', 'T', 'Ñ', 'X', 'L', 'O', 'E', 'O', 'X', 'G', 'O', 'N'],
    ['D', 'Y', 'T', 'Y', 'I', 'T', 'Y', 'T', 'M', 'I', 'R', 'U', 'Y', 'L', 'Y'],
    ['O', 'D', 'Ñ', 'G', 'Y', 'R', 'E', 'S', 'D', 'O', 'E', 'X', 'Y', 'S', 'O'],
    ['P', 'D', 'T', 'W', 'B', 'T', 'H', 'V', 'X', 'M', 'T', 'H', 'R', 'D', 'W'],
    ['O', 'M', 'W', 'B', 'A', 'U', 'G', 'F', 'J', 'U', 'A', 'D', 'B', 'K', 'W'],
    ['N', 'M', 'X', 'C', 'S', 'P', 'V', 'W', 'P', 'X', 'L', 'V', 'Z', 'C', 'I'],
    ['E', 'W', 'S', 'E', 'U', 'H', 'A', 'O', 'X', 'N', 'I', 'A', 'I', 'K', 'H'],
    ['L', 'Y', 'P', 'V', 'N', 'I', 'Ñ', 'R', 'L', 'N', 'U', 'M', 'C', 'V', 'W'],
    ['A', 'I', 'C', 'X', 'E', 'G', 'N', 'T', 'A', 'L', 'Q', 'J', 'Z', 'D', 'R'],
    ['C', 'L', 'K', 'I', 'T', 'D', 'J', 'O', 'V', 'L', 'E', 'M', 'F', 'U', 'W'],
    ['S', 'X', 'N', 'E', 'O', 'K', 'H', 'C', 'B', 'A', 'E', 'Y', 'C', 'S', 'G'],
    ['E', 'U', 'M', 'F', 'P', 'N', 'G', 'E', 'V', 'F', 'W', 'L', 'Ñ', 'P', 'E'],
    ['L', 'Y', 'R', 'O', 'I', 'I', 'A', 'N', 'G', 'U', 'L', 'O', 'O', 'G', 'S'],
    ['P', 'I', 'Ñ', 'O', 'H', 'N', 'S', 'T', 'G', 'H', 'A', 'E', 'Q', 'S', 'Q'],
    ['Ñ', 'M', 'R', 'E', 'P', 'C', 'Q', 'R', 'R', 'V', 'Y', 'Q', 'J', 'A', 'R'],
    ['O', 'E', 'I', 'G', 'Y', 'L', 'N', 'O', 'I', 'Q', 'W', 'C', 'Ñ', 'U', 'C'],
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
                'Buscar en la sopa de letras terminos como Ortocentro, Altura, Hipotenusa, Cateto, Iscoceles, Equilatero, Escaleno.');
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
            'Propiedades de triángulos y cuadrilateros',
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
                                    52, intentos, ayudas, _estadisticsController.formatMilliseconds());
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
      floatingActionButton: AyudasWidget.build(context, _estadisticsController, 13, incrementarAyudas),
      //bottomNavigationBar: MenuInferior(),
    );
  }
}

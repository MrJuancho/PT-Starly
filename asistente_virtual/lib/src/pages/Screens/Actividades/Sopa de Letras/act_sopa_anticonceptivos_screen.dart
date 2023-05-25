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

class ActSopaAnticonceptivosPage extends StatefulWidget {
  @override
  _ActSopaAnticonceptivosState createState() => _ActSopaAnticonceptivosState();
}

class _ActSopaAnticonceptivosState extends State<ActSopaAnticonceptivosPage> {
  final EstadisticsController _estadisticsController = EstadisticsController();
  bool _startPressed = false;
  bool _activityFinished = false;
  int correctas = 0;
  int intentos = 0;
  int ayudas = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  List<String> words = [
    'ANILLO',
    'CONDON',
    'DISPOSITIVO',
    'DIU',
    'IMPLANTE',
    'INYECCIONES',
    'PAE',
    'PARCHE',
    'PASTILLAS',
    'PERMANENTE',
  ];

  List<String> selectedWords = [];

  List<List<String>> letterGrid = [
    ['I', 'N', 'B', 'D', 'E', 'L', 'T', 'H', 'N', 'G', 'N', 'H', 'V', 'T', 'F', 'D'],
    ['I', 'K', 'T', 'K', 'I', 'H', 'Z', 'Q', 'A', 'K', 'T', 'O', 'Q', 'A', 'D', 'V'],
    ['V', 'H', 'M', 'J', 'H', 'Ñ', 'C', 'M', 'N', 'U', 'S', 'K', 'D', 'A', 'L', 'P'],
    ['Ñ', 'T', 'B', 'O', 'J', 'O', 'F', 'R', 'K', 'D', 'Z', 'G', 'L', 'N', 'U', 'C'],
    ['Q', 'J', 'Q', 'T', 'L', 'U', 'I', 'W', 'A', 'O', 'M', 'M', 'Ñ', 'U', 'O', 'N'],
    ['I', 'C', 'A', 'T', 'P', 'U', 'S', 'R', 'X', 'P', 'J', 'J', 'I', 'H', 'J', 'C'],
    ['I', 'O', 'F', 'E', 'V', 'A', 'M', 'Z', 'M', 'Y', 'G', 'Z', 'W', 'E', 'O', 'X'],
    ['A', 'J', 'A', 'T', 'D', 'P', 'A', 'S', 'T', 'I', 'L', 'L', 'A', 'S', 'A', 'M'],
    ['U', 'E', 'T', 'N', 'E', 'N', 'A', 'M', 'R', 'E', 'P', 'M', 'S', 'G', 'F', 'D'],
    ['U', 'F', 'B', 'X', 'I', 'A', 'A', 'E', 'I', 'D', 'P', 'M', 'A', 'J', 'E', 'I'],
    ['L', 'L', 'U', 'L', 'B', 'Z', 'S', 'Y', 'T', 'V', 'N', 'E', 'V', 'G', 'T', 'S'],
    ['L', 'W', 'L', 'T', 'Z', 'B', 'U', 'Ñ', 'V', 'A', 'X', 'M', 'Ñ', 'U', 'N', 'P'],
    ['N', 'O', 'V', 'S', 'E', 'N', 'O', 'I', 'C', 'C', 'E', 'Y', 'N', 'I', 'A', 'O'],
    ['Y', 'B', 'G', 'S', 'J', 'Y', 'U', 'Z', 'K', 'Ñ', 'U', 'X', 'F', 'T', 'L', 'S'],
    ['A', 'R', 'N', 'Y', 'R', 'A', 'N', 'I', 'G', 'O', 'Q', 'A', 'L', 'V', 'P', 'I'],
    ['B', 'Q', 'Y', 'P', 'S', 'E', 'I', 'H', 'Q', 'O', 'E', 'C', 'G', 'I', 'M', 'T'],
    ['W', 'N', 'U', 'D', 'L', 'T', 'F', 'M', 'C', 'W', 'M', 'A', 'W', 'Q', 'I', 'I'],
    ['G', 'U', 'I', 'D', 'P', 'N', 'T', 'M', 'X', 'B', 'W', 'L', 'P', 'K', 'F', 'V'],
    ['F', 'O', 'Ñ', 'G', 'E', 'V', 'J', 'S', 'V', 'R', 'M', 'L', 'P', 'X', 'C', 'O'],
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
                'Encontrar terminos relacionados a los metodos anticonceptivos en sopa de letras.');
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
            'Métodos anticonceptivos',
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
                                    60, intentos, ayudas, _estadisticsController.formatMilliseconds());
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
      floatingActionButton: AyudasWidget.build(context, _estadisticsController, 20, incrementarAyudas),
      //bottomNavigationBar: MenuInferior(),
    );
  }
}

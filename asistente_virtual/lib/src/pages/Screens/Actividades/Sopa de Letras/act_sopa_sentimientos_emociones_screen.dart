import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:flutter/material.dart';

class ActSopaSentimientosEmocionesPage extends StatefulWidget {
  @override
  _ActSopaSentimientosEmocionesState createState() => _ActSopaSentimientosEmocionesState();
}

class _ActSopaSentimientosEmocionesState extends State<ActSopaSentimientosEmocionesPage> {
  List<String> words = [
    'FLUTTER',
    'DART',
    'WIDGET',
    'MOBILE',
    'APP',
    // Agrega aquí más palabras
  ];

  List<List<String>> grid = [
    ['F', 'L', 'U', 'T', 'T', 'E', 'R'],
    ['D', 'A', 'R', 'T', 'E', 'H', 'T'],
    ['W', 'I', 'D', 'G', 'E', 'T', 'A'],
    ['M', 'O', 'B', 'I', 'L', 'E', 'A'],
    ['P', 'P', 'A', 'E', 'K', 'B', 'F'],
    // Agrega aquí más letras
  ];

  List<List<bool>> selectedCells = List.generate(
    5,
    (_) => List<bool>.filled(7, false),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sopa de Letras'),
      ),
      body: GridView.builder(
        itemCount: 35,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
        ),
        itemBuilder: (BuildContext context, int index) {
          int row = index ~/ 7;
          int col = index % 7;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCells[row][col] = !selectedCells[row][col];
              });
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: selectedCells[row][col] ? PersonalTheme.of(context).tertiary : PersonalTheme.of(context).fadedalternate,
              ),
              alignment: Alignment.center,
              child: Text(
                grid[row][col],
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        },
      ),
    );
  }
}

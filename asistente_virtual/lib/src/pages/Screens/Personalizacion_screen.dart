// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:asistente_virtual/src/pages/Controllers/Personalizacion_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuInferior_widget.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:flutter/material.dart';

class PersonalizacionPage extends StatefulWidget {
  const PersonalizacionPage({super.key});

  @override
  _PersonalizacionPageState createState() => _PersonalizacionPageState();
}

class _PersonalizacionPageState extends State<PersonalizacionPage> {
  //Controllers
  final PersonalizacionController _personalizacionController = PersonalizacionController();

  // Lista de variables booleanas para controlar la selección de botones
  final List<bool> _selections = <bool>[true, false];
  bool vertical = false;

  @override
  void initState() {
    super.initState();
    _personalizacionController.init(context, refresh);
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
        child: Center(child: _body(reducedwindowWidth, reducedwindowHeight)),
      );
    } else {
      return _body(screenWidth, screenHeight);
    }
  }

  AppBar _appbar() {
    return AppBar(
      toolbarHeight: 60,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: PersonalTheme.of(context).primaryText,
        ),
        onPressed: () {
          _personalizacionController.pantallaanterior(context);
        },
      ),
      title: Text(
        "Personalización",
        style: PersonalTheme.of(context).headlineSmall,
      ),
      centerTitle: true,
      backgroundColor: PersonalTheme.of(context).primary,
    );
  }

  Widget _body(double screenWidth, double screenHeight) {
    double wimage = (screenWidth / 2);
    double hcentecima = screenHeight / 100;
    return Scaffold(
      appBar: _appbar(),
      bottomNavigationBar: MenuInferior(),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [PersonalTheme.of(context).primary, PersonalTheme.of(context).tertiary],
                stops: const [0.0, 1.0],
                begin: const AlignmentDirectional(0.0, -1.0),
                end: const AlignmentDirectional(0, 1.0),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: hcentecima),
                      child: Center(
                        child: Image.asset(
                          'assets/images/home/AV.png',
                          width: wimage,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: hcentecima),
                      child: ToggleButtons(
                        isSelected: _selections,
                        onPressed: (index) {
                          setState(() {
                            for (int i = 0; i < _selections.length; i++) {
                              _selections[i] = i == index;
                            }
                          });
                        },
                        color: PersonalTheme.of(context).alternate,
                        fillColor: PersonalTheme.of(context).alternate,
                        selectedBorderColor: PersonalTheme.of(context).alternate,
                        children: [
                          Icon(
                            Icons.attach_money_rounded,
                            color: PersonalTheme.of(context).primaryText,
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: PersonalTheme.of(context).primaryText,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: hcentecima, bottom: hcentecima),
                      child: ConstrainedBox(
                          constraints: const BoxConstraints(),
                          child: GridView.count(
                            crossAxisCount: 3,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: List.generate(21, (index) {
                              return Container(
                                margin: const EdgeInsets.all(8),
                                color: Colors.grey[300],
                                child: Center(
                                  child: Text(
                                    'Item ${index + 1}',
                                    style: PersonalTheme.of(context).titleLarge,
                                  ),
                                ),
                              );
                            }),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}

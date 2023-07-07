// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:asistente_virtual/src/models/itemsAct.dart';
import 'package:asistente_virtual/src/pages/Controllers/Actividades_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuInferior_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuSuperior_widget.dart';
import 'package:flutter/material.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';

class ActividadesPage extends StatefulWidget {
  const ActividadesPage({super.key});

  @override
  _ActividadesPageState createState() => _ActividadesPageState();
}

class _ActividadesPageState extends State<ActividadesPage> {
  //Controllers
  final ActividadesController _actividadesController = ActividadesController();
  // Lista de variables booleanas para controlar la selección de botones
  List<dynamic> actividades = [];

  @override
  void initState() {
    super.initState();
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
        child: Center(child: carga(reducedwindowWidth, reducedwindowHeight)),
      );
    } else {
      return carga(screenWidth, screenHeight);
    }
  }

  Future<void> getInfo() async {
    actividades = await _actividadesController.actividadYRuta();
  }

  List<Item> generateItems(int numberOfItems) {
    return List<Item>.generate(numberOfItems, (int index) {
      return Item(
        id: index,
        headerValue: '${actividades[index]['nombreActividad']}',
        expandedValue: '${actividades[index]['descripcion']}',
        ruta: '${actividades[index]['Ruta']}',
      );
    });
  }

  Widget carga(double screenWidth, double screenHeight) {
    return Scaffold(
      appBar: MenuSuperior(),
      body: FutureBuilder<void>(
        future: getInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Container(
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.height * 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [PersonalTheme.of(context).primary, PersonalTheme.of(context).tertiary],
                    stops: const [0.0, 1.0],
                    begin: const AlignmentDirectional(0.0, -1.0),
                    end: const AlignmentDirectional(0, 1.0),
                  ),
                ),
                child: Center(
                  child: Text('Error al cargar las actividades', style: PersonalTheme.of(context).headlineSmall),
                ),
              );
            } else {
              return _body(screenWidth, screenHeight);
            }
          } else {
            return Container(
              width: MediaQuery.of(context).size.width * 1.0,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [PersonalTheme.of(context).primary, PersonalTheme.of(context).tertiary],
                  stops: const [0.0, 1.0],
                  begin: const AlignmentDirectional(0.0, -1.0),
                  end: const AlignmentDirectional(0, 1.0),
                ),
              ),
              child: const Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
      bottomNavigationBar: MenuInferior(),
    );
  }

  Widget _body(double screenWidth, double screenHeight) {
    final List<Item> data = generateItems(actividades.length);
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 1.0,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [PersonalTheme.of(context).primary, PersonalTheme.of(context).tertiary],
              stops: const [0.0, 1.0],
              begin: const AlignmentDirectional(0.0, -1.0),
              end: const AlignmentDirectional(0, 1.0),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: actividades.isEmpty
                ? Center(
                    child: Text(
                    'Felicidades!\nTerminaste tus actividades designadas\nRegresa al menu principal',
                    style: PersonalTheme.of(context).displayMedium,
                    textAlign: TextAlign.center,
                  ))
                : Scrollbar(
                    thumbVisibility: true,
                    scrollbarOrientation: ScrollbarOrientation.right,
                    child: SingleChildScrollView(
                      child: ExpansionPanelList.radio(
                        dividerColor: PersonalTheme.of(context).alternate,
                        expandIconColor: PersonalTheme.of(context).primaryText,
                        //initialOpenPanelValue: 0,
                        children: data.map<ExpansionPanelRadio>((Item item) {
                          return ExpansionPanelRadio(
                              backgroundColor: Colors.transparent,
                              value: item.id,
                              headerBuilder: (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text(
                                    item.headerValue,
                                    style: PersonalTheme.of(context).headlineSmall,
                                  ),
                                );
                              },
                              body: ListTile(
                                  title: Text(
                                    item.expandedValue,
                                    style: PersonalTheme.of(context)
                                        .titleLarge
                                        .override(fontFamily: 'Poppins', fontWeight: FontWeight.normal),
                                  ),
                                  //subtitle: const Text('Iniciar la actividad'),
                                  trailing:
                                      Icon(Icons.play_arrow_rounded, color: PersonalTheme.of(context).fadedalternate),
                                  onTap: () async {
                                    setState(() {
                                      Navigator.pushNamed(
                                        context,
                                        item.ruta,
                                      );
                                    });
                                  }));
                        }).toList(),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

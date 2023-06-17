// ignore_for_file: file_names

import 'package:asistente_virtual/src/pages/Controllers/Estadistics_controller.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:flutter/material.dart';

class InstruccionesWidget {
  static Widget show(BuildContext context, EstadisticsController estadisticsController, Function press,
      String instrucciones, double screenWidth, double screenHeight) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: PersonalTheme.of(context).primary,
        ),
        Center(
          child: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Material(
              color: PersonalTheme.of(context).primary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Instrucciones', style: PersonalTheme.of(context).displaySmall),
                  const SizedBox(height: 30),
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Text(instrucciones,
                        textAlign: TextAlign.justify, style: PersonalTheme.of(context).headlineMedium),
                  )),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          //agregar a que pestaña se regresa (probablemente a la de actividades)
                          estadisticsController.regreso(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[400],
                        ),
                        child: const Text('Regresar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          press();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text('Iniciar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

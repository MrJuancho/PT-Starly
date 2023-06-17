// ignore_for_file: file_names

import 'package:asistente_virtual/src/pages/Controllers/_menuInferior_controller.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:flutter/material.dart';

class MenuInferior extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  MenuInferior({Key? key, this.height = kToolbarHeight}) : super(key: key);
  final MenuInferiorController _menuInferiorController = MenuInferiorController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    
    return BottomAppBar(
      elevation: 8,
      notchMargin: 4,
      shadowColor: PersonalTheme.of(context).primary,
      height: screenWidth >= 450 ? 70 : 50,
      surfaceTintColor: PersonalTheme.of(context).primary,
      color: PersonalTheme.of(context).tertiary,
      child: Center(
        child: SizedBox(
          width: screenWidth >=450? 500:screenWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                child: Row(
                  children: [
                    Icon(
                      Icons.videogame_asset_rounded,
                      color: PersonalTheme.of(context).primaryText,
                    ),
                    const SizedBox(width: 10),
                    Text('Actividades', style: PersonalTheme.of(context).titleMedium),
                  ],
                ),
                onPressed: () {
                  if (ModalRoute.of(context)?.settings.name != 'actividades') {
                    _menuInferiorController.actividades(context);
                  }
                },
              ),
              ElevatedButton(
                // Utilizamos ElevatedButton en lugar de TextButton
                style: ElevatedButton.styleFrom(
                  elevation: 8, // Controla la elevación del botón
                  shape: const CircleBorder(eccentricity: 0),
                  backgroundColor: PersonalTheme.of(context).alternate, // Color de fondo del botón
                  foregroundColor: PersonalTheme.of(context).fadedalternate, // Color del texto del botón
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.house_rounded,
                    color: PersonalTheme.of(context).primaryText,
                  ),
                ),
                onPressed: () {
                  if (ModalRoute.of(context)?.settings.name != 'home') {
                    _menuInferiorController.home(context);
                  }
                },
              ),
              TextButton(
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      color: PersonalTheme.of(context).primaryText,
                    ),
                    const SizedBox(width: 10),
                    Text('Registro Diario', style: PersonalTheme.of(context).titleMedium),
                  ],
                ),
                onPressed: () {
                  if (ModalRoute.of(context)?.settings.name != 'registroDiario') {
                    _menuInferiorController.registroDiario(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

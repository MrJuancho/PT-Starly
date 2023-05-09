import 'package:asistente_virtual/src/pages/Controllers/_menuSuperior_controller.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';
import 'package:flutter/material.dart';

class MenuSuperior extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final UtilsSharedPref _sharedPref = UtilsSharedPref();
  final MenuSuperiorController _menuSuperiorController =
      MenuSuperiorController();

  MenuSuperior({Key? key, this.height = kToolbarHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,

      centerTitle: false,
      titleSpacing: 0,
      //backgroundColor: UtilsColors.primaryColor,
      title: Transform(
        transform: Matrix4.translationValues(0, 0, 0),
        child: TextButton.icon(
          onPressed: () {
            if (ModalRoute.of(context)?.settings.name != 'tareasdiarias') {
              _menuSuperiorController.tareasDiarias(context);
            }
          },
          icon: Icon(Icons.checklist_rounded,
              color: PersonalTheme.of(context).primaryText),
          //SizedBox(width: 10),
          label: Text(
            'Tareas Diarias',
            style: TextStyle(color: PersonalTheme.of(context).primaryText),
          ),
        ),
      ),
      actions: [
        FutureBuilder(
          future: _menuSuperiorController.stars(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Row(
                children: [
                  const Icon(Icons.star_rounded),
                  const SizedBox(width: 1),
                  Text(snapshot.data),
                  const SizedBox(width: 10),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        FutureBuilder(
          future: _menuSuperiorController.coins(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Row(
                children: [
                  const Icon(Icons.attach_money_rounded),
                  const SizedBox(width: 0),
                  Text(snapshot.data),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        IconButton(
            tooltip: 'Cerrar Sesión',
            onPressed: () {
              showModal(context);
            },
            icon: const Icon(Icons.exit_to_app_rounded)),
      ],
      backgroundColor: PersonalTheme.of(context).primary,
    );
  }

  void showModal(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: PersonalTheme.of(context).primaryText,
        title: Text(
          'Cerrar Sesión',
          style: PersonalTheme.of(context).titleLarge.override(
                color: PersonalTheme.of(context).primary,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
        ),
        content: Text(
          "¿Esta seguro de que desea cerrar sesión?",
          style: PersonalTheme.of(context).titleMedium.override(
                color: PersonalTheme.of(context).primary,
                fontFamily: 'Poppins',
              ),
          textAlign: TextAlign.justify,
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: PersonalTheme.of(context).titleSmall.override(
                      color: PersonalTheme.of(context).primary,
                      fontFamily: 'Poppins',
                    ),
              )),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _sharedPref.logout(context);
            },
            child: Text(
              'Cerrar Sesión',
              style: PersonalTheme.of(context).titleSmall.override(
                    color: PersonalTheme.of(context).primary,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

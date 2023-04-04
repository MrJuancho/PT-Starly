import 'package:asistente_virtual/src/pages/Controllers/_menuSuperior_controller.dart';
import 'package:flutter/material.dart';
import 'package:asistente_virtual/src/utils/utils_colors.dart';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';

class MenuSuperior extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final UtilsSharedPref _sharedPref = UtilsSharedPref();
  final MenuSuperiorController _menuSuperiorController =
      MenuSuperiorController();

  MenuSuperior({Key? key, this.height = kToolbarHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      titleSpacing: 0,
      //backgroundColor: UtilsColors.primaryColor,
      title: Transform(
        transform: Matrix4.translationValues(0, 0, 0),
        child: TextButton.icon(
          onPressed: () {
            _menuSuperiorController.tareasDiarias(context);
          },
          icon: const Icon(Icons.checklist_rounded),
          //SizedBox(width: 10),
          label: const Text('Tareas Diarias'),
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
              _sharedPref.logout(context);
            },
            icon: const Icon(Icons.exit_to_app_rounded)),
      ],
      backgroundColor: UtilsColors.primaryColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

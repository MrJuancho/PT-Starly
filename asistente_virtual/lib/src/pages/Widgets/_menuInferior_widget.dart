import 'package:asistente_virtual/src/pages/Controllers/_menuInferior_controller.dart';
import 'package:flutter/material.dart';
import '../../utils/utils_colors.dart';

class MenuInferior extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  MenuInferior({Key? key, this.height = kToolbarHeight}) : super(key: key);
  final MenuInferiorController _menuInferiorController = MenuInferiorController();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: UtilsColors.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            child: Row(
              children: [
                const Icon(Icons.videogame_asset_rounded),
                const SizedBox(width: 10),
                const Text('Actividades'),
              ],
            ),
            onPressed: () {
              _menuInferiorController.actividades(context);
            },
          ),
          //Spacer(),

          TextButton(
            child: Row(
              children: [
                const Icon(Icons.calendar_today_rounded),
                const SizedBox(width: 10),
                const Text('Registro Diario'),
              ],
            ),
            onPressed: () {
              _menuInferiorController.registroDiario(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

import 'package:asistente_virtual/src/pages/Controllers/_menuInferior_controller.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:flutter/material.dart';

class MenuInferior extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  MenuInferior({Key? key, this.height = kToolbarHeight}) : super(key: key);
  final MenuInferiorController _menuInferiorController =
      MenuInferiorController();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: PersonalTheme.of(context).tertiary,
      child: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              child: Row(
                children: [
                  Icon(Icons.videogame_asset_rounded,color: PersonalTheme.of(context).primaryText,),
                  const SizedBox(width: 10),
                  Text('Actividades',style: TextStyle( color: PersonalTheme.of(context).primaryText)),
                ],
              ),
              onPressed: () {
                if(ModalRoute.of(context)?.settings.name !='actividades'){
                  _menuInferiorController.actividades(context);
                }
                
              },
            ),
            //Spacer(),

            TextButton(
              child: Row(
                children: [
                  Icon(Icons.calendar_today_rounded,color: PersonalTheme.of(context).primaryText,),
                  const SizedBox(width: 10),
                  Text('Registro Diario',style: TextStyle( color: PersonalTheme.of(context).primaryText)),
                ],
              ),
              onPressed: () {
                if(ModalRoute.of(context)?.settings.name !='registroDiario'){
                  _menuInferiorController.registroDiario(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

import 'package:flutter/material.dart';
import 'package:asistente_virtual/src/utils/utils_colors.dart';

class MenuSuperior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_circleLogin(context), _text()],
    );
  }

  Widget _buttonActividades() {
    return IconButton(
      onPressed: (){

      },
      icon: Icon(Icons.checklist_rounded),
    );
  }

  Widget _text() {
    return Positioned(
      child: Text(
        'Prueba de menu',
        //agregar estilos al texto
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontFamily: 'NimbusSans'),
      ),
      top: 40,
      left: 25,
    );
  }

  Widget _circleLogin(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(0),
          color: UtilsColors.primaryColor),
    );
  }
}

import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:flutter/material.dart';
import '../Controllers/_botonesFlotantes_controller.dart';

class BotonesFlotantes extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  BotonesFlotantes({Key? key, this.height = kToolbarHeight}) : super(key: key);
  final BotonesFlotantesController _botonesFlotantesController =
      BotonesFlotantesController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),

      //padding: EdgeInsets.fromLTRB(w * 0.1, 5, w*0.001, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            backgroundColor: PersonalTheme.of(context).primaryText,
            foregroundColor: PersonalTheme.of(context).tertiary,
            onPressed: () {
              _botonesFlotantesController.personalizacion(context);
            },
            heroTag: null,
            child: const Icon(Icons.checkroom_rounded),
          ),
          FloatingActionButton(
              backgroundColor: PersonalTheme.of(context).primaryText,
              foregroundColor: PersonalTheme.of(context).tertiary,
              onPressed: () {
                if(ModalRoute.of(context)?.settings.name !='actividades'){
                  _botonesFlotantesController.actividades(context);
                }
              },
              heroTag: null,
              child: const Icon(Icons.star))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

import 'package:flutter/material.dart';
import '../../utils/utils_colors.dart';
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
            backgroundColor: UtilsColors.primaryBackgroundColor,
            foregroundColor: UtilsColors.primaryColorDark,
            onPressed: () {
              _botonesFlotantesController.personalizacion(context);
            },
            heroTag: null,
            child: const Icon(Icons.checkroom_rounded),
          ),
          FloatingActionButton(
              backgroundColor: UtilsColors.primaryBackgroundColor,
              foregroundColor: UtilsColors.primaryColorDark,
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
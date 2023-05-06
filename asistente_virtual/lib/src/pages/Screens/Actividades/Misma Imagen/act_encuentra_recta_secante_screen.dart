import 'package:asistente_virtual/src/pages/Controllers/Actividades/SameImage_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuSuperior_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../../utils/utils_preferences.dart';
import '../../../Widgets/_menuInferior_widget.dart';
import '../../../flutter_flow/Theme_Personal.dart';

class ActEncuentraRectaSecantePage extends StatefulWidget {
  const ActEncuentraRectaSecantePage({
    Key? key,
    String? counter,
  })  : this.counter = counter ?? '0',
        super(key: key);

  final String counter;

  @override
  _ActEncuentraRectaSecanteWidgetState createState() =>
      _ActEncuentraRectaSecanteWidgetState();
}

class _ActEncuentraRectaSecanteWidgetState
    extends State<ActEncuentraRectaSecantePage> {

  final SameImageController _sameImageController = SameImageController();
  bool _startPressed = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _sameImageController.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _startPressed ? _actividad(context) : _popup(context);
  }

  Widget _popup(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: PersonalTheme.of(context).primary,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Instrucciones', style: PersonalTheme.of(context).displaySmall),
          SizedBox(height: 30),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Text(
                'Se muestran una variedad de rectas paralelas, perpendiculares y secantes; Deberas encontrar la que es igual.',
                textAlign: TextAlign.justify,
                style: PersonalTheme.of(context).headlineMedium),
          )),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  //agregar a que pestaña se regresa (probablemente a la de actividades)

                },
                child: Text('Regresar'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[400],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  //Navigator.of(context).pop();
                  setState(() {
                    _startPressed = true;
                  });

                },
                child: Text('Iniciar'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actividad(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: PersonalTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: PersonalTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Encuentra la recta secante',
            style: PersonalTheme.of(context).headlineMedium.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          child: Visibility(
            visible: responsiveVisibility(
              context: context,
              tablet: false,
              tabletLandscape: false,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1.0,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          PersonalTheme.of(context).primary,
                          PersonalTheme.of(context).tertiary
                        ],
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(0.0, -1.0),
                        end: AlignmentDirectional(0, 1.0),
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1.0,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Stack(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1.0, -1.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_034003542.png',
                                    width: 100.0,
                                    height: 100.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-0.33, -1.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_034346758.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.33, -1.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_034622280.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-0.68, -0.66),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_040258977.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(1.0, -1.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_035940804.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, -0.66),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_112933406.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.68, -0.66),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113024669.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.03),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113644786.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(1.0, -0.32),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113305908.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-0.33, -0.32),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113349611.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.33, -0.32),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113424570.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-0.68, 0.03),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113518301.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.0, -0.32),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113104570.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.68, 0.03),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113725228.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.35),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113807413.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-0.33, 0.35),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113837837.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.33, 0.35),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113917513.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(1.0, 0.35),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_113947706.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-0.68, 0.68),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_114056401.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.68),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_114227250.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.68, 0.68),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_114215515.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.04, 1.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_115537831.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-0.33, 1.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_115602377.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.33, 1.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    /*FFAppState().contadorIntentos =
                                        FFAppState().contadorIntentos + 1;*/
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_115728143.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(1.0, 1.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  setState(() {
                                    _sameImageController.stopTimer();
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/Actividades/Misma_Imagen/Act_Encuentra_Recta_Secante/imagen_2023-04-30_115744199.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1.0,
                    height: MediaQuery.of(context).size.height * 0.12,
                    decoration: BoxDecoration(
                      color: PersonalTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(20.0),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Color(0x00E21C3D),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Estadisticas',
                              style: PersonalTheme.of(context).titleLarge,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'Intentos:',
                                  style: PersonalTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  /*valueOrDefault<String>(
                                    FFAppState().contadorIntentos.toString(),
                                    '0',
                                  ),*/
                                  "Hola",
                                  style: PersonalTheme.of(context).bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'Asistencias',
                                  style: PersonalTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  /*valueOrDefault<String>(
                                    FFAppState().contadorIntentos.toString(),
                                    '0',
                                  ),*/
                                  "Hola",
                                  style: PersonalTheme.of(context).bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'Tiempo:',
                                  style: PersonalTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 0.0, 0.0),
                                  child: const Text(
                                      'señora de los gatos') /*FlutterFlowTimer(
                                  initialTime: _actEncuentraRectaSecanteController.timerMilliseconds,
                                  getDisplayTime: (value) =>
                                      StopWatchTimer.getDisplayTime(
                                        value,
                                        hours: false,
                                      ),
                                  timer: _actEncuentraRectaSecanteController.timerController,
                                  updateStateInterval:
                                  Duration(milliseconds: 1000),
                                  onChanged:
                                      (value, displayTime, shouldUpdate) {
                                        */ /*_actEncuentraRectaSecanteController.timerMilliseconds = value;
                                    _actEncuentraRectaSecanteController.timerValue = displayTime;*/ /*
                                    if (shouldUpdate) setState(() {});
                                  },
                                  textAlign: TextAlign.start,
                                  style: PersonalTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Poppins',
                                    color: PersonalTheme.of(context)
                                        .primaryText,
                                  ),
                                ),*/
                                  ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //bottomNavigationBar: MenuInferior(),
      ),
    );
  }
}

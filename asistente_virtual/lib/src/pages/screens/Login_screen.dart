import 'package:asistente_virtual/src/pages/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../flutter_flow/Theme_Personal.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController _loginController = new LoginController();

  // sobreescribe y lo primero que se ejecuta al abrir la app
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //método para iniciar controlador
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _loginController.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
        Container(
          width: MediaQuery.of(context).size.width * 1.0,
          height: MediaQuery.of(context).size.height * 1,
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
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: PersonalTheme.of(context).primaryText,
            ),
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Método para recuperar email
                Text(
                  'Inicio de Sesión',
                  style: PersonalTheme.of(context).displaySmall.override(
                        color: PersonalTheme.of(context).primary,
                        fontFamily: 'Poppins',
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                _txtFUsername(),

                const SizedBox(
                  height: 30,
                ),

                //Método para recuperar pw
                _txtFPW(),

                const SizedBox(
                  height: 30,
                ),
                //Método para recuperar botón login
                _btnLogin(),
              ],
            ),
          ),
        ),
      ]),
      resizeToAvoidBottomInset: false,
    );
  }

  //widget botón login
  Widget _btnLogin() {
    //para alargar un componente widget puede agruparse en un container
    return Container(
      //margen de la pantalla
      width: double.infinity,
      //agregar margen en los espacios horizontales y entre componentes
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        //método login desde controlador
        onPressed: _loginController.login,
        child: Text(
          'Ingresar',
          style: TextStyle(color: PersonalTheme.of(context).primaryText),
        ),
        //estilos al botón
        style: ElevatedButton.styleFrom(
            //cambiar color al botón
            primary: PersonalTheme.of(context).alternate,
            //modificar la forma del botón
            shape: RoundedRectangleBorder(
                //número de pixeles
                borderRadius: BorderRadius.circular(30)),
            //agregar padding vertical / horizointal
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  //widget campo email
  Widget _txtFUsername() {
    return Container(
      //márgenes a los espacios horizontales
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      //agregar decoraciones al container como color, forma, etc
      decoration: BoxDecoration(
        //color del box
        color: PersonalTheme.of(context).fadedalternate,
        //radio del box
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        style: TextStyle(color: PersonalTheme.of(context).primary),
        //para indicar que el manejador del texto será el emailController
        controller: _loginController.usernameCtrller,
        //cambiar el tipo de teclado a correo
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            hintText: 'Nombre de Usuario',
            //quitamos línea inferior
            border: InputBorder.none,
            //agregamos espacio para que no esté pegado al borde
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: PersonalTheme.of(context).primary),
            prefixIcon: Icon(
              Icons.person,
              color: PersonalTheme.of(context).primaryBackground,
            )),
      ),
    );
  }

  //widget campo password
  Widget _txtFPW() {
    return Container(
      //márgenes a los espacios horizontales
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      //agregar decoraciones al container como color, forma, etc
      decoration: BoxDecoration(
        //color del box
        color: PersonalTheme.of(context).fadedalternate,
        //radio del box
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        style: TextStyle(color: PersonalTheme.of(context).primary),
        //para indicar que el manejador del texto será el pwController
        controller: _loginController.passCtrller,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Contraseña',
            //quitamos línea inferior
            border: InputBorder.none,

            //agregamos espacio para que no esté pegado al borde
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: PersonalTheme.of(context).primary),
            prefixIcon: Icon(
              Icons.lock,
              color: PersonalTheme.of(context).primaryBackground,
            )),
      ),
    );
  }

  //widget círuclo superior login
  Widget _circleLogin() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(0),
          color: PersonalTheme.of(context).primary),
    );
  }
}

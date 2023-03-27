import 'package:asistente_virtual/src/login/login_controller.dart';
import 'package:asistente_virtual/src/utils/utils_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
        body: Container(
      width: double.infinity,
      child: Stack(
        children: [
          //permite ubicar elemento donde se desee
          //negativo para que desaparezca
          Positioned(
              top: -90,
              //left: -100,
              //Método para recuperar imagen circular
              child: _circleLogin()),
          Positioned(
            child: _txtLogin(),
            top: 60,
            left: 25,
          ),
          //Para hacer scroll en la pantalla
          Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Método para recuperar email
                    _txtFEmail(),
                    //Método para recuperar pw
                    _txtFPW(),
                    //Método para recuperar botón login
                    _btnLogin(),
                  ],
                ),
              ),
          ),
        ],
      ),
    ));
  }

  

  //Widget texto login
  Widget _txtLogin() {
    //se retorna un texto
    return Text(
      'Login',
      //agregar estilos al texto
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          fontFamily: 'NimbusSans'),
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
        child: Text('Ingresar'),
        //estilos al botón
        style: ElevatedButton.styleFrom(
            //cambiar color al botón
            primary: UtilsColors.primaryColor,
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
  Widget _txtFEmail() {
    return Container(
      //márgenes a los espacios horizontales
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      //agregar decoraciones al container como color, forma, etc
      decoration: BoxDecoration(
        //color del box
        color: UtilsColors.primaryOpacityColor,
        //radio del box
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        //para indicar que el manejador del texto será el emailController
        controller: _loginController.emailCtrller,
        //cambiar el tipo de teclado a correo
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Correo electrónico',
            //quitamos línea inferior
            border: InputBorder.none,
            //agregamos espacio para que no esté pegado al borde
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: UtilsColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.email,
              color: UtilsColors.primaryColor,
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
        color: UtilsColors.primaryOpacityColor,
        //radio del box
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        //para indicar que el manejador del texto será el pwController
        controller: _loginController.passCtrller,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Contraseña',
            //quitamos línea inferior
            border: InputBorder.none,
            //agregamos espacio para que no esté pegado al borde
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: UtilsColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.lock,
              color: UtilsColors.primaryColor,
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
          color: UtilsColors.primaryColor),
    );
  }

}

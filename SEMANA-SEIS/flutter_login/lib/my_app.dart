import 'package:flutter/material.dart';
import 'login_service.dart';
import 'package:flutter_login/login.dart';
import 'package:flutter_login/vista_uno.dart';

class MyApp extends StatelessWidget {
  final LoginService _loginService = LoginService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: _loginService.isLogged(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const VistaUno()),
              );
            });
            return Container(); 
          } else {
            return const Login();
          }
        },
      ),
    );
  }
}

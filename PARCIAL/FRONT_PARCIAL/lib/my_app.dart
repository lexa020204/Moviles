import 'package:flutter/material.dart';
import 'package:flutter_login/productos/lista.dart';
import 'login/login_service.dart';
import 'package:flutter_login/login/login.dart';


class MyApp extends StatelessWidget {
  final LoginService _loginService = LoginService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<bool>(
        future: _loginService.isLogged(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {

            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Lista()),
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


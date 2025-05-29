import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_service.dart';
import 'package:flutter_login/login.dart';


class MyApp extends StatelessWidget {
  final LoginService _loginService = LoginService();

  MyApp({super.key});

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
              Get.toNamed('/vistauno');
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

import 'package:flutter/material.dart';
import 'package:flutter_login/login_service.dart';
import 'package:flutter_login/login.dart';

ButtonStyle buttonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.purple,
    textStyle: const TextStyle(
      fontSize: 15,
    ),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

class VistaUno extends StatelessWidget {
 
  const VistaUno({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
            child: Container(
      margin: const EdgeInsets.all(10),
      height: 400,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.purple, width: 2),
      ),
      padding: const EdgeInsets.all(20),
      child:   Column(
        children: [
          const Text(
            'Bienvenido, Estas en el sistema', 
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          ElevatedButton(onPressed: () async{
            await LoginService().removeToken();
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
          },
           child: const Text('Cerrar Sesión'))
        ],
      ),
    )));
  }
  }


import 'package:flutter_login/vista_uno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/login_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String sUsuario = '';
  String sContrasena = '';
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),

        body: Center(
          child: Container(
            margin: const EdgeInsets.all(10),
            width: 300,
            child: Column(
              children: [
                const FittedBox(
                  child: FlutterLogo(
                    size: 200,
                    style: FlutterLogoStyle.horizontal,
                  ),      
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      sUsuario = text;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Usuario',
                  ),
                ),
                const SizedBox(height: 20),

                TextField(
                  onChanged: (text) {
                    setState(() {
                      sContrasena = text;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                  ),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    textStyle: const TextStyle(
                      fontSize: 15,
                    ),
                    foregroundColor: Colors.white,
                   
                  ),
                  onPressed: () async {
                    final success = await LoginService().enviarInfo(sUsuario, sContrasena);
                    if(success){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const VistaUno()),
                      );
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Usuario o contraseña incorrectos'),
                        ),
                      );
                    }
                  },
                  child: const Text('Ingresar'),
                ),

                
              ],
            ),
          ),
        ),
      );
  }
}

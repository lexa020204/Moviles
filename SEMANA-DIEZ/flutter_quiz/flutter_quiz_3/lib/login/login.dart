
//import 'package:flutter_quiz_3/productos/lista.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:flutter_quiz_3/login/login_service.dart';

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
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
          backgroundColor: Colors.purple[300],
          foregroundColor: Colors.white,
        ),

        body: Center(
          child: Container(
            margin: const EdgeInsets.all(10),
            width: 300,
            height: 500,
            child: Column(
              children: [
                /*const Image(
                  image: AssetImage('assets/Groove.png'),
                  width: 200,),
                */
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
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                  ),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[300],
                    textStyle: const TextStyle(
                      fontSize: 15,
                    ),
                    foregroundColor: Colors.white,
                   
                  ),
                  onPressed: () {Get.toNamed('/habHuella');},/*async {
                    final success = await LoginService().enviarInfo(sUsuario, sContrasena);
                    if(success){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Lista()),
                      );
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Usuario o contraseña incorrectos'),
                        ),
                      );
                    }
                  },*/
                  child: const Text('Ingresar'),
                ),

                
              ],
            ),
          ),
        ),
      
    );
  }
}

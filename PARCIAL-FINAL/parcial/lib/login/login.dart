import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial/firebase_service.dart';
import 'package:parcial/login/login_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  
  ButtonStyle styleButton = ElevatedButton.styleFrom(
    fixedSize: const Size(300,30),
      backgroundColor: Colors.purple,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8), // Bordes cuadrados
      ),
      textStyle: const TextStyle(
        fontSize: 15,
      ),
      foregroundColor: Colors.white,
  );

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? fcmToken;

  @override
  void initState() {
    super.initState();
    _initializeFcmToken();
  }

  Future<void> _initializeFcmToken() async {
    fcmToken = await FirebaseService().getToken();
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
          backgroundColor: Colors.purple[300],
          foregroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),

        body: Center(
          child: Container(
            margin: const EdgeInsets.all(10),
            width: 300,
            height: 500,
            child: Column(
              children: [
                 Icon(
            Icons.mail_outlined,
            size: 100, // Puedes ajustar el tamaño del ícono
            color: Colors.purple[300], // Puedes cambiar el color del ícono
          ),
            const SizedBox(height: 20),
                TextField( 
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Correo Electrónico",
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 20),
            TextField( 
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Contraseña",
                border: OutlineInputBorder()
              ),
            ),
                const SizedBox(height: 20),

                ElevatedButton(
                  style: styleButton,
                  onPressed: () async {
                    final success = await LoginService().enviarInfo(
                      _emailController.text,
                      _passwordController.text,
                      fcmToken.toString()
                    );
                    if(success){
                      Get.toNamed('/menu'
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
                const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('¿No tienes Cuenta?'),
                TextButton(
                  onPressed: () {
                   Get.toNamed('/register');
                  },
                  child: const Text('Registrate'),
                )
              ],
            )

                
              ],
            ),
          ),
        ),
      
    );
  }
}
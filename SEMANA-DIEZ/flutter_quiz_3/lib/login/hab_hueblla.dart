import 'package:flutter/material.dart';
import 'package:flutter_quiz_3/login/auth_service.dart';
import 'package:get/get.dart';

class HabHueblla extends StatefulWidget {
  const HabHueblla({super.key});

  @override
  State<HabHueblla> createState() => _HabHuebllaState();
}

class _HabHuebllaState extends State<HabHueblla> {
  String sUsuario = '';
  String sContrasena = '';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Habilitar Huella'),
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
                const Text('Habilitar inicio de sesión con Huella'),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[300],
                    textStyle: const TextStyle(
                      fontSize: 15,
                    ),
                    foregroundColor: Colors.white,
                   
                  ),
                  onPressed: () async {
                    final authService = AuthService();
                  final autenticacion = await authService.autenticar();
                  if (autenticacion) {
                    Get.dialog(AlertDialog(
                      title: const Text('Confirmar inicio de sesión con Huella'),
                      content: Column(children: [
                        TextField(
                          textCapitalization: TextCapitalization.none,
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
                  textCapitalization: TextCapitalization.none,
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
                  onPressed: () async {
                    final authService = AuthService();
                    final enviado = await authService.enviarDatos(sUsuario, sContrasena);
                    if(enviado){
                      
                      Get.snackbar('Habilitar Huella', 'Habilitado correctamente');
                      await Future.delayed(const Duration(seconds: 3));
                      Get.toNamed('/login'); // Navega a la página '/menu'
                      
                    }
                    else{
                      Get.snackbar('Habilitar Huella', 'Error al habilitar');
                    }
                  }, 
                  child: const Text('Habilitar')),
                      ],),
                    ));
                  }
                  },
                  child: const Text('Habilitar'),
                ),
                const SizedBox(height: 20),
               
                
              ],
            ),
          ),
        ),
    );
  }
}
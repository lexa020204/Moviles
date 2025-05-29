
//import 'package:flutter_quiz_3/productos/lista.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_3/login/auth_service.dart';
import 'package:get/get.dart';
import 'package:flutter_quiz_3/login/login_service.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final authService = AuthService();
  String sUsuario = '';
  String sContrasena = '';
  String huella = '';

  ButtonStyle styleButton  = ElevatedButton.styleFrom(
    fixedSize: const Size(250,30),
      backgroundColor: Colors.purple[300],
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8), // Bordes cuadrados
      ),
      textStyle: const TextStyle(
        fontSize: 15,
      ),
      foregroundColor: Colors.white,
  );
  
  @override
  void initState() {
    super.initState();
    _checkHuella();
  }
  
  Future<void> _checkHuella() async {
    huella = await AuthService().readToken();
    setState(() {});
  }


  @override
  
 
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
                /*const Image(
                  image: AssetImage('assets/Groove.png'),
                  width: 200,),
                */
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
                  style: styleButton,
                  onPressed: () async {
                    final success = await LoginService().enviarInfo(sUsuario, sContrasena);

                    if(success){
                      if(huella.isNotEmpty){
                        Get.toNamed('/menu');
                      }
                      else{
                        Get.toNamed('/habHuella');
                      }
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
                const SizedBox(height: 15),

                if (huella.isNotEmpty)
                OutlinedButton(style: OutlinedButton  .styleFrom(
                  fixedSize: const Size(250,30),
                    backgroundColor:  Colors.white,
                    shape:  RoundedRectangleBorder(
                    
                    borderRadius: BorderRadius.circular(8), // Bordes cuadrados
                    ),
                    side: BorderSide(
                        color: Colors.purple[300]!, // Color del borde
                        width: 2, // Ancho del borde
                      ),
                    textStyle: const TextStyle(
                      fontSize: 15,
                    ),
                    foregroundColor:Colors.purple[300],
                   
                  ),
                  onPressed: () async {
                  final autenticacion = await authService.autenticar();
                  if (autenticacion) {
                    final prefs = await authService.readToken();
                    if(prefs.isNotEmpty){
                      final validacion = await authService.enviarToken(prefs);
                      if(validacion){
                        Get.toNamed('/menu');
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error en la autenticación'),
                          ),
                        );
                      }
                    }
                  }
                  }, child: const Text('Iniciar sesión con huella')),
                 const SizedBox(height: 15),

                if (huella.isNotEmpty)
                 ElevatedButton(
                  style: styleButton,
                  onPressed: ()  async {
                    final autenticar = await authService.autenticar();
                    if(autenticar){
                      final eliminar = await authService.removeToken();
                      if(eliminar){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Inicio con huella deshabilitado'),
                      ),
                    );
                    _checkHuella();
                  }
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error en deshabilitar inicio con huella'),
                        ),
                      );
                    }
                    
                  
                  
                  }, child: const Text('Deshabilitar Inicio con huella')),


                
              ],
            ),
          ),
        ),
      
    );
  }
}

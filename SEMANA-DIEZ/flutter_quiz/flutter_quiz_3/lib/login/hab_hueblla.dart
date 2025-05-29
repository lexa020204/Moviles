import 'package:flutter/material.dart';

class HabHueblla extends StatefulWidget {
  const HabHueblla({super.key});

  @override
  State<HabHueblla> createState() => _HabHuebllaState();
}

class _HabHuebllaState extends State<HabHueblla> {
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
                  onPressed: () {},/*async {
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
                  child: const Text('Habilitar'),
                ),

                
              ],
            ),
          ),
        ),
    );
  }
}
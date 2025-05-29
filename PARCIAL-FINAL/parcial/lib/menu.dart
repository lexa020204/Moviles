import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial/login/login_service.dart';

// ignore: must_be_immutable
class Menu extends StatelessWidget {
   Menu({super.key});

  ButtonStyle styleButton  = ElevatedButton.styleFrom(
    fixedSize: const Size(120,30),
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
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Menú Principal'),
          backgroundColor: Colors.purple[300],
          foregroundColor: Colors.white,
           automaticallyImplyLeading: false,
         actions: [
            IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async{
              final success = await LoginService().logout();
              if (success) {
                Get.toNamed('/login');
              }
            },
          ),
          ],
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(10),
      height: 300,
      width: 300,
      padding: const EdgeInsets.all(20),
            child: Column(children: [
              const Icon(
                Icons.person, 
                size: 50, // Tamaño del ícono
                color: Colors.purple, // Color del ícono
              ),
              ElevatedButton(style: styleButton,onPressed: () {Get.toNamed('/usuarios');}, child: const Text('Usuarios')),
              const SizedBox(height: 20),
              const Icon(
                Icons.message, // Ícono de porcentaje
                size: 50, // Tamaño del ícono
                color: Colors.purple, // Color del ícono
              ),
              ElevatedButton(style: styleButton,onPressed: ()  {Get.toNamed('/mensajes');}, child: const Text('Mensajes')),
            ],),
          ),
        ),
      );
    
  }
}
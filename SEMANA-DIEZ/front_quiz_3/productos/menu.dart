import 'package:flutter/material.dart';
import 'package:flutter_quiz_3/login/login_service.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Menu extends StatelessWidget {
   Menu({super.key});

  final loginService = LoginService();

  ButtonStyle styleButton  = ElevatedButton.styleFrom(
    fixedSize: const Size(110,30),
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
              await loginService.removeToken();
              Get.offAllNamed('/login');
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
                Icons.shopping_cart, // Ícono de carrito de compras
                size: 50, // Tamaño del ícono
                color: Colors.purple, // Color del ícono
              ),
              ElevatedButton(style: styleButton,onPressed: () {Get.toNamed('/articulos');}, child: const Text('Articulos')),
              const SizedBox(height: 20),
              const Icon(
                Icons.local_offer, // Ícono de porcentaje
                size: 50, // Tamaño del ícono
                color: Colors.purple, // Color del ícono
              ),
              ElevatedButton(style: styleButton,onPressed: ()  {Get.toNamed('/ofertas');}, child: const Text('Ofertas')),
            ],),
          ),
        ),
      );
    
  }
}
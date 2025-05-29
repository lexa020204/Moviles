import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parcial/firebase_options.dart';
import 'package:get/get.dart';
import 'package:parcial/firebase_service.dart';
import 'package:parcial/login/login.dart';
import 'package:parcial/menu.dart';
import 'package:parcial/mesajes/lista_mensajes.dart';
import 'package:parcial/registro/registro.dart';
import 'package:parcial/usuarios/detalle_usuario.dart';
import 'package:parcial/usuarios/lista_usuario.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseService().init();

 
  runApp(GetMaterialApp(
    initialRoute: '/login',
    getPages: [
      GetPage(name: '/register', page: () => Registro()),
      GetPage(name: '/login', page: () => Login()),
      GetPage(name: '/usuarios', page: () => const ListaUsuario()),
      GetPage(name: '/detalle', page: () => DetalleUsuario()),
      GetPage(name: '/menu', page: () => Menu()),
      GetPage(name: '/mensajes', page: () => ListaMensajes()),
      
    ],
  ));
}

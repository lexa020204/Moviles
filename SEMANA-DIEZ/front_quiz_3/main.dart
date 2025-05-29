import 'package:flutter/material.dart';
import 'package:flutter_quiz_3/login/hab_hueblla.dart';
import 'package:flutter_quiz_3/login/login.dart';
import 'package:flutter_quiz_3/productos/articulos.dart';
import 'package:flutter_quiz_3/productos/menu.dart';
import 'package:flutter_quiz_3/productos/ofertas.dart';
import 'package:get/get.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  
  runApp(GetMaterialApp(
    initialRoute: '/login',
    getPages: [
      GetPage(name: '/login', page: () => const Login()),
      GetPage(name: '/habHuella', page: () => const HabHueblla()),
      GetPage(name: '/menu', page: () => Menu()),
      GetPage(name: '/articulos', page: () => const Articulos()),
      GetPage(name: '/ofertas', page: () => const Ofertas()),
      
    ],
  ));
}



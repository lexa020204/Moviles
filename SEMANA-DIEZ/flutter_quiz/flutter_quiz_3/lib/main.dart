import 'package:flutter/material.dart';
import 'package:flutter_quiz_3/login/hab_hueblla.dart';
import 'package:flutter_quiz_3/login/login.dart';
import 'package:get/get.dart';

//import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/login',
    getPages: [
      GetPage(name: '/login', page: () => const Login()),
      GetPage(name: '/habHuella', page: () => const HabHueblla())
    ],
  ));
}



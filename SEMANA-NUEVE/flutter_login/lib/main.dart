import 'package:flutter/material.dart';

import 'package:flutter_login/my_app.dart';
import 'package:flutter_login/vista_uno.dart';
import 'package:flutter_login/hab_huella.dart';
import 'package:get/get.dart';

void main() {
  runApp( GetMaterialApp(
    initialRoute: '/login',
    getPages: [
      GetPage(name: '/login', page: () => MyApp()),
      GetPage(name: '/vistauno', page: () => const VistaUno()),
      GetPage(name: '/huella', page: () => const HabHuella()),
    ],
  ));
}


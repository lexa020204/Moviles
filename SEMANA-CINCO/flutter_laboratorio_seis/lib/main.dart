import 'package:flutter/material.dart';
import 'package:flutter_laboratorio_seis/vista_dos.dart';
import 'package:flutter_laboratorio_seis/vista_uno.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute:'/',
    routes: {  
      '/': (context) => const VistaUno(),
      '/second': (context) => const VistaDos(),
      },
  ));
}


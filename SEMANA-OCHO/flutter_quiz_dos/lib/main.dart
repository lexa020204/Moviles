import 'package:flutter/material.dart';
import 'package:flutter_quiz_dos/articulos.dart';
import 'package:flutter_quiz_dos/ficha_articulo.dart';
import 'package:flutter_quiz_dos/menu.dart';
import 'package:flutter_quiz_dos/ofertas.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    initialRoute: '/',
    routes: {
      '/': (context) => const Menu(),
      '/articulos': (context) => const Articulos(),
      '/ofertas': (context) => const Ofertas(),
      '/ficha_articulo': (context) => FichaArticulo( ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>),	
    },
  ));
}


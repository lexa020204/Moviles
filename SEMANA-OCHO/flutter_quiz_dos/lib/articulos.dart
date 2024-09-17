import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quiz_dos/item_articulo.dart';
import 'package:http/http.dart' as http;

class Articulos extends StatefulWidget {
  const Articulos({super.key});

  @override
  State<Articulos> createState() => _ArticulosState();
}

class _ArticulosState extends State<Articulos> {
  Future<Widget> _obtenerArticulos() async{
    String sUrl = "https://api.npoint.io/237a0d1ac8530064cc04";

    try{  
      final oRespuesta = await http.get(
        Uri.parse(sUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      dynamic oJsonDatos = jsonDecode(utf8.decode(oRespuesta.bodyBytes));
      List awArticulos = oJsonDatos["articulos"];

      
      ListView lista =  ListView.separated(
      padding: const EdgeInsets.all(20),
      itemBuilder: (BuildContext context, int index) {
        return ItemArticulo( urlImagen: awArticulos[index]['urlimagen'],
          articulo: awArticulos[index]['articulo'],
          precio: int.parse(awArticulos[index]['precio'].toString()),
          descuento: int.parse(awArticulos[index]['descuento'].toString()),
          valoracion: double.parse(awArticulos[index]['valoracion'].toString()),
          calificaciones: int.parse(awArticulos[index]['calificaciones'].toString()),
         );

      }, 
      separatorBuilder: (BuildContext context, int index) => const Divider(), 
      itemCount: awArticulos.length,
      );
      return lista;
    }
    catch(e){
      const Center(
        child: Text("Error al enviar/recibir solicitud"),
      );
    }
    return const Center(
      child: Text("Error al enviar/recibir solicitud"),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articulos'),
      ),
      body: FutureBuilder<Widget>(
        future: _obtenerArticulos(),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Si los datos se recibieron correctamente, mostramos la lista
          if (snapshot.hasData) {
            return snapshot.data!;
          }

          return const Center(
            child: Text("Error al cargar los artículos."),
          );

        },
      ),
    );
  }
}
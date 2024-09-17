import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quiz_dos/item_articulo.dart';
import 'package:http/http.dart' as http;

class Ofertas extends StatefulWidget {
  const Ofertas({super.key});

  @override
  State<Ofertas> createState() => _OfertasState();
}

class _OfertasState extends State<Ofertas> {
  Future<Widget> _obtenerArticulos() async{
    String sUrl = "https://api.npoint.io/237a0d1ac8530064cc04";

    try{  
      final oRespuesta = await http.get(
        Uri.parse(sUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      dynamic oJsonDatos = jsonDecode(utf8.decode(oRespuesta.bodyBytes));
      List awArticulos = oJsonDatos["articulos"];

      List awArticulosConDescuento = awArticulos
          .where((articulo) => int.parse(articulo['descuento'].toString()) > 0)
          .toList();

      
      if (awArticulosConDescuento.isEmpty) {
        return const Center(
          child: Text("No hay artículos con descuento."),
        );
      }

      ListView lista =  ListView.separated(
      padding: const EdgeInsets.all(20),
      itemBuilder: (BuildContext context, int index) {
          return ItemArticulo( urlImagen: awArticulosConDescuento[index]['urlimagen'],
          articulo: awArticulosConDescuento[index]['articulo'],
          precio: int.parse(awArticulosConDescuento[index]['precio'].toString()),
          descuento: int.parse(awArticulosConDescuento[index]['descuento'].toString()),
          valoracion: double.parse(awArticulosConDescuento[index]['valoracion'].toString()),
          calificaciones: int.parse(awArticulos[index]['calificaciones'].toString()),
          );
      }, 
      separatorBuilder: (BuildContext context, int index) => const Divider(), 
      itemCount: awArticulosConDescuento.length,
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
        title: const Text('Ofertas'),
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

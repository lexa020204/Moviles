import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:parcial/config.dart';
import 'package:parcial/usuarios/item_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioService {
  Future<Widget> obtenerUsuarios() async {
     const  String url = 'http://${Config.HOST}:3000/usuarios';

     try{
      final oRespuesta = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      dynamic oJsonDatos = json.decode(oRespuesta.body);
      List awItems = oJsonDatos['usuarios'];
      ListView lista = ListView.separated(
        itemCount: awItems.length,
        itemBuilder: (BuildContext context, int index){
          return ItemUsuario(email: awItems[index]['email'], 
          nombre: awItems[index]['nombre'] ,
           imagen: awItems[index]['imagen'], 
           telefono: awItems[index]['telefono'], 
           cargo: awItems[index]['cargo']);
        }, separatorBuilder: (BuildContext context, int index) => const Divider(), );
        return lista;
     }
     catch (e){
       print(e);
       return const Text('Error en la petición');
     }
  }
}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parcial/config.dart';
import 'dart:convert';

import 'package:parcial/mesajes/item_mensaje.dart'; 



class MesajeService{
  Future<bool> enviarInfo(String sTitulo, String sContenido, String sEmailDestinatario, String sEmailOrigen) async {

    const  String url = 'http://${Config.HOST}:3000/enviarMensaje';

    final Map<String, String> data = {
      "titulo": sTitulo,
      "contenido": sContenido,
      "email_destinatario": sEmailDestinatario, 
      "email_origen": sEmailOrigen
  
    };

    try{
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        return true;
      } else{
      print('Error en la petición');
      return false;
      
    }
      }
  catch (e){
    print(e);
    return false;
    
  }
   }

   Future<Widget> obtenerMensajes(String sEmail) async {
     const  String url = 'http://${Config.HOST}:3000/getMensajes';

     final Map<String, String> data = {
      'email': sEmail,
      
    };

     try{
      final oRespuesta = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode(data),
      );

      dynamic oJsonDatos = json.decode(oRespuesta.body);
      List awItems = oJsonDatos['respuesta'];
      ListView lista = ListView.separated(
        itemCount: awItems.length,
        itemBuilder: (BuildContext context, int index){
          return ItemMensaje(titulo: awItems[index]['titulo'],
          contenido: awItems[index]['contenido'],
          emailOrigen: awItems[index]['email_origen'],
          tiempo: awItems[index]['tiempo']);
        }, separatorBuilder: (BuildContext context, int index) => const Divider(), );
        return lista;
     }
     catch (e){
       print(e);
       return const Text('Error en la petición');
     }
  }

}
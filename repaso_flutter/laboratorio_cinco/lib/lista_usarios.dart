import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:laboratorio_cinco/item_usuario.dart';
import 'package:http/http.dart' as http;

class ListaUsuarios extends StatefulWidget {
  const ListaUsuarios({super.key});

  @override
  State<ListaUsuarios> createState() => _ListaUsuariosState();
}

class _ListaUsuariosState extends State<ListaUsuarios> {
  Future<Widget> _obtenerUsuarios() async {
    String sUrl = "https://api.npoint.io/5cb393746e518d1d8880";
    
    try {
      final oRespuesta = await http.get(
        Uri.parse(sUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      dynamic oJsonDatos = jsonDecode(utf8.decode(oRespuesta.bodyBytes));
     
      List awItems = oJsonDatos["elementos"];
      ListView lista=  ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: awItems.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemUsuario(
              iEdad: int.parse(awItems[index]['edad'].toString()),
              sEstudios: awItems[index]['estudios'].cast<Map>(),
              sNombre: awItems[index]['nombreCompleto'].toString(),
              sProfesion: awItems[index]['profesion'].toString(),    
              sFoto: awItems[index]['urlImagen'].toString());
              
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
      return  Future.delayed(const Duration(seconds: 3), ()=>lista);
      }
    catch (e) {
      const Center(
        child: Text("Error al enviar/recibir solicitud"),
      );
    }
    return const Center(
      child: Text("Error al enviar/recibir solicitud"),
    );
  }

  /* */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Lista de Usuarios')),
            body: FutureBuilder<Widget>(
              future: _obtenerUsuarios(),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data ?? Container();
                }
                return Container();
              },
            )));
  }
}

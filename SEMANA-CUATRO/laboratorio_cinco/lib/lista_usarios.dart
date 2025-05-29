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
    String sUrl = "https://api.npoint.io/bffbb3b6b3ad5e711dd2";
     

    try {
      final oRespuesta = await http.get(
        Uri.parse(sUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      dynamic oJsonDatos = jsonDecode(utf8.decode(oRespuesta.bodyBytes));
     
      List awItems = oJsonDatos["items"];
      ListView lista=  ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: awItems.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemUsuario(
              sNombre: awItems[index]['nombre'].toString(),
              sCarrera: awItems[index]['carrera'].toString(),
              sPromedio: awItems[index]['promedio'].toString(),
              sFoto: awItems[index]['imagen'].toString());
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
      return  Future.delayed(const Duration(seconds: 3), ()=>lista);
      }
    catch (e) {
      print("Error al enviar/recibir solicitud");
      print(e);
    }
    return Container();
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

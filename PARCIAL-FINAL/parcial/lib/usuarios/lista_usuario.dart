import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial/login/login_service.dart';
import 'package:parcial/usuarios/usuario_service.dart';

class ListaUsuario extends StatefulWidget {
  const ListaUsuario({super.key});

  @override
  State<ListaUsuario> createState() => _ListaUsuarioState();
}

class _ListaUsuarioState extends State<ListaUsuario> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
             appBar: AppBar(
          title: const Text('Lista de Usuarios'),
          backgroundColor: Colors.purple[300],
          foregroundColor: Colors.white,
          actions: [
            IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async{
              final success = await LoginService().logout();
              if (success) {
                Get.toNamed('/login');
              }
            },
          ),
          ],
           leading: IconButton(
          icon: Icon(Icons.arrow_back), // Ícono de flecha hacia atrás
          onPressed: () {
            Navigator.pop(context); // Navegar hacia atrás
          },
        ),
        ),
            body: Center (
            child : Container(
             margin: const EdgeInsets.fromLTRB(25, 30, 25, 25),
              child: 
            FutureBuilder<Widget>(
              future: UsuarioService().obtenerUsuarios(),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data ?? Container();
                }
                return Container();
              },
            )))));
  }
}
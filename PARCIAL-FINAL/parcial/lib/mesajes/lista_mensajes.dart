import 'package:flutter/material.dart';
import 'package:parcial/login/login_service.dart';
import 'package:parcial/mesajes/mesaje_service.dart';
import 'package:get/get.dart';

class ListaMensajes extends StatefulWidget {

  const ListaMensajes({super.key});

  @override
  State<ListaMensajes> createState() => _ListaMensajesState();
}

class _ListaMensajesState extends State<ListaMensajes> {

  String email = '';

  
  @override
  void initState() {
    super.initState();
    getEmail();
  }

  Future<void> getEmail() async {
    final LoginService loginService = LoginService();
    email = await loginService.getEmail();
    setState(() {}); // Actualiza la UI después de obtener el email
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
             appBar: AppBar(
          title: const Text('Lista de Mensajes'),
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
              future: MesajeService().obtenerMensajes(email),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data ?? Container();
                }
                return Container();
              },
            )))));
  }
}
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial/login/login_service.dart';
import 'package:parcial/mesajes/enviar_mensaje.dart';

class DetalleUsuario extends StatefulWidget {
  const DetalleUsuario({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DetalleUsuarioState createState() => _DetalleUsuarioState();
}

class _DetalleUsuarioState extends State<DetalleUsuario> {

  bool showMessageForm = false;
  String emailOrigen = '';
  void getEmailOrigen() async {
    final LoginService loginService = LoginService();
    emailOrigen = await loginService.getEmail();
  }

  String emailDestinatario = '';


  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> usuario = Get.arguments;
    final String cleandImage = usuario['imagen'].replaceFirst('data:image/jpeg;base64,', '');
    Uint8List bytes = base64Decode(cleandImage);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Usuario'),
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
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(25, 40, 25, 25),
        child: Column(
          children: [
            Center(
              child: Image.memory(bytes, width: 100, height: 100),
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nombre: ${usuario['nombre']}", style: const TextStyle(fontSize: 16)),
                  Text("Email:  ${usuario['email']}", style: const TextStyle(fontSize: 16)),
                  Text("Teléfono: ${usuario['telefono']}", style: const TextStyle(fontSize: 16)),
                  Text("Cargo: ${usuario['cargo']}", style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300,30),
      backgroundColor: Colors.purple,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8), // Bordes cuadrados
      ),
      textStyle: const TextStyle(
        fontSize: 15,
      ),
      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      setState(()  {
                        showMessageForm = !showMessageForm;
                        getEmailOrigen();
                        emailDestinatario = usuario['email'];
                       

                      });
                    },
                    child: const Text('Enviar mensaje'),
                  ),
                  if (showMessageForm) EnviarMensaje(emailOrigen: emailOrigen, emailDestinatario: emailDestinatario,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


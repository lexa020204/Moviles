import 'package:flutter/material.dart';
import 'dart:convert'; 
import 'dart:typed_data';

import 'package:get/get.dart';

class ItemUsuario extends StatelessWidget {
  final String email;
  final String nombre;
  final String imagen;
  final String telefono;
  final String cargo;


  const ItemUsuario({ 
    required this.email,
    required this.nombre,
    required this.imagen,
    required this.telefono,
    required this.cargo,
    super.key});

  @override
  Widget build(BuildContext context){
    final String cleanImage = imagen.startsWith('data:image')
    ? imagen.replaceFirst(RegExp(r'data:image\/[a-zA-Z]+;base64,'), '')
    : imagen;
    Uint8List bytes = base64Decode(cleanImage);

    return InkWell(
      onTap: () {
        Get.toNamed(
          '/detalle', 
          arguments: {
            "email": email,
            "nombre": nombre,
            "imagen": imagen,
            "telefono": telefono,
            "cargo": cargo
          }
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.memory(bytes, width: 100, height: 100),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nombre),
              Text(email),
            ],
          )
        ],
      ),
    );
    
  }
}
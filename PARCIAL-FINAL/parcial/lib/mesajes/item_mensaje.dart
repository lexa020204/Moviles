import 'package:flutter/material.dart';

class ItemMensaje extends StatelessWidget {
  final String emailOrigen;
  final String tiempo;
  final String titulo;
  final String contenido;
  const ItemMensaje({required this.emailOrigen, 
  required this.tiempo, 
  required this.titulo, 
  required this.contenido,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Icon(Icons.mark_email_read_outlined,
          color: Colors.purple,
          size: 50),
          const SizedBox(width: 15),
          Expanded(
            child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('De:' ,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple[200],
              ),
              ),
              Text(emailOrigen),
              Text('Fecha y Hora:' ,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple[200],
              ),
              ),
              Text(tiempo),
              Text('Titulo:' ,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple[200],
              ),
              ),
              Text(titulo),
              Text('Cuerpo del Mensaje:' ,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple[200],
              ),
              ),
              Text(contenido,
              softWrap: true, 
              overflow: TextOverflow.clip, ),
            ],
          )
          )
        ],
      );
  }
}
import 'package:flutter/material.dart';

class ItemUsuario extends StatelessWidget{

  final int iEdad;
  final List<Map> sEstudios;
  final String sProfesion;
  final String sNombre;
  final String sFoto;

  const ItemUsuario({
    
    required this.iEdad,
    required this.sEstudios,
    required this.sNombre,
    required this.sProfesion,
    required this.sFoto,
    super.key
  });


  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: NetworkImage(sFoto),
              height: 60
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(sNombre ),
                Text(sProfesion),
                for (var oEstudio in sEstudios)
                  Text(" Universidad: ${oEstudio['universidad']}"),
              ],
            ),  
          ],
        ) ,
        Row(
          children: [
            TextButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text("Información del Usuario"),
                  content: Column(
                    children: [
                      Image(image:  NetworkImage(sFoto),
                      height: 60,),
                      Text("Nombre: $sNombre"),
                      Text("Edad: $iEdad"),
                      Text("Profesión: $sProfesion"),
                      const Text("Estudios:"),
                      for (var oEstudio in sEstudios)
                        Text(" Universidad: ${oEstudio['universidad']}\nBachillerato: ${oEstudio['bachillerato']}"),
                      ElevatedButton(onPressed: ()=> Navigator.pop(context,'Regresar'), child: const Text("Regresar")),
                    ],),
                ),
              ),
              child: const Text("Ver Pefil"),
            ),
          ],
        )
      ],
    );
  }
}
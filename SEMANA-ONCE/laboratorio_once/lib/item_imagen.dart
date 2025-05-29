import 'package:flutter/material.dart';
import 'package:laboratorio_once/video.dart';

class ItemImagen extends StatelessWidget{

  final String sNombre;
  final String sTiempo;
  final String sTamano;
  final String sImagen;
  final String sUrl;

  const ItemImagen({
    
    required this.sNombre,
    required this.sTiempo,
    required this.sTamano,
    required this.sImagen,
    required this.sUrl,
    super.key
  });

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        showDialog(context: context, builder: (BuildContext context) {
          return AlertDialog(
            content: Video(sUrl: sUrl, sNombre: sNombre, sTiempo: sTiempo, sTamano: sTamano, sImagen: sImagen),
          );
        });

      },
      child:Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image(
                    image: NetworkImage(sImagen),
                    height: 60
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sNombre ),
                      Text(sTiempo),
                      Text(sTamano)

                    ],
                  )
                  
                ],
     ) );
    
  }

}
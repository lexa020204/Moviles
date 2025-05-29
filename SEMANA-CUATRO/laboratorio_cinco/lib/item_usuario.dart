import 'package:flutter/material.dart';

class ItemUsuario extends StatelessWidget{

  final String sNombre;
  final String sCarrera;
  final String sPromedio;
  final String sFoto;

  const ItemUsuario({
    
    required this.sNombre,
    required this.sCarrera,
    required this.sPromedio,
    required this.sFoto,
    super.key
  });

  @override
  Widget build(BuildContext context){
    return Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image(
                    image: AssetImage(sFoto),
                    height: 60
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sNombre ),
                      Text(sCarrera),
                      Text(sPromedio)

                    ],
                  )
                  
                ],
              );
    
  }

}
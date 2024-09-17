// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ItemArticulo extends StatefulWidget {
  final String urlImagen;
  final String articulo;
  final int precio;
  final int descuento;
  final double valoracion;
  final int calificaciones;
  

  const ItemArticulo({
    required this.urlImagen,
    required this.articulo,
    required this.precio,
    required this.descuento,
    required this.valoracion,
    required this.calificaciones,
    
    super.key,
  });

  @override
  _ItemArticuloState createState() => _ItemArticuloState();
}

class _ItemArticuloState extends State<ItemArticulo> {
  double dValoracionFinal = 0;
  
  @override
  void initState() {
    super.initState();
    dValoracionFinal = widget.valoracion / 10;
  }

  void _irFicha(){
    Navigator.pushNamed(context, '/ficha_articulo', arguments: {
      'urlImagen': widget.urlImagen,
      'articulo': widget.articulo,
      'precio': widget.precio,
      'descuento': widget.descuento,
      'valoracion': widget.valoracion,
      'calificaciones': widget.calificaciones,
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: _irFicha, child:  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image(
          image: NetworkImage(widget.urlImagen), 
          width: 50,
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.articulo, 
              ),
              const SizedBox(height: 5),
              if (widget.descuento > 0)
              Row(children: [
                Text("\$${widget.precio - widget.descuento}"), 
                Text(" ${widget.descuento}% OFF",
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 10,
                  )),

              ],)
                
              else
                Text(
                  "\$${widget.precio}",
                  style: const TextStyle(fontSize: 14),
                ),
              const SizedBox(height: 5),
              _crearEstrellas(dValoracionFinal),
              
            ],
          ),
        )
      ],
    )
    );
  }
}

Widget _crearEstrellas(double dValoracionFinal){
  return RatingBarIndicator(
    rating: dValoracionFinal,
    itemBuilder: (context, index) => const Icon(
      Icons.star,
      color: Colors.amber,
    ),
    itemCount: 5,
    itemSize: 20,
    direction: Axis.horizontal,
  );
  
}
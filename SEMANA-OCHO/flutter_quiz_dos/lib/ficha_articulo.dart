import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FichaArticulo extends StatefulWidget {
  const FichaArticulo(Map<String, dynamic> arguments, {super.key});

  @override
  State<FichaArticulo> createState() => _FichaArticuloState();
}

class _FichaArticuloState extends State<FichaArticulo> {
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final articulo = arguments['articulo'] as String;
    final precio = arguments['precio'] as int;
    final descuento = arguments['descuento'] as int;
    final valoracion = arguments['valoracion'] as double;
    final urlImagen = arguments['urlImagen'] as String;
    final calificaciones = arguments['calificaciones'] as int;
    double dValoracionFinal = valoracion / 10;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalle de artículo'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image(
                image: NetworkImage(urlImagen),
                width: 200,
              ),
              const SizedBox(height: 15),
              Text(
                articulo,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              if (descuento > 0)
                Column(children: [
                  Row(children: [
                    Text("\$${precio - (descuento * precio / 100)}"),
                    Text(
                      " $descuento% OFF",
                      style: const TextStyle(color: Colors.green, fontSize: 14),
                    ),
                  ]),
                  Row(
                    children: [
                      Text(
                        " Antes \$$precio ",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      )
                    ],
                  )
                ]),
              if (descuento == 0)
                Row(
                  children: [
                    Text(
                      "\$$precio",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    "$dValoracionFinal",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      RatingBarIndicator(
                        rating: dValoracionFinal,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 20,
                        direction: Axis.horizontal,
                      ),
                      Text(
                        "$calificaciones calificaciones",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}

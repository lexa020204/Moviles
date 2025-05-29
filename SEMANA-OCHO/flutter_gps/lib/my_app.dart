import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? urlUbicacion;
  @override
  Widget build(BuildContext context) {
    return MaterialApp( home:
      Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(15),
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.purple, width: 2),
      ),
      padding: const EdgeInsets.all(20),
          child: Column(children: [
           ElevatedButton(child: const Text('Obtener'),onPressed: () async { 
          var ubicacion = await obtenerGps();
          setState(() {
            urlUbicacion = 'http://www.google.com/maps/place/${ubicacion.latitude},${ubicacion.longitude}';
          });
          },),
          if (urlUbicacion!=null)
          GestureDetector(
            onTap: () async {
              await abrirUrl(urlUbicacion!);
            },
            child: Text(urlUbicacion!),
          )
        ],)),
        )

    )
    );
  }
}

Future<Position> obtenerGps() async {
  //Verificar si la ubicación del dispositivo está habilitada
  bool bGpsHabilitado = await Geolocator.isLocationServiceEnabled();
  if (!bGpsHabilitado) {
    return Future.error('Por favor habilite el servicio de ubicación.');
  }
  //Validar permiso para utilizar los servicios de localización
  LocationPermission bGpsPermiso = await Geolocator.checkPermission();
  if (bGpsPermiso == LocationPermission.denied) {
    bGpsPermiso = await Geolocator.requestPermission();
    if (bGpsPermiso == LocationPermission.denied) {
      return Future.error('Se denegó el permiso para obtener la ubicación, por favor habilite el permiso e inténtelo de nuevo.');
    }
  }
  if (bGpsPermiso == LocationPermission.deniedForever) {
    return Future.error('Se denegó el permiso para obtener la ubicación, por favor habilite el permiso manualmente e inténtelo de nuevo.');
  }
  //En este punto los permisos están habilitados y se puede consultar la ubicación
  return await Geolocator.getCurrentPosition();
}


Future<void> abrirUrl(final String sUrl) async {
  final Uri oUri = Uri.parse(sUrl);
  try {
    await launchUrl(
      oUri, //Ej: http://www.google.com/maps/place/6.2502089,-75.5706711
      mode: LaunchMode.externalApplication
    );
  } catch (oError){
    return Future.error('No fue posible abrir la url: $sUrl.');
  }

}
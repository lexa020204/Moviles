import 'package:flutter/material.dart';
import 'package:flutter_laboratorio_seis/vista_dos.dart';
import 'package:flutter_laboratorio_seis/vista_tres.dart';
import 'package:get/get.dart';

class VistaUno extends StatefulWidget {
  const VistaUno({super.key});

  @override
  State<VistaUno> createState() => _VistaUnoState();
}

ButtonStyle buttonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.purple,
    textStyle: const TextStyle(
      fontSize: 15,
    ),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

class _VistaUnoState extends State<VistaUno> {
  String sText = 'Hola';
  String sText2 = ' ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      margin: const EdgeInsets.all(10),
      height: 450,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue, width: 2),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Center(
            child: Text(
              'Vista 1',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ),
          const Text('Ir a vista 2,\nutilizando el método push:'),
          ElevatedButton(
            style: buttonStyle(),
            onPressed: () async {
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VistaDos(),
                      settings: RouteSettings(arguments: '$sText 1')));
              if (result != null) {
                setState(() {
                  sText2 = result;
                });
              }
            },
            child: const Text("Método Push"),
          ),
          ElevatedButton(
              style: buttonStyle(),
              onPressed: () async {
                final result = await Navigator.pushNamed(context, '/second',
                    arguments: '$sText 2');
                if (result != null) {
                  setState(() {
                    sText2 = '${result as String} 2';
                  });
                }
              },
              child: const Text('Método pushNamed')),
          const Text('Ir a vista 2,\nutilizando el método push:'),
          ElevatedButton(
              style: buttonStyle(),
              onPressed: () async {
                final result = await Get.to(VistaTres(message: '$sText 3'));
                if (result != null) {
                  setState(() {
                    sText2 = '$result 3';
                  });
                }
              },
              child: Text('Método Get.to')),
          Text(
            sText2,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    )));
  }
}

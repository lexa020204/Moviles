import 'package:flutter/material.dart';

ButtonStyle buttonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    textStyle: const TextStyle(
      fontSize: 15,
    ),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

class VistaDos extends StatelessWidget {
  const VistaDos({super.key});
  @override
  Widget build(BuildContext context) {
    final String sText = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
        body: Center(
            child: Container(
      margin: const EdgeInsets.all(10),
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.purple, width: 2),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          
          const Text(
            'Vista 2',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple),
          ),

          ElevatedButton(
              style: buttonStyle(),
              onPressed: () {
                Navigator.pop(context, 'mundo');
              },
              child: Text('Regresar Vista 1')),
          Text(
            sText,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    )));
  }
}

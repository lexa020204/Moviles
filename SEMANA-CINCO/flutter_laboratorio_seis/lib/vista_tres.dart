
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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


class VistaTres extends StatelessWidget {
  final String message;
  const VistaTres({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: 
      Container(
         margin: const EdgeInsets.all(10),
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.green, width: 2),
      ),
      padding: const EdgeInsets.all(20),child:
        Column(
        children: [

          const Text(
            'Vista 2',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green),
          ),
         

          ElevatedButton(
            style: buttonStyle(),
            onPressed: () {
              Get.back(result: 'mundo');
            },
            child: const Text('Regresar Vista 1'),
          ),
          Text(message,
          style: TextStyle(fontWeight: FontWeight.bold),),
        ],
      ), )
    ) 
    );
  }
}
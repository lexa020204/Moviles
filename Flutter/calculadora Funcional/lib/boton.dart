import 'package:flutter/material.dart';


class Boton extends StatelessWidget{

 
  final String sText;
  final Color oColor;
  final Function fCallBack;
 
 
   const Boton(
    {
      super.key,
      required this.sText,
      required this.oColor,
      
      required this.fCallBack
    }
   );

  @override
  Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: 
    TextButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: oColor,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 30),
        fixedSize: sText=="+" ? const Size(50,108): const Size(50,50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(0),
        elevation: 5.0,
    ),
    onPressed: () =>  fCallBack(sText),
    child: Text(sText)
    )
  );
}
}
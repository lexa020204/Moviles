import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => CalculadoraState();
}

//Estilo de los botones

const gris = Color(0xFF6b6b6b);
const naranja = Color.fromARGB(255, 214, 133, 12);
const verde = Color(0xFFC0C89F);

Widget builtTextField(){
  return Container(
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border.all(color:const Color(0xFFEEEEEE), width: 7),
      color: const Color(0xFFEEEEEE),
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(255, 0, 0, 0),
          blurRadius: 10
        ),
      ],
    ),
    child:  SizedBox(
      child: TextField(
        decoration: InputDecoration(
         enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: verde), borderRadius: BorderRadius.circular(10)), 
          labelText: '0 123456789',
          labelStyle: const TextStyle(fontSize: 30 ),
          filled: true,
          fillColor: verde,
         
          
        )
      ),
    )
  );
  
}

ButtonStyle estiloBotones(Color color, String text) {
  return ElevatedButton.styleFrom(
    backgroundColor: color,
    foregroundColor: Colors.white,
    textStyle: const TextStyle(fontSize: 30),
    fixedSize: text=="+" ? const Size(50,108): const Size(50,50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.all(0),
    elevation: 5.0,
    
    ); 
}
Widget buildButton(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child:  ElevatedButton(    
      style: estiloBotones(color, text),
      // ignore: avoid_print
      onPressed: () =>  print(text), child: Text(text)
     )
  );
}



class CalculadoraState extends State<Calculadora> {
  @override
  /* En este método es donde se diseña*/
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      body: Center(
        child: 
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          height: 500.0,
          decoration: BoxDecoration(
            color: const Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 0, 0, 0),
                blurRadius: 10
              ),
            ],
          ),
          child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                builtTextField(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildButton("AC", naranja),
                    buildButton("CE", naranja),
                    buildButton("%", gris),
                    buildButton( "÷", gris),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildButton("7", gris),
                    buildButton("8", gris),
                    buildButton("9", gris),
                    buildButton("x", gris),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildButton("4", gris),
                    buildButton("5", gris),
                    buildButton("6", gris),
                    buildButton("-", gris),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        buildButton("1", gris),
                        buildButton("0", gris)
                      ],
                    ),
                    Column(
                      children: [
                        buildButton("2", gris),
                        buildButton(".", gris)
                      ],
                    ),
                    Column(
                      children: [
                        buildButton("3", gris),
                        buildButton("=", gris)
                      ],
                    ),
                    Column(
                      children: [
                        buildButton("+", gris),
                      ],
                    )
                  ],
                )
              ],
            ),
      ),
    )));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => CalculadoraState();
}

class CalculadoraState extends State<Calculadora> {
  @override
  /* En este método es donde se diseña*/
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
                decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '0123456789',
            )),
            Row(
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            Color.fromARGB(255, 214, 133, 12))),
                    onPressed: () => print("AC"),
                    child: Text("AC")),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            Color.fromARGB(255, 214, 133, 12))),
                    onPressed: () => print("CE"),
                    child: Text("CE")),
                ElevatedButton(onPressed: () => print("%"), child: Text("%")),
                ElevatedButton(onPressed: () => print("/"), child: Text("/"))
              ],
            ),
            Row(
              children: [
                ElevatedButton(onPressed: () => print("7"), child: Text("7")),
                ElevatedButton(onPressed: () => print("8"), child: Text("8")),
                ElevatedButton(onPressed: () => print("9"), child: Text("9")),
                ElevatedButton(onPressed: () => print("X"), child: Text("X"))
              ],
            ),
            Row(
              children: [
                ElevatedButton(onPressed: () => print("4"), child: Text("4")),
                ElevatedButton(onPressed: () => print("5"), child: Text("5")),
                ElevatedButton(onPressed: () => print("6"), child: Text("6")),
                ElevatedButton(onPressed: () => print("-"), child: Text("-"))
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () => print("1"), child: Text("1")),
                    ElevatedButton(
                        onPressed: () => print("0"), child: Text("0"))
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () => print("2"), child: Text("2")),
                    ElevatedButton(
                        onPressed: () => print("."), child: Text("."))
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () => print("3"), child: Text("3")),
                    ElevatedButton(
                        onPressed: () => print("="), child: Text("="))
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () => print("+"), child: Text("+"))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}

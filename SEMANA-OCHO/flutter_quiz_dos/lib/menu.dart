import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo'),
        ),
        body: Center(
          child: Container(
            child: Column(children: [
              ElevatedButton(onPressed: () { Navigator.pushNamed(context, '/articulos');}, child: Text('Articulos')),
              ElevatedButton(onPressed: () { Navigator.pushNamed(context, '/ofertas');}, child: Text('Ofertas')),
            ],),
          ),
        ),
      );
    
  }
}
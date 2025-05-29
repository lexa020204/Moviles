import 'package:flutter/material.dart';
import 'package:laboratorio_4/item_usuario.dart';


class ListaUsuario extends StatelessWidget{
  const ListaUsuario({super.key});

  // ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context){

   dynamic awItems = [
  {
    'nombre': 'Vanesa Lopez',
    'carrera': 'Ingeniería Ambiental',
    'promedio': '4.5',
    'foto': 'assets/1.png'
  },
  {
    'nombre': 'Pedro Martínez',
    'carrera': 'Ingeniería Eléctrica',
    'promedio': '4.2',
    'foto': 'assets/2.png'
  },
  {
    'nombre': 'María García',
    'carrera': 'Medicina',
    'promedio': '4.7',
    'foto': 'assets/3.png'
  },
  {
    'nombre': 'Juan Pérez',
    'carrera': 'Derecho',
    'promedio': '4.1',
    'foto': 'assets/4.png'
  },
  {
    'nombre': 'Ana Sánchez',
    'carrera': 'Arquitectura',
    'promedio': '4.3',
    'foto': 'assets/5.png'
  },
  {
    'nombre': 'Carlos González',
    'carrera': 'Psicología',
    'promedio': '4.6',
    'foto': 'assets/6.png'
  },
  {
    'nombre': 'Laura Ramírez',
    'carrera': 'Ingeniería Informática',
    'promedio': '4.4',
    'foto': 'assets/7.png'
  },
  {
    'nombre': 'Diego Rodríguez',
    'carrera': 'Administración de Empresas',
    'promedio': '4.0',
    'foto': 'assets/8.png'
  },
  {
    'nombre': 'Julia Martínez',
    'carrera': 'Biología',
    'promedio': '4.8',
    'foto': 'assets/9.png'
  },
  {
    'nombre': 'Andrés Fernández',
    'carrera': 'Ingeniería Civil',
    'promedio': '4.9',
    'foto': 'assets/10.png'
  },
  {
    'nombre': 'Sofia Morales',
    'carrera': 'Economía',
    'promedio': '4.3',
    'foto': 'assets/11.png'
  },
  {
    'nombre': 'Luis Hernández',
    'carrera': 'Filosofía',
    'promedio': '4.1',
    'foto': 'assets/12.png'
  },
  {
    'nombre': 'Carmen Rodríguez',
    'carrera': 'Química',
    'promedio': '4.5',
    'foto': 'assets/13.png'
  },
  {
    'nombre': 'Felipe García',
    'carrera': 'Matemáticas',
    'promedio': '4.7',
    'foto': 'assets/14.png'
  },
  {
    'nombre': 'Natalia Fernández',
    'carrera': 'Veterinaria',
    'promedio': '4.2',
    'foto': 'assets/15.png'
  },
  {
    'nombre': 'Raúl Torres',
    'carrera': 'Ingeniería Mecánica',
    'promedio': '4.4',
    'foto': 'assets/16.png'
  },
  {
    'nombre': 'Isabella Gómez',
    'carrera': 'Literatura',
    'promedio': '4.6',
    'foto': 'assets/17.png'
  },
  {
    'nombre': 'Oscar Mendoza',
    'carrera': 'Relaciones Internacionales',
    'promedio': '4.0',
    'foto': 'assets/18.png'
  },
  {
    'nombre': 'Verónica Álvarez',
    'carrera': 'Diseño Gráfico',
    'promedio': '4.8',
    'foto': 'assets/19.png'
  },
  {
    'nombre': 'Gustavo Peña',
    'carrera': 'Antropología',
    'promedio': '4.3',
    'foto': 'assets/20.png'
  }
];


    return MaterialApp(
      home: Scaffold(
         appBar: AppBar(
          title: const Text('Lista de Usuarios')
        ),
        body: Center(
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: awItems.length,
            itemBuilder: (BuildContext context, int index ){
              return ItemUsuario(sNombre: awItems[index]['nombre'].toString(), 
              sCarrera: awItems[index]['carrera'].toString(),
              sPromedio: awItems[index]['promedio'].toString(), 
              sFoto: awItems[index]['foto'].toString());
              
            }, 
            separatorBuilder: (BuildContext context, int index) => const Divider(),

          )

        )
    )
    );
  }
}
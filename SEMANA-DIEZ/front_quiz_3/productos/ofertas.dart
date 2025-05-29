import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_quiz_3/login/login_service.dart';
import 'package:flutter_quiz_3/productos/item_articulo.dart';
import 'package:flutter_quiz_3/productos/prod_service.dart';
import 'package:get/get.dart';


class Ofertas extends StatefulWidget {
  const Ofertas({super.key});

  @override
  State<Ofertas> createState() => _OfertasState();
}

class _OfertasState extends State<Ofertas> {
   ProductosService productosService = ProductosService();
   LoginService loginService = LoginService();
  Future<Widget> _obtenerArticulos() async{
   
    try{  
     List<Map<String, dynamic>> awArticulos =await productosService.getProductos();

      List awArticulosConDescuento = awArticulos
          .where((articulo) => int.parse(articulo['descuento'].toString()) > 0)
          .toList();

      
      if (awArticulosConDescuento.isEmpty) {
        return const Center(
          child: Text("No hay artículos con descuento."),
        );
      }

      ListView lista =  ListView.separated(
      padding: const EdgeInsets.all(20),
      itemBuilder: (BuildContext context, int index) {
          return ItemArticulo( urlImagen:'http://${dotenv.env['HOST']}:3000/images/${awArticulos[index]['urlimagen'].toString()}',
          articulo: awArticulosConDescuento[index]['articulo'],
          precio: int.parse(awArticulosConDescuento[index]['precio'].toString()),
          descuento: int.parse(awArticulosConDescuento[index]['descuento'].toString()),
          valoracion: double.parse(awArticulosConDescuento[index]['valoracion'].toString()),
          calificaciones: int.parse(awArticulos[index]['calificaciones'].toString()),
          );
      }, 
      separatorBuilder: (BuildContext context, int index) => const Divider(), 
      itemCount: awArticulosConDescuento.length,
      );
      return lista;
    }
    catch(e){
      const Center(
        child: Text("Error al enviar/recibir solicitud"),
      );
    }
    return const Center(
      child: Text("Error al enviar/recibir solicitud"),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ofertas'),
        backgroundColor: Colors.purple[300],
          foregroundColor: Colors.white,
          actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async{
              await loginService.removeToken();
              Get.offAllNamed('/login');
            },
          ),
  ],
      ),
      body: FutureBuilder<Widget>(
        future: _obtenerArticulos(),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Si los datos se recibieron correctamente, mostramos la lista
          if (snapshot.hasData) {
            return snapshot.data!;
          }

          return const Center(
            child: Text("Error al cargar los artículos."),
          );

        },
      ),
    );
  }
}

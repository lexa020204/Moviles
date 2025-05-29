import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_quiz_3/login/login_service.dart';
import 'package:flutter_quiz_3/productos/item_articulo.dart';
import 'package:flutter_quiz_3/productos/prod_service.dart';
import 'package:get/get.dart';

class Articulos extends StatefulWidget {
  const Articulos({super.key});

  @override
  State<Articulos> createState() => _ArticulosState();
}

class _ArticulosState extends State<Articulos> {
  ProductosService productosService = ProductosService();
  LoginService loginService = LoginService();
  Future<Widget> _obtenerArticulos() async{
    try{  
      List<Map<String, dynamic>> awArticulos =await productosService.getProductos();



      if (awArticulos.isEmpty) {
        Get.snackbar('Tiempo de sesión agotado', 'Vuelva a iniciar sesión');
        await Future.delayed(const Duration(seconds: 4));
        Get.toNamed('/login'); // Navega a la página '/menu'
      }
     
      ListView lista =  ListView.separated(
      padding: const EdgeInsets.all(20),
      itemBuilder: (BuildContext context, int index) {
        return ItemArticulo( urlImagen: 'http://${dotenv.env['HOST']}:${dotenv.env['PORT']}/${awArticulos[index]['urlimagen'].toString()}',
          articulo: awArticulos[index]['articulo'],
          precio: int.parse(awArticulos[index]['precio'].toString()),
          descuento: int.parse(awArticulos[index]['descuento'].toString()),
          valoracion: double.parse(awArticulos[index]['valoracion'].toString()),
          calificaciones: int.parse(awArticulos[index]['calificaciones'].toString()),
         );

      }, 
      separatorBuilder: (BuildContext context, int index) => const Divider(), 
      itemCount: awArticulos.length,
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
        title: const Text('Articulos'),
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
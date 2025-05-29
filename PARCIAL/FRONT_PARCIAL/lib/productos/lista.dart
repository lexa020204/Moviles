import 'package:flutter/material.dart';
import 'package:flutter_login/productos/prod_service.dart';
import 'package:flutter_login/database.dart';
import 'package:flutter_login/login/login_service.dart';
import 'package:flutter_login/login/login.dart';

class Lista extends StatefulWidget {
  const Lista({super.key});
  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {

  List<Map<String, dynamic>> productos = []; // Inicialización vacía
  int cantColumnas = 1;
  double tamano = 2;
  int cantColumnasDos = 2;
  bool  listaState = true;
  bool favoritos = false;
  bool isFavorito = false;
 
  String texto = 'Productos';
  ProductosService productosService = ProductosService();

  @override
  void initState() {
    super.initState();
    obtenerProductos(); 
    variablesLista(); 
  }
  
  Future<void> obtenerProductos() async {
    List<Map<String, dynamic>> resultado =
        await productosService.getProductos();
    setState(() {
      productos = resultado; // Actualización de la lista de productos
    });
  }

  Future<void> obtenerFavoritos() async{
    DatabaseFavorite dbFavorite = DatabaseFavorite.instance;
    List<Map<String,dynamic>> resultado = await dbFavorite.queryAllFavorites();
    if (resultado.isNotEmpty){
      setState(() {
        productos = resultado;
      });
    }
    else{
      resultado = await productosService.getFavoritos();
      setState(() {
      productos = resultado; 
    });
    // ignore: avoid_function_literals_in_foreach_calls
    productos.forEach((element) async {
        await dbFavorite.insertFavorite(element);
      });
    }
    
  }

  Future<bool> agregarFavorito(int idProducto, Map<String, dynamic> producto) async {
    DatabaseFavorite dbFavorite = DatabaseFavorite.instance;
    await dbFavorite.insertFavorite(producto);
    bool resultado = await productosService.agergarFav(idProducto);
    
    if (resultado) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Producto agregado a favoritos'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al agregar a favoritos'),
        ),
      );
    }
    return resultado;
  }

  Future<bool> eliminarFavorito(int idProducto) async {
    DatabaseFavorite dbFavorite = DatabaseFavorite.instance;
    bool resultado1 = await dbFavorite.deleteFavorite(idProducto);
    bool resultado = await productosService.eliminarFav(idProducto);
    if (resultado&&resultado1) {
      obtenerFavoritos();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Producto eliminado de favoritos'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al eliminar de favoritos'),
        ),
      );
    }
    return resultado;
  }

  Future<void> logout() async{
    DatabaseFavorite dbFavorite = DatabaseFavorite.instance;
    dbFavorite.deleteDatabse();

  }

  void variablesLista (){
    setState(() {
      if (listaState == true){
        cantColumnas = 1;
        tamano= 2.0;
        cantColumnasDos = 2;
      }else{
        cantColumnas = 2;
        tamano= 0.5;
        cantColumnasDos = 1;
      }
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      body: Padding( 
        padding: const EdgeInsets.all(15),
        child:  GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cantColumnas, // Número de columnas
          crossAxisSpacing: 10, // Espacio entre columnas
          mainAxisSpacing: 10, // Espacio entre filas
          childAspectRatio: tamano,
        ),
        itemCount: productos.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.fromLTRB(7, 10, 5, 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple),
            ),
            child: GridView.count(
              physics:  const NeverScrollableScrollPhysics(),
              crossAxisCount: cantColumnasDos,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              shrinkWrap: true, 
              children: [
                Image( 
                  fit: BoxFit.cover,
                  image: AssetImage('assets/${productos[index]['imagen']}')),
                Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Album:${productos[index]['nombre']}'),
                  Text('Vendedor: ${productos[index]['vendedor']}'),
                  Text('Calificación: ${productos[index]['calificacion'].toString()}'),
                  const Spacer(),
                 Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    if (favoritos)
      IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          eliminarFavorito(productos[index]['idProducto']);
        },
      )
    else
      IconButton(
        icon: const Icon(Icons.favorite),
        onPressed: () {
          agregarFavorito(productos[index]['idProducto'], productos[index]);
        },
      ),
  ],
)
                  
              ],
            ),

              ],)
           
            
          );
        },
      ),
      )
    );
  }
}

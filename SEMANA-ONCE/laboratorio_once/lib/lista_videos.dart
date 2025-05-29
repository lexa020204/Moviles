import 'package:flutter/material.dart';
import 'package:laboratorio_once/item_imagen.dart';

class ListaVideos extends StatefulWidget {
  const ListaVideos({super.key});

  @override
  State<ListaVideos> createState() => _ListaVideosState();
}


class _ListaVideosState extends State<ListaVideos> {
  

  dynamic awVideos = [
    {
      'nombre': 'Felicidad entre amigos',
      'tiempo': '0:09 sg',
      'tamano': '128 MB',
      'imagen': 'https://videocdn.cdnpk.net/videos/304facba-7027-4115-9d2a-8eacc21a3576/horizontal/thumbnails/large.jpg?item_id=166826',
      'url': 'https://videocdn.cdnpk.net/videos/304facba-7027-4115-9d2a-8eacc21a3576/horizontal/previews/clear/large.mp4?token=exp=1728418423~hmac=5cd25832caea124cabedea287817275271864c6d615161f50e916ac9717979ce'
    },
     {
      'nombre': 'Peces Azules',
      'tiempo': '0:08 sg',
      'tamano': '128 MB',
      'imagen': 'https://static.eldiario.es/clip/ce641782-934f-41f6-9080-def1f5c3d317_16-9-aspect-ratio_default_0.jpg',
      'url': 'https://cdn.pixabay.com/video/2018/05/12/16166-269541539_large.mp4'
    },

  {
      'nombre': 'Pug en la sala',
      'tiempo': '0:14 sg',
      'tamano': '128 MB',
      'imagen': 'https://www.infobae.com/new-resizer/ouNV3Etpe-tXC9peYEKV02kn3NY=/arc-anglerfish-arc2-prod-infobae/public/I5RSZR65RVEZRGA3ZFR6JLUWVI.jpg',
      'url': 'https://cdn.pixabay.com/video/2018/05/12/16166-269541539_large.mp4'
  },
  {
      'nombre': 'Gato en la pradera',
      'tiempo': '0:18 sg',
      'tamano': '128 MB',
      'imagen': 'https://www.tiendanimal.es/articulos/wp-content/uploads/2020/03/serval-1200x785.jpg',
      'url': 'https://cdn.pixabay.com/video/2022/11/28/140768-776026627_large.mp4'
  }



  ];

  /* */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
         appBar: AppBar(
          title: const Text('Lista de VIDEOS')
        ),
        body: Center(
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: awVideos.length,
            itemBuilder: (BuildContext context, int index ){
              return ItemImagen(sNombre: awVideos[index]['nombre'].toString(), 
              sTiempo: awVideos[index]['tiempo'].toString(),
              sTamano: awVideos[index]['tamano'].toString(),
              sImagen: awVideos[index]['imagen'].toString(),
              sUrl: awVideos[index]['url'].toString());
              
            }, 
            separatorBuilder: (BuildContext context, int index) => const Divider(),

          )

        )
    ));
  }
}

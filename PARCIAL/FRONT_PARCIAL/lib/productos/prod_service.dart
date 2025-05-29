import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; 
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProductosService {
  Future<List<Map<String, dynamic>>> getProductos() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final String url = 'http://${dotenv.env['HOST']}:3000/products';
    Map<String, String> headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
    };

    try{
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200){
        final data = json.decode(response.body);
        return  List<Map<String, dynamic>>.from(data['productos']);
      }else{
        return [];
      }
    }catch(e){
      print(e);
      return [];
    }
  }


   Future<List<Map<String, dynamic>>> getFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final String url = 'http://${dotenv.env['HOST']}:3000/getFav';
    Map<String, String> headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
    };

    try{
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200){
        final data = json.decode(response.body);
        return  List<Map<String, dynamic>>.from(data['favoritos']);
      }else{
        return [];
      }
    }catch(e){
      print(e);
      return [];
    }
  }

  Future <bool> agergarFav(int idProducto) async{
     final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final String url = 'http://${dotenv.env['HOST']}:3000/addFav';
    Map<String, String> headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
    };
    final Map<String, int> data = {
      'idProducto': idProducto,
      
    };

    try{
        final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(data),
        );

        if (response.statusCode == 200){
          return true;
        }
        else{
          return false;
        }
    }
    catch (e){
      return false;
    }

  }

  Future <bool> eliminarFav(int idProducto) async{
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final String url = 'http://${dotenv.env['HOST']}:3000/deleteFav';
      Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      };
      final Map<String, int> data = {
        'idProducto': idProducto,
        
      };
  
      try{
          final response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: json.encode(data),
          );
  
          if (response.statusCode == 200){
            return true;
          }
          else{
            return false;
          }
      }
      catch (e){
        return false;
      }
  }


}
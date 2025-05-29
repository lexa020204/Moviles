import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; 
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProductosService {
  Future<List<Map<String, dynamic>>> getProductos() async {
    
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);
    final String url = 'http://${dotenv.env['HOST']}:3000/products';

    Map<String, String> headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
    };

    try{
      print('holisss');
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      if (response.statusCode == 200){
        final data = json.decode(response.body);
        final List<dynamic> products = data['productos'];
        print(products);
        return  List<Map<String, dynamic>>.from(products);
      }else{
        return [];
      }
    }catch(e){
      print(e);
      return [];
    }
  }

}
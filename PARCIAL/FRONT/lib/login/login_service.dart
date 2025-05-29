
import 'package:http/http.dart' as http;
import 'dart:convert'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; 


class LoginService {
  Future<void> saveToken(String token) async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
        }

  Future<bool> isLogged() async {
    print('holisssss');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null && !JwtDecoder.isExpired(token);
  }

   Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<bool> enviarInfo(String sUsuario, String sContrasena) async {

    final String url = 'http://${dotenv.env['HOST']}:3000/login';

    final Map<String, String> data = {
      'usuario': sUsuario,
      'contrasena': sContrasena,
    };

    try{
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200){
        final data = json.decode(response.body);
        final token = data['accessToken'];
        saveToken(token);
        return true;
        
    }
    else{
      print('Error en la petición');
      return false;
      
    }
   
  }
  catch (e){
    print(e);
    return false;
    
  }
}
}
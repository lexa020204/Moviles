
import 'package:http/http.dart' as http;
import 'package:parcial/config.dart';
import 'package:parcial/firebase_service.dart';
import 'dart:convert'; 
import 'package:shared_preferences/shared_preferences.dart';

class LoginService{
   Future<bool> enviarInfo(String sUsuario, String sContrasena, String sTokenFcm) async {

    const  String url = 'http://${Config.HOST}:3000/login';

    final Map<String, String> data = {
      'email': sUsuario,
      'contrasena': sContrasena,
      'fcm_token': sTokenFcm,
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
        print('holis');
        final data = json.decode(response.body);
        final token = data['accessToken'];
        saveToken(token);
        saveEmail(sUsuario);
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

  Future<void> saveToken(String token) async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
        }

  Future<void> saveEmail(String email) async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', email);
        }

  Future<String> getEmail() async {
          final prefs = await SharedPreferences.getInstance();
          return prefs.getString('email') ?? '';
  }

  Future<bool> logout() async {
   const  String url = 'http://${Config.HOST}:3000/eliminarToken';
   

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token').toString();
    final email = prefs.getString('email').toString();
    final sTokenFcm = await FirebaseService().getToken();
    sTokenFcm.toString();
    print(sTokenFcm);
    final Map<String, String> data = {
     "email": email,
      "fcm_token": sTokenFcm,
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
        await prefs.remove('token');
        await prefs.remove('email');
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

import 'package:http/http.dart' as http;
import 'dart:convert'; 
import 'package:shared_preferences/shared_preferences.dart'; 


class LoginService {
  Future<void> saveToken(String token) async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
        }

  Future<bool> isLogged() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null;
  }

   Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<bool> enviarInfo(String sUsuario, String sContrasena) async {

    const String url = 'http://localhost:3000/login';

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
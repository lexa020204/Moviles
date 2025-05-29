import 'package:flutter_quiz_3/login/login_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; 
import 'package:flutter_dotenv/flutter_dotenv.dart'; 
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService{
  final _auth = LocalAuthentication();
  final storage = const FlutterSecureStorage();

  Future<bool> autenticar() async {
    bool autenticado = false;
    
    try {
      autenticado = await _auth.authenticate(
        localizedReason: 'Autenticación necesaria',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      print('Error en la autenticación: $e');
    }
    return autenticado;
    
  }

  Future<bool> enviarDatos(String sUsuario, String sContrasena) async {

    final String url = 'http://${dotenv.env['HOST']}:3000/regHuella';
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
  
  Future<bool> enviarToken(String token) async{
    final loginService = LoginService();
    final String url = 'http://${dotenv.env['HOST']}:3000/logHuella';
      Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      };
      try{
        final response = await http.post(
        Uri.parse(url),
        headers: headers,
        );

        if(response.statusCode == 200){
          final data = json.decode(response.body);
          final token = data['accessToken'];
          loginService.saveToken(token);
          return true;
        }
        else{
          return false;
        }
      }
      catch(e){
        print(e);
        return false;
      }

  }

  Future<void> saveToken(String token) async {
  await storage.write(key: 'accessToken', value: token);
  }

  Future<String> readToken() async {
  // Leer el token del almacenamiento seguro
  String? token = await storage.read(key: 'accessToken');

      if (token != null) {
        return token;
      } else {
        return '';
      }
  }

  Future<bool> removeToken() async {
    String? token = await storage.read(key: 'accessToken');
    if (token != null) {
      await storage.delete(key: 'accessToken');
      return true;
    }
    else{
      return false;
    }
  }


}
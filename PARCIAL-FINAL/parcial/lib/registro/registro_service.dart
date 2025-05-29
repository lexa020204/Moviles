import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:parcial/config.dart';
import 'package:http/http.dart' as http;
import 'package:parcial/login/login_service.dart';

class RegistroService{
  Future<bool> registrarUsuario(
   
    String email, String password, String  imagen64, String phone, String name, String cargo, String fcmToken) async{
      
      print(fcmToken);
      const String url = 'http://${Config.HOST}:3000/register';
      debugPrint(url);

      final Map<String, dynamic> data = {
        'email': email,
        'contrasena': password,
        'imagen': imagen64,
        'telefono': phone,
        'nombre': name,
        'cargo': cargo,
        'fcm_token': fcmToken
      };

      try{
        final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
        );
      
        if(response.statusCode == 200){
          await LoginService().saveEmail(email);
          return true;
        }
        else{
          return false;
        }
        
      }
      catch(e){
        return false;
      }

  }
}
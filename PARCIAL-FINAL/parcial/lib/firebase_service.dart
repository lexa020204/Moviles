import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class FirebaseService{
  final _firebaseMessaging = FirebaseMessaging.instance;
 //Inicializar las notificaciones
  Future<void> init() async{  

    await Firebase.initializeApp();
    //Obtenemos el permiso del usuario
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

     
  }


  Future<String> getToken() async{
    final fCMtoken = await _firebaseMessaging.getToken();
    final token = fCMtoken.toString();
    return token;
  }





}

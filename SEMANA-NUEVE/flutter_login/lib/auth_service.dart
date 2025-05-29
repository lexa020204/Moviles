
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthService{
  final _auth = LocalAuthentication();

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
  
  Future<bool> existeHuella() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('huella');
  }

}
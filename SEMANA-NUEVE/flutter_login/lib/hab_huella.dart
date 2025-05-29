import 'package:flutter/material.dart';
import 'package:flutter_login/auth_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

ButtonStyle buttonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.purple,
    textStyle: const TextStyle(
      fontSize: 15,
    ),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

class HabHuella extends StatefulWidget {
  const HabHuella({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HabHuellaState createState() => _HabHuellaState();
}

class _HabHuellaState extends State<HabHuella> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10),
          height: 400,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.purple, width: 2),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Habilitar login con Datos biométricos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final authService = AuthService();
                  final autenticacion = await authService.autenticar();
                  if (autenticacion) {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('huella', true);
                    Get.toNamed('/vistauno');
                  }
                },
                child: const Text('Habilitar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}


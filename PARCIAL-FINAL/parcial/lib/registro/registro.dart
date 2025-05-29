import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parcial/firebase_service.dart';
import 'package:parcial/registro/registro_service.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {

  ButtonStyle styleButton = ElevatedButton.styleFrom(
    fixedSize: const Size(400,30),
      backgroundColor: Colors.purple,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8), // Bordes cuadrados
      ),
      textStyle: const TextStyle(
        fontSize: 15,
      ),
      foregroundColor: Colors.white,
  );

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cargoController = TextEditingController();
  String? fcmToken;

  @override
  void initState() {
    super.initState();
    _initializeFcmToken();
  }

  Future<void> _initializeFcmToken() async {
    fcmToken = await FirebaseService().getToken();
  }
  

  File? _image;
  final picker = ImagePicker();
  String? base64Image;
  
  
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,
    imageQuality: 10);

    setState(() {
      if(pickedFile != null){
        _image = File(pickedFile.path);
    }

    List<int> imageBytes = File(_image!.path).readAsBytesSync();
    base64Image = base64Encode(imageBytes);
    debugPrint(base64Image);
  });
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(child: Container(
        width: 400,
        margin: const EdgeInsets.fromLTRB(20, 90, 20, 20),
        child: Column(
          children: [
            const Text('Ingresa tus datos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            const SizedBox(height: 20),
            TextField( 
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Correo Electrónico",
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 20),
            TextField( 
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Contraseña",
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 20),
            TextField( 
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Nombre Completo",
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 20),
            TextField( 
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: "Teléfono",
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 20),
            TextField( 
              controller: _cargoController,
              decoration: const InputDecoration(
                labelText: "Cargo",
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: styleButton,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Cargar Imagen'),
              onPressed: getImage,
              
            ),
            const SizedBox(height: 20),
            if(_image != null)
              Image.file(_image!,
              height: 60,
              width: 60,
              fit: BoxFit.cover,),
            const SizedBox(height: 20),
            ElevatedButton(
              style: styleButton,
              onPressed: () async {
                final success = await RegistroService().registrarUsuario(
                  _emailController.text,
                  _passwordController.text,
                  base64Image!,
                  _phoneController.text,
                  _nameController.text,
                  _cargoController.text,
                  fcmToken.toString()
                );
                if(success){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Usuario registrado correctamente'),
                      backgroundColor: Colors.green,
                    )
                  );
                  Get.toNamed('/menu');
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error al registrar el usuario'),
                      backgroundColor: Colors.red,
                    )
                  );
                }
                
              },
              child: const Text("Registrar"),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('¿Ya tienes cuenta?'),
                TextButton(
                  onPressed: () {
                   Get.toNamed('/login');
                  },
                  child: const Text('Inicia Sesión'),
                )
              ],
            )



          ],),

      ),)
    );
  }
}
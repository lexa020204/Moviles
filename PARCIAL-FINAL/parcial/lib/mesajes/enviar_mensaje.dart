import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial/mesajes/mesaje_service.dart';

class EnviarMensaje extends StatelessWidget {
  final String emailOrigen;
  final String emailDestinatario;
  EnviarMensaje({ 
    required this.emailOrigen, required this.emailDestinatario, 
    super.key});
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Título del Mensaje',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: bodyController,
            decoration: const InputDecoration(
              labelText: 'Cuerpo del Mensaje',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 30),
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Bordes cuadrados
                  ),
                  textStyle: const TextStyle(
                    fontSize: 15,
                  ),
                  foregroundColor: Colors.white,
                ),
                onPressed: () async{
                  final mensaje = await MesajeService().enviarInfo(
                    titleController.text,
                    bodyController.text,
                    emailDestinatario,
                    emailOrigen,
                  );

                  if (!mensaje) {
                    Get.snackbar('Error', 'Error al enviar el mensaje');
                  }else{
                    Get.snackbar('Mensaje Enviado', 'Mensaje enviado a $emailDestinatario');
                     // Limpia los campos
                    titleController.clear();
                    bodyController.clear();
                  }
                },
                child: const Text('Enviar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

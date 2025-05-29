
import 'package:flutter/material.dart';
import 'boton.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => CalculadoraState();
}

//Estilo de los botones

const gris = Color(0xFF6b6b6b);
const naranja = Color.fromARGB(255, 214, 133, 12);
const verde = Color(0xFFC0C89F);

BoxDecoration estiloContenedor(){
  return BoxDecoration(
      border: Border.all(color:const Color(0xFFEEEEEE), width: 7),
      color: const Color(0xFFEEEEEE),
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(255, 0, 0, 0),
          blurRadius: 10
        ),
      ],
    );
}

InputDecoration estiloTextField(){
  return InputDecoration(
         enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: verde), borderRadius: BorderRadius.circular(10)), 
          labelStyle: const TextStyle(fontSize: 30 ),
          filled: true,
          fillColor: verde,
  
        );
}



class CalculadoraState extends State<Calculadora> {
 
  final TextEditingController _oControlador=TextEditingController();
  double _dNumeroUno = 0;
  double _dNumeroDos = 0;
  String _sOperador = "";
  

  void _actualizarPantalla(String sText){
    if (sText == "AC" || sText == "CE"){
      _oControlador.text = " "; 
    }else{
      _oControlador.text = "${_oControlador.text}$sText";
    }
  }

  void _obtenerOperador(String sText){
    if (_oControlador.text != "" && _sOperador == ""){
      _sOperador = sText;
      _actualizarPantalla(sText);
    }
  }

  void _realizarOperacion(String sText){
    if(_sOperador != ""){
      List<String> parts = _oControlador.text.split(_sOperador);
      _dNumeroUno = double.parse(parts[0]);
      _dNumeroDos = double.parse(parts[1]);
      switch (_sOperador){
        case "+":
          _oControlador.text = (_dNumeroUno + _dNumeroDos).toString();
          break;
        case "-":
          _oControlador.text = (_dNumeroUno - _dNumeroDos).toString();
          break;
        case "x":
          _oControlador.text = (_dNumeroUno * _dNumeroDos).toString();
          break;
        case "÷":
          _oControlador.text = (_dNumeroUno / _dNumeroDos).toString();
          break;
        case "%":
          _oControlador.text = (_dNumeroUno % _dNumeroDos).toString();
          break;
      }
      _sOperador = "";
    }

  }
  

  /* En este método es donde se diseña*/
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      body: Center(
        child: 
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          height: 500.0,
          decoration: BoxDecoration(
            color: const Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 0, 0, 0),
                blurRadius: 10
              ),
            ],
          ),
          child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: estiloContenedor(),
                  child: TextField(
                    controller: _oControlador,
                    decoration: estiloTextField(),
                  ),

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Boton(sText: "AC", oColor: naranja, fCallBack: (String sText) => _actualizarPantalla(sText)),
                    Boton(sText: "CE", oColor: naranja, fCallBack: (String sText) => _actualizarPantalla(sText)),
                    Boton(sText: "%", oColor: gris, fCallBack: (String sText) => _obtenerOperador(sText)),
                    Boton(sText:  "÷", oColor: gris, fCallBack: (String sText) => _obtenerOperador(sText)),
                  ],
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Boton(sText:"7",oColor: gris, fCallBack: (String sText) => _actualizarPantalla(sText)),
                    Boton(sText:"8",oColor: gris, fCallBack: (String sText) => _actualizarPantalla(sText)),
                    Boton(sText:"9",oColor: gris, fCallBack: (String sText) => _actualizarPantalla(sText)),
                    Boton(sText:"x",oColor: gris, fCallBack: (String sText) => _obtenerOperador(sText)),
                  ],
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Boton(sText:"4",oColor: gris, fCallBack: (String sText) => _actualizarPantalla(sText)),
                    Boton(sText:"5",oColor: gris, fCallBack: (String sText) => _actualizarPantalla(sText)),
                    Boton(sText:"6",oColor: gris, fCallBack: (String sText) => _actualizarPantalla(sText)),
                    Boton(sText:"-",oColor: gris, fCallBack: (String sText) => _obtenerOperador(sText)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Boton(sText:"1",oColor: gris,fCallBack: (String sText) => _actualizarPantalla(sText)),
                        Boton(sText:"0",oColor: gris,fCallBack: (String sText) => _actualizarPantalla(sText))
                      ],
                    ),
                    Column(
                      children: [
                       Boton(sText:"2",oColor: gris,fCallBack: (String sText) => _actualizarPantalla(sText)),
                        Boton(sText:".",oColor: gris,fCallBack: (String sText) => _actualizarPantalla(sText))
                      ],
                    ),
                    Column(
                      children: [
                        Boton(sText:"3",oColor: gris,fCallBack: (String sText) => _actualizarPantalla(sText)),
                        Boton(sText:"=",oColor: gris,fCallBack: (String sText) => _realizarOperacion(sText))
                      ],
                    ),
                    Column(
                      children: [
                        Boton(sText:"+",oColor: gris,fCallBack: (String sText) => _obtenerOperador(sText)),
                      ],
                    )
                  ],
                )
              ],
            ),
      ),
    )));
  }
}

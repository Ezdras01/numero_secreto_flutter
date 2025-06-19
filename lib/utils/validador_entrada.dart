import 'package:numero_secreto_flutter/models/dificultad.dart';

class ValidadorEntrada {
static String? validar(String entrada, Dificultad dificultad){
  //validamos que se ingrese un numero
  if (entrada.trim().isEmpty){
    return 'Por favor ingrese un número';
  }
  //validamos que el numero sea un entero
  final numero= int.tryParse(entrada);
  if (numero==null) {
    return 'Por favor ingrese un número entero';
  }
  //validamos que el numero este dentro del rango de dificultad
  if (numero<dificultad.minimo || numero>dificultad.maximo){
    return 'El número debe estar entre ${dificultad.minimo} y ${dificultad.maximo}';
  }
  //si no hay errores devolvemos null
  return null;

}
}
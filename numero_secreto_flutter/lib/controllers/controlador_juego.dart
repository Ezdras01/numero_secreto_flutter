// aqui se encuentra TODA la logica del juego

import 'dart:math';
import 'package:numero_secreto_flutter/models/intento_resultado.dart';
import 'package:numero_secreto_flutter/models/dificultad.dart';

class ControladorJuego {
  //generador de numeros aleatorios
  final Random _aleatorio = Random();

  late Dificultad _dificultadActual;
  late int _numeroSecreto;
  late int _intentosRestantes = 0;
  bool _juegoTerminado = false;

// creacion de listas privadas para las columnas "mayor que" y "menor que"
  final List<int> _numerosMayores = [];
  final List<int> _numerosMenores = [];
//creacion de lista privada para el historial de intentos 
  final List<Map<String, dynamic>> _historial = [];


}
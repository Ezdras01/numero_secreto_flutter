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

  Dificultad get dificultad => _dificultadActual;
  int get intentosRestantes => _intentosRestantes;
  bool get juegoTerminado => _juegoTerminado;
  List<int> get numerosMayores => List.unmodifiable(_numerosMayores);
  List<int> get numerosMenores => List.unmodifiable(_numerosMenores);
  List<Map<String, dynamic>> get historial => List.unmodifiable(_historial);

//nos ayuda a iniciar el juego con el nivel de dificultad seleccionado
  void iniciarJuego(NivelDificultad nivel) {
    _dificultadActual = Dificultad.desdeNivel(nivel);
    _numeroSecreto = _aleatorio.nextInt(// genra el numero secreto de forma aleatoria dependiendo del nivel de dificultad
          _dificultadActual.maximo - _dificultadActual.minimo + 1,
        ) +
        _dificultadActual.minimo;
    _intentosRestantes = _dificultadActual.intentosMaximos;// aqui establecemos los intentos que tendrá el juador dependiendo del nivel de dificultad
    _numerosMayores.clear();//limpiar columna mayores que 
    _numerosMenores.clear();// limpirar columna menores que
    _juegoTerminado = false;
  }


}
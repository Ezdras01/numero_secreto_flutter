import 'package:flutter/material.dart';

import 'package:numero_secreto_flutter/controllers/controlador_juego.dart';
import 'package:numero_secreto_flutter/models/dificultad.dart';
import 'package:numero_secreto_flutter/utils/validador_entrada.dart';

void main() {
  runApp(const JuegoApp());
}

class JuegoApp extends StatelessWidget {
  const JuegoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adivina el número',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const JuegoAdivinarNumero(),
    );
  }
}

class JuegoAdivinarNumero extends StatefulWidget {
  const JuegoAdivinarNumero({super.key});

  @override
  State<JuegoAdivinarNumero> createState() => _JuegoAdivinarNumeroState();
}

class _JuegoAdivinarNumeroState extends State<JuegoAdivinarNumero> {
  final ControladorJuego _controlador = ControladorJuego();
  NivelDificultad _nivelActual = NivelDificultad.facil;

  @override
  void initState() {
    super.initState();
    _controlador.iniciarJuego(_nivelActual);
  }

  @override
  Widget build(BuildContext context) {
    final dificultad = _controlador.dificultad;

    return Scaffold(
      appBar: AppBar(
        title: Text('Nivel: ${dificultad.obtenerNombre()}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Aquí más adelante pondremos el cambio de nivel
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Bienvenido al juego 😄',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
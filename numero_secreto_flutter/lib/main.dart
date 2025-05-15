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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ==================== Caja de entrada de número ====================
            Row(
              children: [
                // Caja para escribir el número
                const Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Ingresa un número',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Botón para enviar el número
                ElevatedButton(
                  onPressed: () {
                    // Aquí más adelante llamaremos al método para enviar el número
                  },
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
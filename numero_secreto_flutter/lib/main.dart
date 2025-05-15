import 'package:flutter/material.dart';

import 'package:numero_secreto_flutter/controllers/controlador_juego.dart';
import 'package:numero_secreto_flutter/models/dificultad.dart';
import 'package:numero_secreto_flutter/utils/validador_entrada.dart';
import 'package:numero_secreto_flutter/models/intento_resultado.dart';
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
  // ================== SECCIÓN: Variables de estado ==================
  final ControladorJuego _controlador = ControladorJuego();
  final TextEditingController _campoNumero = TextEditingController();

  NivelDificultad _nivelActual = NivelDificultad.facil;
  String? _mensajeFinal;

  @override
  void initState() {
    super.initState();
    _controlador.iniciarJuego(_nivelActual);
  }

  @override
  void dispose() {
    _campoNumero.dispose();
    super.dispose();
  }

  // ================== SECCIÓN: Función para enviar número ==================
  void _enviarNumero() {
    final entrada = _campoNumero.text;

    final error = ValidadorEntrada.validar(entrada, _controlador.dificultad);
    if (error != null) {
      _mostrarAlerta(error);
      return;
    }

    final numero = int.parse(entrada);
    final resultado = _controlador.intentar(numero);

    setState(() {
      _campoNumero.clear();

      if (_controlador.juegoTerminado) {
        _mensajeFinal = resultado.tipo == TipoResultado.correcto
            ? '¡Adivinaste el número! 🎉'
            : 'Juego terminado. El número era ${_controlador.historial.last['numero']}.';
      }
    });
  }

  // ================== SECCIÓN: Mostrar alertas ==================
  void _mostrarAlerta(String mensaje) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Entrada inválida'),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  // ================== SECCIÓN: Interfaz ==================
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
                Expanded(
                  child: TextField(
                    controller: _campoNumero,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Ingresa un número',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Botón para enviar el número
                ElevatedButton(
                  onPressed: _controlador.juegoTerminado ? null : _enviarNumero,
                  child: const Text('Enviar'),
                ),
              ],
            ),

            // =============== Mensaje final si el juego terminó ===============
            if (_mensajeFinal != null) ...[
              const SizedBox(height: 12),
              Text(
                _mensajeFinal!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: _mensajeFinal!.contains('🎉') ? Colors.green : Colors.red,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

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
  // ================== Variables de estado ==================
  final ControladorJuego _controlador = ControladorJuego();
  final TextEditingController _campoNumero = TextEditingController();

  final ScrollController _scrollMayor = ScrollController();
  final ScrollController _scrollMenor = ScrollController();
  final ScrollController _scrollHistorial = ScrollController();

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

  // ================== Función para enviar número ==================
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

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _controlador.iniciarJuego(_nivelActual);
            _mensajeFinal = null;
          });
        }
      });
    }
  });
  // Desplazar las listas hacia abajo después de agregar un nuevo número
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (_scrollMayor.hasClients) {
      _scrollMayor.jumpTo(_scrollMayor.position.maxScrollExtent);
    }
    if (_scrollMenor.hasClients) {
      _scrollMenor.jumpTo(_scrollMenor.position.maxScrollExtent);
    }
    if (_scrollHistorial.hasClients) {
      _scrollHistorial.jumpTo(_scrollHistorial.position.maxScrollExtent);
    }
  });
}


  // ================== Mostrar alertas ==================
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

  // ================== Diálogo de confirmación ==================
  void _mostrarDialogoConfirmacionDificultad() {
    bool limpiarHistorial = false;

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('¿Cambiar dificultad?'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('¿Deseas reiniciar el historial también?'),
                  Row(
                    children: [
                      Checkbox(
                        value: limpiarHistorial,
                        onChanged: (valor) {
                          setStateDialog(() {
                            limpiarHistorial = valor!;
                          });
                        },
                      ),
                      const Text('Sí, limpiar historial')
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _mostrarSelectorDificultad(limpiarHistorial);
                  },
                  child: const Text('Cambiar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _mostrarSelectorDificultad(bool limpiarHistorial) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: NivelDificultad.values.map((nivel) {
            final nombre = Dificultad.desdeNivel(nivel).obtenerNombre();
            return ListTile(
              title: Text(nombre),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _nivelActual = nivel;
                  _controlador.iniciarJuego(nivel);
                  _campoNumero.clear();
                  _mensajeFinal = null;
                  if (limpiarHistorial) {
                    _controlador.limpiarHistorial();
                  }
                });
              },
            );
          }).toList(),
        );
      },
    );
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
            onPressed: _mostrarDialogoConfirmacionDificultad,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================== Visulización de intentos restantes ====================
            Text(
              'Intentos restantes: ${_controlador.intentosRestantes}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
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
                  color:
                      _mensajeFinal!.contains('🎉') ? Colors.green : Colors.red,
                ),
              ),
            ],

            const SizedBox(height: 24),

            // ================= Título columnas =================
            const Text(
              'Resultados:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // ================= Columnas =================
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _columna(
                        'Menor a', _controlador.numerosMayores, _scrollMayor),
                    const SizedBox(width: 16),
                    _columna(
                        'Mayor a', _controlador.numerosMenores, _scrollMenor),
                    const SizedBox(width: 16),
                    _columnaHistorial(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================== Widgets para columnas ==================
  Widget _columna(
      String titulo, List<int> numeros, ScrollController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          width: 100,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Scrollbar(
            thumbVisibility: true,
            controller: controller,
            child: ListView.builder(
              controller: controller,
              itemCount: numeros.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Center(
                    child: Text(
                      numeros[index].toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

Widget _columnaHistorial() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Historial', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Container(
        width: 120,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Scrollbar(
          thumbVisibility: true,
          controller: _scrollHistorial,
          child: ListView.builder(
            controller: _scrollHistorial,
            itemCount: _controlador.historial.length,
            itemBuilder: (_, index) {
              final registro = _controlador.historial[index];
              final numero = registro['numero'];
              final acerto = registro['acerto'] as bool;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Center(
                  child: Text(
                    numero.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: acerto ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ],
  );
}
}

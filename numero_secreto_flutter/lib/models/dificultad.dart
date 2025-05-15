
enum NivelDificultad { facil, medio, avanzado, extremo }

class Dificultad {
  final NivelDificultad nivel;
  final int minimo;
  final int maximo;
  final int intentosMaximos;

  Dificultad({
    required this.nivel,
    required this.minimo,
    required this.maximo,
    required this.intentosMaximos,
  });
  
}// el que cierra 
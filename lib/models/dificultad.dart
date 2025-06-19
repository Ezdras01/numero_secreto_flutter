
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

  factory Dificultad.desdeNivel(NivelDificultad nivel) {
    switch (nivel) {
      case NivelDificultad.facil:
        return Dificultad(nivel: nivel, minimo: 1, maximo: 10, intentosMaximos: 5);
      case NivelDificultad.medio:
        return Dificultad(nivel: nivel, minimo: 1, maximo: 20, intentosMaximos: 8);
      case NivelDificultad.avanzado:
        return Dificultad(nivel: nivel, minimo: 1, maximo: 100, intentosMaximos: 15);
      case NivelDificultad.extremo:
        return Dificultad(nivel: nivel, minimo: 1, maximo: 1000, intentosMaximos: 25);
    }
  }

    String obtenerNombre() {
    switch (nivel) {
      case NivelDificultad.facil:
        return 'Fácil';
      case NivelDificultad.medio:
        return 'Medio';
      case NivelDificultad.avanzado:
        return 'Avanzado';
      case NivelDificultad.extremo:
        return 'Extremo';
    }
  }

}// el que cierra 
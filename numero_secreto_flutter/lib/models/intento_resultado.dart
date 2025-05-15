
enum TipoResultado { mayor, menor, correcto}

class IntentoResultado {
  final int numeroIngresado;

  final TipoResultado tipo;

  IntentoResultado({
    required this.numeroIngresado,
    required this.tipo,
  });
  
  }//el que cierra
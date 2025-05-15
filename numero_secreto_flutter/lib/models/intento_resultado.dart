
enum TipoResultado { mayor, menor, correcto}

class IntentoResultado {
  final int numeroIngresado;

  final TipoResultado tipo;

  IntentoResultado({
    required this.numeroIngresado,
    required this.tipo,
  });
  
  String comoTexto() {
    switch (tipo) {
      case TipoResultado.mayor:
        return 'Mayor que el número secreto';
      case TipoResultado.menor:
        return 'Menor que el número secreto';
      case TipoResultado.correcto:
        return '¡Correcto!';
    }
  }
  }//el que cierra
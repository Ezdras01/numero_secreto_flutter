# 🎯 Número Secreto Flutter

Un juego interactivo desarrollado con Flutter, donde los usuarios deben adivinar un número secreto dentro de un rango determinado según el nivel de dificultad seleccionado.  
Incluye validación de entradas, historial visual de intentos y gestión dinámica de niveles.

---

## ✨ Características

- 🎚️ 4 niveles de dificultad: **Fácil**, **Medio**, **Avanzado** y **Extremo**
- 🔢 Validación de entradas numéricas dentro del rango permitido
- 🟢 Historial de juegos acertados y fallidos con indicadores de color
- 📜 Columnas con desplazamiento (scroll) para mostrar intentos mayores, menores e historial
- 🔄 Reinicio automático del juego tras 2 segundos al ganar o perder
- ⚙️ Opción para cambiar la dificultad y limpiar el historial

---


## 📸 Capturas de pantalla

| Inicio | Victoria | Derrota |
|-------|----------|---------|
| ![Inicio](screenshot/flutter_01.png) | ![Ganaste](screenshot/flutter_03.png) | ![Perdiste](screenshot/flutter_04.png) |

| Reinicio | Cambiar dificultad | Entrada inválida |
|----------|---------------------|------------------|
| ![Reinicio](screenshot/flutter_05.png) | ![Dificultad](screenshot/flutter_06.png) | ![Entrada inválida](screenshot/flutter_11.png) |

| Niveles | Historial Scroll |
|---------|------------------|
| ![Nivel Medio](screenshot/flutter_08.png) ![Nivel Avanzado](screenshot/flutter_09.png) ![Nivel Extremo](screenshot/flutter_10.png) | ![Historial](screenshot/flutter_12.png) |

---

## Instalación y ejecución

1. Clona el repositorio:

```bash
git clone https://github.com/Ezdras01/numero_secreto_flutter.git
cd numero_secreto_flutter  # Entra a la carpeta del proyecto recién clonado

2. Instalar dependecias:
flutter pub get

3. Correr el proyecto:
futter run 

4. Generar APK
flutter build apk --release

## Autor

- Ezra Lehi Cortez — [@Ezdras01](https://github.com/Ezdras01)

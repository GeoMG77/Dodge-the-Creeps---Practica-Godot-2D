# Dodge the Creeps - Práctica Godot 2D

**Autor:** Oliver Geovanni Melendrez Gutierrez
**Carrera:** Ingeniería en Cómputo - CUCEI, Universidad de Guadalajara

## Descripción del Proyecto
Este repositorio contiene la implementación completa del tutorial oficial "Your first 2D game" de Godot Engine. El objetivo principal de la práctica es consolidar los conceptos de la arquitectura de Godot ("todo es un nodo"), la instanciación de escenas como prefabs, la emisión de señales y el flujo básico de desarrollo de videojuegos en 2D. 

## Estructura de Escenas y Nodos
El juego está orquestado mediante una escena principal (`Main`) que gestiona el flujo del juego e instancia las siguientes escenas independientes:
- **Player:** Maneja el movimiento (GDScript), la detección de colisiones (`Area2D`) y las animaciones de estado.
- **Mob:** Enemigos instanciados dinámicamente con comportamiento de físicas (`RigidBody2D`) y animaciones.
- **HUD:** Interfaz de usuario que se comunica con `Main` a través de señales para actualizar el score y el estado del juego.
- **PowerUp:** Escena extra añadida para la mecánica personalizada.

## Pasos Extras Implementados (Requisito de Rúbrica)
Además del tutorial base, se implementaron las siguientes características:

1. **Reemplazo de Assets (itch.io):** 
   - Se reemplazaron los sprites originales de los enemigos por assets de Esqueletos animados.
   - Se reemplazó el diseño del protagonista.
   - Se programó lógica adicional para invertir dinámicamente el sprite de los esqueletos (`flip_h`) según la dirección de su velocidad lineal para evitar el efecto de desplazamiento invertido.

2. **Nueva Mecánica de Juego (Estrella de Invencibilidad):**
   - Se agregó un sistema de "Power-Up" instanciado aleatoriamente por un temporizador.
   - Al recolectar el objeto, el estado del jugador cambia visualmente y su lógica de colisión se invierte: durante 5 segundos, en lugar de recibir daño, el jugador destruye a los enemigos al contacto mediante `queue_free()`.
   - Se implementó el uso de Grupos de nodos (`add_to_group("power_ups")`) para limpiar la pantalla de objetos sobrantes al reiniciar la partida.

## Instrucciones de Ejecución
En la carpeta /build se encuentra un archivo de texto con el enlace de descarga directa al ejecutable del juego (alojado en Drive debido a los límites de tamaño de GitHub). Está compilado y listo para probarse en Windows. 

Para revisar el código fuente, se recomienda abrir el archivo `project.godot` utilizando la rama *stable* del motor Godot.

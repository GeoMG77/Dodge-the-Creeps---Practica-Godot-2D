extends Area2D

# 1. Definición de señales personalizadas
signal hit

# 2. Variables del jugador
@export var speed = 400 # Velocidad del jugador en píxeles por segundo.
var screen_size # Tamaño de la ventana del juego.
var invencible = false


# 3. Se ejecuta automáticamente cuando el nodo entra a la escena
func _ready():
	screen_size = get_viewport_rect().size
	# Conectamos automáticamente la señal de colisión por código:
	body_entered.connect(_on_body_entered)


# 4. Se ejecuta en cada frame del juego (controla movimiento y animaciones)
func _process(delta):
	var velocity = Vector2.ZERO # Vector de movimiento del jugador.

	# Detectar entradas de teclado
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	# Aplicar velocidad y reproductor de animaciones
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	# Actualizar posición y restringir dentro de la pantalla
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	# Cambiar animación según la dirección
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y < 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = false
	elif velocity.y > 0:
		$AnimatedSprite2D.animation = "down"
		$AnimatedSprite2D.flip_v = false


# 5. Función que se activa cuando un enemigo (RigidBody2D) toca al jugador
func _on_body_entered(body):
	if invencible:
		# Destruyes al enemigo en lugar de morir.
		body.queue_free() 
	else:
		hide() # El jugador desaparece tras recibir un golpe
		hit.emit() # Emite la señal 'hit'
		# Se desactiva la colisión de forma diferida para evitar errores en el motor de físicas
		$CollisionShape2D.set_deferred("disabled", true)


# 6. Función para reiniciar al jugador al empezar una partida nueva
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func activar_estrella():
	invencible = true
	# Pintamos al Sprite de amarillo (Rojo al 100%, Verde al 100%, Azul al 0%)
	$AnimatedSprite2D.modulate = Color(0.808, 0.086, 0.0, 1.0) 
	$StarTimer.start()


func _on_star_timer_timeout():
	invencible = false
	# Regresamos el Sprite a la normalidad (Blanco)
	$AnimatedSprite2D.modulate = Color(1, 1, 1)

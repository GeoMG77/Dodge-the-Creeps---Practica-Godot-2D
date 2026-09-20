extends Node

@export var mob_scene: PackedScene
@export var power_up_scene: PackedScene # Añade esta línea
var score: int


func _ready():
	pass


# Se llama cuando el jugador presiona el botón Start en el HUD
func new_game():
	score = 0
	
	# Limpia los enemigos (mobs) de la partida anterior
	get_tree().call_group("mobs", "queue_free")
	
	get_tree().call_group("power_ups", "queue_free")
	
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	# Actualiza la interfaz
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	
	# Reproduce la música de fondo
	$Music.play()
	$PowerUpTimer.start()

# Se activa cuando el jugador colisiona con un enemigo
func _on_player_hit() -> void:
	game_over()


# Detiene los timers, detiene la música, reproduce el sonido de derrota y notifica al HUD
func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	
	# Audio de derrota
	$Music.stop()
	$DeathSound.play()
	$PowerUpTimer.stop()


# Incrementa la puntuación y la actualiza en el HUD
func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


# Inicia la generación de enemigos y la puntuación tras la cuenta regresiva inicial
func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()


# Genera un nuevo enemigo en el borde de la pantalla
func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()

	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	mob.position = mob_spawn_location.position

	var direction = mob_spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	add_child(mob)


func _on_power_up_timer_timeout():
	# Creamos una instancia de la estrella
	var power_up = power_up_scene.instantiate()
	# Obtenemos el tamaño de tu pantalla
	var screen_size = get_viewport().get_visible_rect().size
	# Le damos una posición X y Y aleatoria dentro de los límites de la pantalla
	power_up.position = Vector2(randf_range(0, screen_size.x), randf_range(0, screen_size.y))
	# Añadimos la estrella a la escena principal
	add_child(power_up)

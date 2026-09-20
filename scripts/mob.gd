extends RigidBody2D


# 1. Se ejecuta automáticamente cuando el enemigo es creado
func _ready():
	# Obtiene la lista de nombres de animaciones de tu AnimatedSprite2D
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	
	# Selecciona una animación al azar de esa lista y la reproduce
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()


# 2. Función que se activa cuando el enemigo sale por completo de la pantalla
func _on_visible_on_screen_notifier_2d_screen_exited():
	# Borra al enemigo de la escena para liberar memoria
	queue_free()

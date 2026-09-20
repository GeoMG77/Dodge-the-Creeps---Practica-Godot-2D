extends Area2D

func _ready():
	add_to_group("power_ups") # Mete el rayo a este grupo en cuanto nace

func _on_area_entered(area):
	if area.name == "Player":
		area.activar_estrella()
		queue_free()

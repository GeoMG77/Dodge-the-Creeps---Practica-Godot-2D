extends CanvasLayer

# Notifica al nodo Main que se presionó el botón de inicio
signal start_game


# Muestra un mensaje temporal en pantalla (ej. "Get Ready")
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


# Muestra el mensaje de Game Over y rehabilita el botón de Start tras una pausa
func show_game_over():
	show_message("Game Over")
	# Espera hasta que el MessageTimer termine de contar
	await $MessageTimer.timeout

	$Message.text = "Dodge the Creeps!"
	$Message.show()
	
	# Crea un temporizador de un solo uso y espera 1 segundo
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()


# Actualiza el texto de la puntuación en la interfaz
func update_score(score):
	$ScoreLabel.text = str(score)


# Se activa al presionar el botón Start
func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()


# Se activa cuando el MessageTimer llega a cero
func _on_message_timer_timeout():
	$Message.hide()

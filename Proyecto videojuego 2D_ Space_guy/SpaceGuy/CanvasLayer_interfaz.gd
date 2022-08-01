extends CanvasLayer

signal iniciar_juego

func mostrar_mensaje(texto):
	$Mensaje_Label.text = texto
	$Mensaje_Label.show()
	$Mensaje_Timer.start()

func game_over():
	mostrar_mensaje("Game Over")
	#yield($Mensaje_Timer, "timeot")
	$Button_play.show()
	$Mensaje_Label.text = "Space Guy"
	$Mensaje_Label.show()
	

func update_score(puntos):
	$Score_Label.text = str(puntos)


func _on_Mensaje_Timer_timeout():
	$Mensaje_Label.hide()


func _on_Button_play_pressed():
	$Button_play.hide()
	emit_signal("iniciar_juego")

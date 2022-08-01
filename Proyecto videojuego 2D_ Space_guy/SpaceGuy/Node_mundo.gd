extends Node

export (PackedScene) var roca #Exporta escenas al código que se almacenana en una variable.

var Score

func _ready():
	randomize() #Patrones aleatorios. #

func nuevo_juego():
	Score = 0
	$player.inicio($Position2D_inicio.position) #POsición de inico del player. #
	$inicio_timer.start() #Inicio del tiempo de inicio del player. #
	$CanvasLayer_interfaz.mostrar_mensaje("Listo!")
	$CanvasLayer_interfaz.update_score(Score)
	$Audio_MusicaFondo.play()
	
func Game_over():
	$score_timer.stop() #Se parará el temporizador del timer en el score. #
	$roca_timer.stop() #Se dejan de generar rocas_sprites. #
	$CanvasLayer_interfaz.game_over()
	$Audio_MusicaFondo.stop()
	$Audio_Game_Over.play()  #Al momento de perder, sonara el audio.
	
		
func _on_inicio_timer_timeout():
	$roca_timer.start() #Inicio del temporizador para las rocas. #
	$score_timer.start() #Inicio del temporizador del score, #


func _on_score_timer_timeout():
	Score += 1
	$CanvasLayer_interfaz.update_score(Score)
	
func _on_roca_timer_timeout():
	#Selecciona un lugar aleatorio en el camino, para las rocas. #
	$Path2D_margen/PathFollow2D_rocaP.set_offset(randi()) #Llamada de un nodo hijo
	
	var R = roca.instance() #Genera instancia. #
	add_child(R) #variable local R, ahora es un nodo hijo de /roca_timer. #
	
	#Selecciona una dirección. #
	var d = $Path2D_margen/PathFollow2D_rocaP.rotation + PI /2
	
	R.position = $Path2D_margen/PathFollow2D_rocaP.position
	
	d += rand_range(-PI /4, PI /4)
	R.rotation = d
	R.set_linear_velocity(Vector2(rand_range(R.velocidad_min, R.velocidad_max), 0).rotated(d))

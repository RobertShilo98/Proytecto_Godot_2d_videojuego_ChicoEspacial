extends Area2D

export (int) var velocidad
var movimiento = Vector2()
var limite
signal golpe
var pos

func _ready():
	
	hide() # ocultar el personaje (Sprite). #
	limite = get_viewport_rect().size

# warning-ignore:unused_argument
func _process(delta):
	
	movimiento = Vector2() # Búcle para reiniciar el valor de los movimientos.#
	
	if Input.is_action_pressed("ui_right"):
		movimiento.x +=1
		
	if Input.is_action_pressed("ui_left"):
		movimiento.x -=1
	
	if Input.is_action_pressed("ui_down"):
		movimiento.y +=1
		
	if Input.is_action_pressed("ui_up"):
		movimiento.y -=1

	if movimiento.length() > 0: # Verificar que se está moviendo.#
		movimiento = movimiento.normalized() *velocidad # Normalizar la velocidad.#

	position += movimiento * delta # Actualizar los movientos.#
	position.x = clamp(position.x, 0, limite.x)
	position.y = clamp(position.y, 0, limite.y)

	if movimiento.x != 0:
		$Astronauta_player.animation = "Astronauta_right"
		$Astronauta_player.flip_h = movimiento.x < 0
		$Astronauta_player.flip_v = false
	elif movimiento.y != 0:
		$Astronauta_player.animation = "Astronauta_Espalda"
		$Astronauta_player.flip_v = movimiento.y > 0
	else:
		$Astronauta_player.animation = "Astronauta_frente"


# Función que se activa sólo cuando hay una colisión de objetos. #
func _on_player_body_entered(body):
	hide() 
	emit_signal("golpe") # Emite la señal para desactivar la colisión.#
	$CollisionShape2D.disabled = true # Desactivar la colisión del personaje. #
	
func inicio(pos): # Se activa cuando el juego inicia de nuevo. #
	position = pos # mostrar la posición del personaje. #
	show() # mostrar el personaje (Sprite). #
	$CollisionShape2D.disabled = false	# Activar la colisión del personaje. #


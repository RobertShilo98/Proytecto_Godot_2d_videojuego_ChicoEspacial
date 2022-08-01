extends RigidBody2D

export (int) var velocidad_min
export (int) var velocidad_max

var tipo_roca = ["Asteroide", "Meteoro_grande"] #Array o listado.

func _ready():
	$AnimatedSprite.animation = tipo_roca[randi() % tipo_roca.size()] #Selección random del sprite.
	
	if $AnimatedSprite.animation == "Meteoro_grande":	
		$CollisionShape2D.scale.x = 1.5 #Cambio de escala en la colisión del nodo en el eje de x. #
		$CollisionShape2D.scale.y = 1.5 #Cambio de escala en la colisión del nodo en el eje de y. #


func _on_VisibilityNotifier2D_screen_exited(): #Función: Al salir de la pantalla del notificador de visibilidad. #
	queue_free() #Método - Coleta libre: Elimina el sprite de la roca. #


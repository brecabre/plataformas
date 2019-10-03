extends KinematicBody2D

export (int) var run_speed = 100
export (int) var jump_speed = -520
export (int) var gravity = 1200

var velocity = Vector2()
var jumping = false
var right = false
var left = true
var jump = false
var abajo = false
func _physics_process(delta):
#	print(get_tree().get_root().get_node("pantalla1/jugador").name)
	velocity.x = 0
	
	if right:
		velocity.x += run_speed
		$Sprite.set_flip_h(false) 
	if left:
		velocity.x -= run_speed
		$Sprite.set_flip_h(true) 
	if abajo:
		activar_desactivar_colision()

	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
#	velocity = move_and_slide_with_snap(velocity, Vector2(0, -1), Vector2(0, 32))
#func perseguir():
#	var nodojugador = get_tree().get_root().get_node("pantalla1/jugador")
#	var posicionjugador = nodojugador
#	pass
	moverse()
func moverse():
	var posicionenemigo = get_position()  
#	print(posicionenemigo.x)
	if posicionenemigo.x <= 60:
		left=false
		right=true
	elif posicionenemigo.x >= 400:
		right=false
		left=true
	
func activar_desactivar_colision():
	set_collision_layer_bit(0,false)
	set_collision_mask_bit(0,false)
	$Tiempo_activar_collision.start()

func _on_Tiempo_activar_collision_timeout():
	set_collision_layer_bit(0,true)
	set_collision_mask_bit(0,true)

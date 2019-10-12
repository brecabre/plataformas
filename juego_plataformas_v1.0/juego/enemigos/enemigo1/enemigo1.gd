extends KinematicBody2D

export (int) var run_speed = 10

export (int) var gravity = 1200

var velocity = Vector2()

var right = false
var left = true
#var jump = false
#var abajo = false

func _physics_process(delta):
#	print(get_tree().get_root().get_node("pantalla1/jugador").name)
	
	
	if right:
		velocity.x += run_speed
		$Sprite.set_flip_h(false) 
	if left:
		velocity.x -= run_speed
		$Sprite.set_flip_h(true) 
#	if abajo:
#		activar_desactivar_colision()

	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
#	
	moverse()
func moverse():
	var posicionenemigo = get_position()  
#	print(posicionenemigo.x)
	if posicionenemigo.x <= 60:
		left=false
		right=true
	elif posicionenemigo.x >= 200:
		right=false
		left=true
	
#func activar_desactivar_colision():
#	set_collision_layer_bit(0,false)
#	set_collision_mask_bit(0,false)
#	$Tiempo_activar_collision.start()
#
#func _on_Tiempo_activar_collision_timeout():
#	set_collision_layer_bit(0,true)
#	set_collision_mask_bit(0,true)



func _on_AreaDanoEnemigo1_area_entered(area):
	var enemigos = get_tree().get_nodes_in_group("enemigo")
	var nodoTimer = get_tree().get_root().get_node("Principal/Timer_entre_pantallas")
#	print (enemigos.size())
	if area.is_in_group("proyectil"):
		queue_free()
		if enemigos.size() <= 1:
#			print("pasar de pantalla")
			nodoTimer.start()
			
	
			
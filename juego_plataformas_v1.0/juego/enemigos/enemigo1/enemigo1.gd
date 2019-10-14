extends KinematicBody2D

export (int) var run_speed = 5

export (int) var gravity = 1200

var velocity = Vector2()
var aturdido = false
var right = false
var left = true
#var jumping = false


	
func _physics_process(delta):
	var posicionenemigo = get_position()
	if right:
		velocity.x += run_speed
		$Sprite.set_flip_h(false) 
	if left:
		velocity.x -= run_speed
		$Sprite.set_flip_h(true) 


	velocity.y += gravity * delta
	
	moverse(posicionenemigo)
#	print (jumping)
	
	# para que no se resbale por las cuestas, no se p q funciona
#	if is_on_floor() and velocity.x == 0 and jumping == false:
#		velocity.y = 0	
#	else:	
	velocity.y += gravity * delta
#	if jumping and is_on_floor():
#		jumping = false
#	print(is_on_wall())
#	velocity = move_and_slide(velocity, Vector2(0, -1))
#	# snap 32 pixels down
	velocity = move_and_slide_with_snap(velocity, Vector2(0, -1), Vector2(0, 46)) 
	
func moverse(arg):
	  
#	print(posicionenemigo.x)
	if arg.x <= 60:
		left=false
		right=true
	elif arg.x >= 200:
		right=false
		left=true



func _on_AreaDanoEnemigo1_area_entered(area):
	var enemigos = get_tree().get_nodes_in_group("enemigo")
	var nodoPrincipal = get_tree().get_root().get_node("Principal")
	var nodoTimer = get_tree().get_root().get_node("Principal/Timer_entre_pantallas")
#	print (enemigos.size())
	if area.is_in_group("proyectil"):
		queue_free()
		if enemigos.size() <= 1:
			if nodoPrincipal.numero_pantallas == nodoPrincipal.pantalla:
				nodoPrincipal.get_node("Control/Labelwin").show()
				print("win")
			else:
				
				nodoTimer.start()
	if area.is_in_group("aspiradora"):
		print("ssiiiiii    aspiradoraaaaaaa")
		aturdido = true
		

func _on_AreaDanoEnemigo1_area_exited(area):
	if area.is_in_group("aspiradora"):
		print("noooo aspiradoraaaaaaa")
		aturdido = false

extends KinematicBody2D

var vidas_personaje = 3
export (int) var run_speed = 100
export (int) var jump_speed = -520
export (int) var gravity = 1200
#var direccion
var velocity = Vector2()
var jumping = false

func get_input():
	velocity.x = 0
	
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_select')
	var abajo = Input.is_action_pressed('ui_down')
	
	if jump and is_on_floor() and not abajo:
        jumping = true
        velocity.y = jump_speed
	if right:
		velocity.x += run_speed
		$Sprite.set_flip_h(false) 
		
	if left:
		velocity.x -= run_speed
		$Sprite.set_flip_h(true) 
		
	if abajo and jump:
		activar_desactivar_colision()
func _physics_process(delta):
	
	get_input()
#	print (jumping)
	# para que no se resbale por las cuestas, no se p q funciona
	if is_on_floor() and velocity.x == 0 and jumping == false:
		velocity.y = 0	
	else:	
		velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
#	print(is_on_wall())
	velocity = move_and_slide(velocity, Vector2(0, -1))
#	velocity = move_and_slide_with_snap(velocity, Vector2(0, -1), Vector2(0, 32))

func activar_desactivar_colision():
	set_collision_mask_bit(0,false)
	$Tiempo_activar_collision.start()

func _on_Tiempo_activar_collision_timeout():
	set_collision_mask_bit(0,true)

func _on_AreaDano_area_entered(area):
	if area.is_in_group("enemigo"):
		if vidas_personaje <=1:
			print("muere")
		else:
			vidas_personaje -= 1
			print("no muere",vidas_personaje)
		
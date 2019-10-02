extends KinematicBody2D

export (int) var run_speed = 30
export (int) var jump_speed = -250
export (int) var gravity = 420

var velocity = Vector2()
var jumping = false
func _ready():
	
	pass
	
func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_select')
#	var arriba = Input.is_action_just_pressed('ui_up')
	var abajo = Input.is_action_pressed('ui_down')
	if jump and is_on_floor() and not abajo:
        jumping = true
        velocity.y = jump_speed
	if right:
        velocity.x += run_speed
	if left:
        velocity.x -= run_speed
#	if abajo and jump:
#		activar_desactivar_colision()
#	if is_on_floor() and not (jump or abajo or right or left) :
#		velocity=Vector2(0,0)
#
#		print("sssiiiiiii")
#	if	not is_on_floor():
#		print("nonononnnnnnnnno")
func _physics_process(delta):
	get_input()
	
	
	velocity.y += gravity * delta
	if jumping and is_on_floor():
        jumping = false
		
	velocity = move_and_slide(velocity, Vector2(0, -1))
#	velocity = move_and_slide_with_snap(velocity, Vector2(0, -1), Vector2(0, 32))
func activar_desactivar_colision():
	set_collision_layer_bit(0,false)
	set_collision_mask_bit(0,false)
	$Tiempo_activar_collision.start()

func _on_Tiempo_activar_collision_timeout():
	set_collision_layer_bit(0,true)
	set_collision_mask_bit(0,true)
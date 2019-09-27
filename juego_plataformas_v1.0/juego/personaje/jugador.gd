extends KinematicBody2D

export (int) var run_speed = 200
export (int) var jump_speed = -750
export (int) var gravity = 1200

var velocity = Vector2()
var jumping = false
func _ready():
	pass
	
func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_select')
	var arriba = Input.is_action_just_pressed('ui_up')
	var abajo = Input.is_action_pressed('ui_down')
	if jump and is_on_floor() and not abajo:
        jumping = true
        velocity.y = jump_speed
	if right:
        velocity.x += run_speed
	if left:
        velocity.x -= run_speed
	if abajo and jump:
		desactivar_y_activar_collision()

func _physics_process(delta):
    get_input()
    velocity.y += gravity * delta
    if jumping and is_on_floor():
        jumping = false
    velocity = move_and_slide(velocity, Vector2(0, -1))

func desactivar_y_activar_collision():
	$CollisionJugadors.et_disabled(true) 
	$Tiempo_activar_collision.start()
func _on_Tiempo_activar_collision_timeout():
	$CollisionJugadors.et_disabled(false)

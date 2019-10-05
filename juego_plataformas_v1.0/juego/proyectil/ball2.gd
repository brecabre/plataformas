extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
var velocity = Vector2(200,0)
var cambiar_direccion = false
var gravity = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity.y += gravity * delta
	
	
	if is_on_wall():
		velocity.x *= -1
		
	# snap 32 pixels down
	move_and_slide_with_snap(velocity, Vector2(0, 1), Vector2(0, 32))
#	move_and_slide(velocity,Vector2(0,-1))	
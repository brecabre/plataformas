extends KinematicBody2D
onready var nodo_jugador_sprite = get_tree().get_root().get_node("Principal/jugador/Sprite")
const UP = Vector2(0, -1)
const GRAVITY = 200
const SPEED = 200
var motion = Vector2()
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var direction  = left
func _ready():
	if nodo_jugador_sprite.is_flipped_h() :
		direction = left
	else:
		direction = right
func _physics_process(delta):
	
	motion.y += GRAVITY*delta
	motion.x = direction.x * SPEED
	motion = move_and_slide_with_snap(motion, UP, Vector2(0, 32)) 
	if is_on_wall():
		if direction == left:
			direction = right
		elif direction == right:
        	direction = left

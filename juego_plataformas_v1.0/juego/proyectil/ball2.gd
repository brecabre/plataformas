extends KinematicBody2D
onready var nodo_jugador_sprite = get_tree().get_root().get_node("Principal/jugador/Sprite")
onready var nodo_jugaspiradora = get_tree().get_root().get_node("Principal/jugador/aspiradora")
const UP = Vector2(0, -1)
const GRAVITY = 200
const SPEED = 200
var motion = Vector2()
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var direction  = left
var tamano
var num_choques = 0


#
func _ready():
	
	if nodo_jugador_sprite.is_flipped_h() :
		direction = left
	else:
		direction = right
func _physics_process(delta):
	var max_choques = nodo_jugaspiradora.lista_aspi.size()
	motion.y += GRAVITY*delta
	motion.x = direction.x * SPEED
	motion = move_and_slide_with_snap(motion, UP, Vector2(0, 32)) 
	if is_on_wall():
		num_choques += 1
		if num_choques >= max_choques:
			queue_free()
		else:
			if direction == left:
				direction = right
			elif direction == right:
        		direction = left
#		
func dimensiones(tamano):
	var shape = CircleShape2D.new()
	shape.set_radius(tamano*5)
	$CollisionShape2D.set_shape(shape) 


	




	
		
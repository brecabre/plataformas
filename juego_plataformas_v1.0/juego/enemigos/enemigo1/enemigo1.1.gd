extends KinematicBody2D

const UP = Vector2(0, -1)
const gravity = 300
const SPEED = 200
var velocity = Vector2()
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var parado = Vector2(0,0)
var aturdido = false
var antiguadireccion
var direction = left
export var snap := true

export var slope_slide_threshold := 50.0

func _physics_process(delta):
#	print(randi()%2+1)
	velocity.y += gravity * delta
	velocity.x = direction.x * SPEED
	var snap_vector = Vector2(0,32) if snap else Vector2()
	velocity = move_and_slide_with_snap(velocity,snap_vector, Vector2.UP, slope_slide_threshold)
	var nueva = null
	if aturdido:
		estaaturdido()
	else:
		moverse() 

func moverse():
	
	if is_on_wall() and not aturdido:
		if direction == left:
			direction = right
			$Sprite.set_flip_h(true)
		elif direction == right:
			direction = left
			$Sprite.set_flip_h(false)
	if direction == parado :
		var random = randi()%2+1
		if random == 1:
			direction = left
		else:
			direction = right
func estaaturdido():
#	antiguadireccion = direction
	direction = parado
	
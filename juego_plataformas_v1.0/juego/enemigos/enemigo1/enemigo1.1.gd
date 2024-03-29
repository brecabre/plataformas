extends KinematicBody2D
onready var animation_player : AnimationPlayer = $AnimationPlayer
const UP = Vector2(0, -1)
const gravity = 300
const SPEED = 100
var velocity = Vector2()
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var parado = Vector2(0,0)
var aspirado = false

var direction = left
export var snap := true

export var slope_slide_threshold := 50.0

func _physics_process(delta):

	velocity.y += gravity * delta
	velocity.x = direction.x * SPEED
	var snap_vector = Vector2(0,32) if snap else Vector2()
	velocity = move_and_slide_with_snap(velocity,snap_vector, Vector2.UP, slope_slide_threshold)

	update_animation(velocity)
	
	if aspirado:
		aspirando()
		
	else:
		moverse() 
	

func update_animation(velocity: Vector2) -> void:
#	var animation 
	var animation := "idle"
	if abs(velocity.x) > 10.0:
		$Sprite.flip_h = velocity.x > 0
		
		if aspirado:
			animation = "animaspirado"
#			
		else:
			animation = "andar"

#	if not is_on_floor():
#		animation = "jump" if velocity.y < 0 else "fall"

#	if animation_player.current_animation != animation:
		animation_player.play(animation)
func moverse():
	
	if is_on_wall() and not aspirado:
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
	
func aspirando():
#	var nodo_timeaspiradora = nodojugador.get_node("Timeraspirar")
	var nodojugador = get_owner().get_parent().get_node("jugador")
	var direccionAspirado = Vector2()
	var posicion_jugador = nodojugador.get_global_position()
	var posicion_enemigo = get_global_position()
	direccionAspirado = (posicion_jugador - posicion_enemigo).normalized()
#	print (nodojugador)
#	if posicion_enemigo == posicion_jugador:
		
	direction = direccionAspirado 
#	direction = parado



func _funaspirado():

	queue_free()



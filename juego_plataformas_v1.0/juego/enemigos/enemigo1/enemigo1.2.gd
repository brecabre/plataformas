extends KinematicBody2D
onready var animation_player : AnimationPlayer = $AnimationPlayer
const UP = Vector2(0, -1)
const gravity = 300
const SPEED = 75
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
		
	elif aspirado == false:
		moverse() 
		$Timeraspirar.stop()

func update_animation(velocity: Vector2) -> void:

	var animation := "idle"
	if abs(velocity.x) > 10.0:
		$Sprite.flip_h = velocity.x > 0
		
		if aspirado:
			animation = "animaspirado"
			
			
		else:
			animation = "andar"

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
	var nodojugador = get_owner().get_parent().get_node("jugador")
	
	
	var posicion_aspiradora = nodojugador.get_node("aspiradora/Position2D").get_global_position()
	var direccionaspirar = (posicion_aspiradora - get_global_position()).normalized()
#	
	direction = direccionaspirar


func _on_Timeraspirar_timeout():
	queue_free()
	pass # Replace with function body.

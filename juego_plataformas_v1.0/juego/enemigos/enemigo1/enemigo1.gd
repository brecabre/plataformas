extends KinematicBody2D
onready var animation_player : AnimationPlayer = $AnimationPlayer
#var UP = Vector2(0, -1)
var gravity = 300
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
#		

func update_animation(velocity: Vector2) -> void:

	var animation := "idle"
	if abs(velocity.x) > 10.0:
		$Sprite.flip_h = velocity.x > 0

		if aspirado:
			animation = "animaspirado"
			#compruebo primero si se a activado la señal para evitar errores
			if animation_player.is_connected( "animation_finished", self, "aspirados")==false:
				# conecto el final de la animacion con la func aspirados
				animation_player.connect("animation_finished",self,"aspirados")
#			
		else:
			animation = "andar"

		animation_player.play(animation)
		
func moverse():
	snap = true
	gravity = 300
	$CollisionShape2D.set_disabled(false)
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
	$CollisionShape2D.set_disabled(true)
	snap = false
	gravity = 0
#	
	if posicion_aspiradora != get_global_position():

		direction.x = direccionaspirar.x
		velocity.y = direccionaspirar.y*SPEED
	

func _on_AreaDanoEnemigo1_area_entered(area):
	if area.is_in_group("proyectil"):
		queue_free()


func aspirados(animaspirado):

	var nodojugador = get_owner().get_parent().get_node("jugador")
	var aspiradora = nodojugador.get_node("aspiradora")
	aspiradora.lista_aspi.append($Sprite.texture.get_path())

	queue_free()
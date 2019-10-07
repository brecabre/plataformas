extends KinematicBody2D

var _gravedad = 0
var cambio = false
var _movimiento = Vector2()

#func disparo(direccion_fuerza , gravedad):
#	_movimiento = direccion_fuerza
#	_gravedad = gravedad
#	set_physics_process(true)

var velocity = Vector2(10,0)
var botes = 0
export var maxbotes = 6
var gravedad = 100
func _physics_process(delta):
	velocity += Vector2(0,gravedad)*delta
	if is_on_wall():
		print("muro")
		
	if is_on_floor():
		print("suelo")
		
	velocity = move_and_slide( velocity, Vector2(0,-1))
#
#	if botes >= maxbotes:
#		queue_free()
#	else:
#		if collision_info:
#			velocity = velocity.bounce(collision_info.normal)
#			botes+=1
#			print("boing")
		
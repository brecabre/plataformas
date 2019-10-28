extends KinematicBody2D
onready var nodo_jugador_sprite = get_tree().get_root().get_node("Principal/jugador/Sprite")
#onready var nodo_jugaspiradora = get_tree().get_root().get_node("Principal/jugador/aspiradora")
const UP = Vector2(0, -1)
const GRAVITY = 200
const SPEED = 300
var motion = Vector2()
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var direction  = left
var num_choques = 0
var max_choques = 0
#var rotar_base = false
var accum = 0
var velocidad_giro = 5
func _ready():
	
	if nodo_jugador_sprite.is_flipped_h() :
		direction = left
		velocidad_giro = - 10
	else:
		direction = right
		velocidad_giro = 10

func _physics_process(delta):
	accum += delta * velocidad_giro
	
	$base_bola.set_rotation(accum)
	motion.y += GRAVITY*delta
	motion.x = direction.x * SPEED
	motion = move_and_slide_with_snap(motion, UP, Vector2(0, 32)) 
	if is_on_wall():
		num_choques += 1
		print(num_choques)
		if num_choques >= max_choques:
			queue_free()
		else:
			if direction == left:
				direction = right
				velocidad_giro = 10
			elif direction == right:
				direction = left
				velocidad_giro = -10

func dimensiones(tamano):
	var shape = CircleShape2D.new()
	shape.set_radius(tamano*5)
	max_choques = tamano  
	$CollisionShape2D.set_shape(shape) 
	$Area2D/CollisionShape2D.set_shape(shape) 

func anadir_sprites(sprite):
	
	if sprite.size() <= 1:
		$Sprite.texture = load(sprite[0])
		
		pass
	
	else:
		
		var contar = 0
	
		for i in sprite:
			contar += 1
			var nueva_posicion2d = Position2D.new()
			nueva_posicion2d.set_rotation(contar)
			$base_bola.add_child(nueva_posicion2d)
			var nueva_textura = Sprite.new()
			nueva_textura.scale = Vector2(2,2)
			nueva_textura.texture = load(i)
			
			nueva_textura.set_region(true)
			nueva_textura.set_region_rect( Rect2(Vector2 (996,36), Vector2 (40,40))) 
		
			nueva_textura.set_position(Vector2(contar*8,0))
		
			nueva_posicion2d.add_child(nueva_textura)



	
		
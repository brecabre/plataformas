extends Node2D

# Declare member variables here. Examples:
# var a = 2
var sprite=["res://juego/enemigos/enemigo2/enemigo_2_sprites.png",
"res://juego/enemigos/enemigo2/enemigo_2_sprites.png",
"res://juego/enemigos/enemigo2/enemigo_2_sprites.png",
"res://juego/enemigos/enemigo2/enemigo_2_sprites.png",
"res://juego/enemigos/enemigo2/enemigo_2_sprites.png",
"res://juego/enemigos/enemigo2/enemigo_2_sprites.png"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
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
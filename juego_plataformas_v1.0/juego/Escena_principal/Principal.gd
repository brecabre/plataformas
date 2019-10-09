extends Node2D

# Declare member variables here. Examples:
# var a = 2
#onready var escena = preload("res://juego/pantallas/pantalla1/pantalla1.tscn").instance()
#onready var progreso = 1
var pantalla = 1
onready var personaje = preload("res://juego/personaje/jugador.tscn").instance()
#onready var escena = load("res://juego/pantallas/pantalla" + str(pantalla) + "/pantalla" + str(pantalla) +".tscn").instance()
onready var escena = load("res://juego/pantallas/pantalla" + str(pantalla) + "/pantalla" + str(pantalla) +".tscn").instance()
# Called when the node enters the scene tree for the first time.
func _ready():
	cargar_escenario() 
	cargar_jugador()

func cargar_escenario():
	
	var node = escena
	add_child(node)

	
func cargar_jugador():
	var node = personaje
	var posicion = escena.get_node("punto_salida")
	node.set_global_position(posicion.get_global_position())
	add_child(node)
	
func cambiar_pantalla():
	
	# Remove the current level
	var level = get_tree().get_root().get_node("Principal/pantalla1")
	get_tree().get_root().get_node("Principal/pantalla1").remove_child(level)
	level.call_deferred("free")
	
	# Add the next level
#	var node = escena
#	add_child(node)
	
	var next_level_resource = load("res://juego/pantallas/pantalla2/pantalla2.tscn")
	var next_level = next_level_resource.instance()
	add_child(next_level)

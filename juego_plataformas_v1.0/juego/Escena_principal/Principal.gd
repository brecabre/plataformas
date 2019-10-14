extends Node2D

var numero_pantallas
var pantalla = 1
var personaje = load("res://juego/personaje/jugador.tscn")

var escena = load("res://juego/pantallas/pantalla1/pantalla1.tscn").instance()

func _ready():
	
	numero_pantallas = 2
	cargar_escenario() 
	cargar_jugador()

func _input(event):
	if event.is_action_pressed("pausa"):
		if get_tree().is_paused():
			get_tree().paused = false
			print("con pausa")
		else:
			get_tree().paused = true
			print(get_tree().is_paused())

func cargar_escenario():
	var node = escena
	add_child(node)

func personaje_salida(node):
	var posicion_salida = get_node("punto_salida")
	node.set_global_position(posicion_salida.get_global_position())

func cargar_jugador():
	var node = personaje.instance()
	personaje_salida(node)
	add_child(node)
	
func cambiar_pantalla():
	# quitar escena actual 
	
	var level = get_node("pantalla" + str(pantalla))
	level.queue_free()

	# Add the next level
	pantalla+=1
	var next_level_resource = load("res://juego/pantallas/pantalla" + str(pantalla) + "/pantalla" + str(pantalla) +".tscn")
	var next_level = next_level_resource.instance()
	call_deferred("add_child",next_level)
	personaje_salida($jugador)

# variable para evitar error de valor devuelto no utilizado por change_scene
var variable
func gameover():
	
	
	variable = get_tree().change_scene("res://juego/menus/menu_principal.tscn")
	print(get_tree().change_scene("res://juego/menus/menu_principal.tscn"))


func _on_Timer_entre_pantallas_timeout():
	
	$Control/LabelNextLevel/AnimationPlayer.play("next_level_anima")



func _on_AnimationPlayer_animation_finished(next_level_anima):
	next_level_anima = $Control/LabelNextLevel.hide()
	cambiar_pantalla()




func _on_AnimationPlayer2_animation_finished(anim_name):
	anim_name = gameover()

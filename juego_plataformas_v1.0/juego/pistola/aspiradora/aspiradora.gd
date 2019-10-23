extends Node2D
onready var bala_escena = preload("res://juego/proyectil/ball.tscn")
onready var nodojugador_sprite = get_parent().get_node("Sprite")
onready var area_aspi = $AreaAspira

#onready var AreaColision = $AreaAspira/CollisionPolygon2D
var lista_aspi = []

func _ready():
	$AreaAspira/CollisionPolygon2D.set_disabled(true) 
	$AreaAspira/CollisionPolygon2D.hide()  
	set_process(true)
	set_process_input(true)

func _input(event):
	if(Input.is_action_pressed("disparar")):
		$AreaAspira/CollisionPolygon2D.set_disabled(false) 
		$AreaAspira/CollisionPolygon2D.show() 
		if nodojugador_sprite.is_flipped_h():
			area_aspi.set_rotation_degrees(180)
#			
		elif nodojugador_sprite.is_flipped_h() == false:
			area_aspi.set_rotation_degrees(0)
			
	
	if(event.is_action_released("disparar")):
		$AreaAspira/CollisionPolygon2D.set_disabled(true) 
		$AreaAspira/CollisionPolygon2D.hide() 
		if lista_aspi.empty():
			pass
		else:
			
			soltar_bola()
			lista_aspi.clear()

func _on_AreaAspira_area_entered(area):
	if area.is_in_group("enemigo"):
		area.get_parent().aspirado = true
		area.get_parent().get_node("Timeraspirar").start()


func _on_AreaAspira_area_exited(area):
	if area.is_in_group("enemigo"):
		
		area.get_parent().aspirado = false
		area.get_parent().direction = area.get_parent().parado
		area.get_parent().get_node("Timeraspirar").stop()

func soltar_bola():
	var tamano = lista_aspi.size()
	var bala_spawn =$Position2D.get_global_position()
	var bala = bala_escena.instance()
	bala.set_global_position(bala_spawn)
	bala.dimensiones(tamano)
	get_owner().get_parent().add_child(bala)
extends Node2D

onready var nodojugador_sprite = get_parent().get_node("Sprite")
onready var area_aspi = $AreaAspira
#onready var AreaColision = $AreaAspira/CollisionPolygon2D

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
#		

func _on_AreaAspira_area_entered(area):
	if area.is_in_group("enemigo"):
		area.get_parent().aspirado = true
#		area.get_parent().get_node("Timeraspirar").start()
		area.get_parent().get_node("Timeraspirar").start()

func _on_AreaAspira_area_exited(area):
	if area.is_in_group("enemigo"):
		
		area.get_parent().aspirado = false
		area.get_parent().direction = area.get_parent().parado
		area.get_parent().get_node("Timeraspirar").stop()

extends Node2D


#onready var AreaColision = $AreaAspira/CollisionPolygon2D

func _ready():
#	AreaColision.set_disabled(true) 
	set_process(true)
	set_process_input(true)

#func _input(event):
#	if(Input.is_action_pressed("disparar")):
##		AreaColision.set_disabled(false) 
#		print("absorver")
#
#	if(event.is_action_released("disparar")):
##		AreaColision.set_disabled(true) 
#		print("disparar")

func _on_AreaAspira_area_entered(area):
	if area.is_in_group("enemigo"):
		area.get_parent().aturdido = true
		
		


func _on_AreaAspira_area_exited(area):
	if area.is_in_group("enemigo"):
		var _stop = Vector2(0,0)
		area.get_parent().aturdido = false
	

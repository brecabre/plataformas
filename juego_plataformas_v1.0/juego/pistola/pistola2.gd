extends Node2D

export (PackedScene) var bala_escena
export (NodePath) var bala_spawn_path
onready var bala_spawn = get_node(bala_spawn_path)
var disparando = false
export (float) var bala_retardo = 0.5
var esperar = 0


func _ready():
	set_process(true)
	set_process_input(true)
func _input(event):
	if(Input.is_action_pressed("disparar")):
		disparando = true
	if(event.is_action_released("disparar")):
		disparando = false

func _process(delta):
	if(disparando && esperar > bala_retardo):
		un_fuego()
		esperar = 0
	elif(esperar <= bala_retardo):
		esperar+= delta


func un_fuego():
	disparo()
	disparando = false

func disparo():
	var bala = bala_escena.instance()
	bala.set_global_position(bala_spawn.get_global_position())
#	bala.disparo(direccion_fuerza)
	get_owner().get_parent().add_child(bala)
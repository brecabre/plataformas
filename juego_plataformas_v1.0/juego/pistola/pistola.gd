extends Node2D

export (float) var angulo_bala = 350 setget set_angulo_bala
export (int) var velocidad_bala = 8
export (int) var bala_gravedad = 5
export (float) var bala_retardo = 0.5
var esperar = 0
export (PackedScene) var bala_escena
export (NodePath) var bala_spawn_path
onready var bala_spawn = get_node(bala_spawn_path)
var direccion_fuerza = Vector2()

var disparando = false

func set_angulo_bala(valor):
	angulo_bala = clamp(valor,0,360)

func actualizar_direccion_fuerza():
	direccion_fuerza = Vector2(cos(angulo_bala*(PI/180)),sin(angulo_bala*(PI/180))) * velocidad_bala

func _ready():
	actualizar_direccion_fuerza()
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
	bala.set_position(bala_spawn.get_position())
	bala.disparo(direccion_fuerza,bala_gravedad)
	get_parent().add_child(bala)

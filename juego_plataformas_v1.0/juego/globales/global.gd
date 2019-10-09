extends Node

var pantalla = 1

func siguiente_pantalla():
    pantalla += 1
    pantalla = get_tree().change_scene("res://juego/pantallas/pantalla" +str(pantalla)+"/pantalla"+str(pantalla)+".tscn")

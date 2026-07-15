class_name Ability
extends Node2D

@export var display_name := "Base Ability"

func activate():
	print("Ability activated: ", display_name)
	pass
	
func _process(delta: float) -> void:
	pass

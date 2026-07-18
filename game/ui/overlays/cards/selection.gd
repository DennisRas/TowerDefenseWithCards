extends Control

const CARD = preload("res://game/ui/overlays/cards/card.tscn")

@onready var container = $Panel/CenterContainer/CardContainer

func show_choices(choices: Array):
	for child in container.get_children():
		child.queue_free()

	for ability_scene in choices:
		var card = CARD.instantiate()
		container.add_child(card)
		card.setup(ability_scene)

	show()

func hide_choices():
	hide()
	for child in container.get_children():
		child.queue_free()

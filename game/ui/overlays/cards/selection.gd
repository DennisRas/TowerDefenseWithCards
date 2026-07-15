extends CanvasLayer

signal ability_selected(scene)

const CARD = preload("res://scenes/card.tscn")

@onready var container = $Panel/CardContainer

func show_choices(choices: Array):
	for child in container.get_children():
		child.queue_free()

	for ability_scene in choices:
		var card = CARD.instantiate()
		container.add_child(card)
		card.setup(ability_scene)
		card.selected.connect(
			_on_card_selected
		)
	show()

func _on_card_selected(scene):
	ability_selected.emit(scene)

class_name AbilityCard
extends Button

var ability_scene: PackedScene

signal selected(scene)

func setup(scene: PackedScene):
	ability_scene = scene
	var ability = ability_scene.instantiate()
	text = ability.display_name
	ability.queue_free()

func _pressed():
	selected.emit(ability_scene)

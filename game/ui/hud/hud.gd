extends Control

@onready var label = $TowerHPLabel

func update_tower_health_text(current, max_hp):
	label.text = "Tower HP: %d/%d" % [current, max_hp]

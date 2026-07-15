extends CanvasLayer

@onready var label = $TowerHPLabel
@onready var tower = $"../Arena/Tower"

func _ready():
	tower.health_changed.connect(update_hp_label)
	update_hp_label(tower.current_hp, tower.max_hp)
	
func update_hp_label(current, max):
	label.text = "Tower HP: %d/%d" % [current, max]

extends CanvasLayer

@onready var label = $TowerHPLabel
@onready var tower = $"../Arena/Tower"
@onready var overlay = $GameOverPanel

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	Game.state_changed.connect(state_changed)
	tower.health_changed.connect(update_hp_label)
	update_hp_label(tower.current_hp, tower.max_hp)
	
func update_hp_label(current, max):
	label.text = "Tower HP: %d/%d" % [current, max]

func state_changed(state):
	if state == Game.State.GAME_OVER:
		overlay.visible = true
	else:
		overlay.visible = false

extends CanvasLayer

@onready var label = $TowerHPLabel
@onready var overlay = $GameOverPanel

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	#Game.state_changed.connect(state_changed)
	
func update_tower_health_text(current, max):
	label.text = "Tower HP: %d/%d" % [current, max]

#func state_changed(state):
	#if state == Game.State.GAME_OVER:
		#overlay.visible = true
	#else:
		#overlay.visible = false

func _input(event):
	if Game.state != Game.State.GAME_OVER:
		return
	
	if event.is_action_pressed("ui_accept"):
		Game.restart()

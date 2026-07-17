extends Node

@onready var arena = $Arena
@onready var tower = $Arena/Tower
@onready var ui = $Ui
@onready var HUD = $Ui/Hud

enum State {
	PLAYING,
	GAME_OVER
}

var state = State.PLAYING

signal state_changed(state)

func _ready():
	print("=== GAME READY ===")
	
	arena = get_node("Arena")
	ui = get_node("Ui")

	print("arena:", arena)
	print("ui:", ui)

	ui.bind(self)

func start():
	print("Starting game...")
	reset()

func reset():
	print("Resetting game...")

func end():
	print("GAME END CALLED")
	if state == State.GAME_OVER:
		return
	
	get_tree().paused = true
	state = State.GAME_OVER
	state_changed.emit(state)
	print("Game ended")

func restart():
	print("Restarting game...")
	get_tree().reload_current_scene() 	# Let's not do this, but just reset game instead
	get_tree().paused = false
	state = State.PLAYING
	state_changed.emit(state)
	print("Game restarted")

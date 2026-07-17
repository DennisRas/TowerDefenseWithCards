extends Node

@onready var Arena = $Arena
@onready var tower = $Arena/Tower
@onready var ui = $Ui
@onready var HUD = $Ui/Hud

enum State {
	PLAYING,
	GAME_OVER
}

var state = State.PLAYING

signal state_changed(state)

func _ready() -> void:
	ui.bind(self)

func end():
	if state == State.GAME_OVER:
		return
	
	get_tree().paused = true
	state = State.GAME_OVER
	state_changed.emit(state)
	print("Game over!")

func restart():
	get_tree().reload_current_scene() 	# Let's not do this, but just reset game instead
	get_tree().paused = false
	state = State.PLAYING
	state_changed.emit(state)
	print("Game restarting")

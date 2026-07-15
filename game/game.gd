extends Node

enum State {
	PLAYING,
	GAME_OVER
}

var state = State.PLAYING

signal state_changed

func end():
	if state == State.GAME_OVER:
		return
	
	state = State.GAME_OVER
	get_tree().paused = true
	state_changed.emit(state)
	print("Game over!")

func restart():
	get_tree().reload_current_scene()
	Game.state = Game.State.PLAYING
	get_tree().paused = false
	print("Game restarting")

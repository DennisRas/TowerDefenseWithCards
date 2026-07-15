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

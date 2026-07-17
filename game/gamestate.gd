class_name GameState
extends Node

enum State {
	MENU,
	PLAYING,
	GAME_OVER
}

enum Event {
	STATE_CHANGED,
	TOWER_HEALTH_CHANGED,
	ENEMY_KILLED
}

var default_state = {
	"score": 0,
	"wave": 1,
	"kills": 0
}

var state = default_state.duplicate(true)

signal event(type, data)

func reset():
	state = default_state.duplicate(true)

func dispatch(type, data = {}):
	event.emit(type, data)

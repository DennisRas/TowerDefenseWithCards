class_name GameState
extends Node

enum State {
	IDLE,
	PLAYING,
	GAME_OVER
}

enum Event {
	STATE_CHANGED,
	TOWER_HEALTH_CHANGED,
	TOWER_DESTROYED,
	ENEMY_KILLED
}

var play_state: State = State.IDLE

var default_state = {
	"score": 0,
	"wave": 1,
	"kills": 0
}

var state = default_state.duplicate(true)

signal event(type, data)

func reset():
	state = default_state.duplicate(true)

func set_play_state(new_state: State):
	play_state = new_state
	dispatch(Event.STATE_CHANGED, {"state": play_state})

func dispatch(type, data = {}):
	event.emit(type, data)

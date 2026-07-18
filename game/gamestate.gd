class_name GameState
extends Node

enum State {
	IDLE,
	SELECTING,
	PLAYING,
	GAME_OVER
}

enum Event {
	STATE_CHANGED,
	TOWER_HEALTH_CHANGED,
	TOWER_DESTROYED,
	ENEMY_KILLED,
	ABILITY_SELECTED,
	ABILITIES_CHANGED,
	LEVEL_CHANGED,
	LEVEL_COMPLETED,
	RESTART_REQUESTED,
	ABANDON_RUN_REQUESTED,
	START_GAME_REQUESTED,
	EXIT_GAME_REQUESTED
}

var default_state = {
	"play_state": State.IDLE,
	"score": 0,
	"level": {
		"number": 1,
		"duration": 60.0,
		"elapsed": 0.0
	},
	"kills": 0,
	"xp": 0,
	"damage_dealt": 0.0
}

var state = default_state.duplicate(true)

signal event(type, data)

## Convenience alias — source of truth is state.play_state.
var play_state: State:
	get:
		return state.play_state

func reset():
	state = default_state.duplicate(true)

func set_play_state(new_state: State):
	state.play_state = new_state
	dispatch(Event.STATE_CHANGED, {"state": state.play_state})

func level_time_left() -> float:
	return maxf(0.0, state.level.duration - state.level.elapsed)

func start_level(level_number: int = 1) -> void:
	state.level.number = maxi(1, level_number)
	state.level.elapsed = 0.0
	dispatch(Event.LEVEL_CHANGED, {
		"level": state.level.number,
		"duration": state.level.duration,
		"time_left": level_time_left()
	})

func advance_level() -> void:
	start_level(state.level.number + 1)

func _process(delta: float) -> void:
	if state.play_state != State.PLAYING:
		return

	state.level.elapsed += delta

	if state.level.elapsed >= state.level.duration:
		dispatch(Event.LEVEL_COMPLETED, {"level": state.level.number})
		advance_level()

func dispatch(type, data = {}):
	event.emit(type, data)

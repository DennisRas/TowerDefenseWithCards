extends Control

func _on_start_game_pressed() -> void:
	Gamestate.dispatch(Gamestate.Event.START_GAME_REQUESTED)

func _on_exit_game_pressed() -> void:
	Gamestate.dispatch(Gamestate.Event.EXIT_GAME_REQUESTED)

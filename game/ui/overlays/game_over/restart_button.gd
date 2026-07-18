extends Button

func _on_pressed() -> void:
	Gamestate.dispatch(Gamestate.Event.RESTART_REQUESTED)

extends Control

var done := false

func finish():
	if done:
		return

	done = true
	Gamestate.dispatch(Gamestate.Event.INTRO_FINISHED)

func _on_intro_timer_timeout():
	finish()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		finish()

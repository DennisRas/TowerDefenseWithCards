extends Control

signal finished

var done := false

func finish():
	if done:
		return
	
	done = true
	finished.emit()
	
func _on_intro_timer_timeout():
	finish()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		finish()

extends Control

signal start_game_pressed

func _on_start_game_pressed() -> void:
	start_game_pressed.emit()

func _on_exit_game_pressed() -> void:
	get_tree().quit()

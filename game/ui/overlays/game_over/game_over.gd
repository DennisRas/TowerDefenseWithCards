extends Control

@onready var menu: Menu = $Panel/CenterContainer/VBoxContainer/Menu

func _ready() -> void:
	menu.apply_context(Menu.Context.GAME_OVER)

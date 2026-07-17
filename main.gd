extends Node

@onready var screen_container = $ScreenContainer
var current_screen

var intro_screen = preload("res://intro/intro.tscn")
var menu_screen = preload("res://menu/menu.tscn")
var game_screen = preload("res://game/game.tscn")

func _ready():
	print("Main ready")
	show_intro()

func change_screen(scene):
	if current_screen:
		current_screen.queue_free()

	current_screen = scene.instantiate()
	screen_container.add_child(current_screen)

func show_intro():
	print("Showing intro")
	change_screen(intro_screen)
	current_screen.finished.connect(show_menu)
	
func show_menu():
	print("Showing menu")
	change_screen(menu_screen)
	current_screen.start_game_pressed.connect(start_game)

func start_game():
	print("Showing game")
	change_screen(game_screen)
	print("Loaded scene:")
	current_screen.print_tree()

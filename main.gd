extends Node

@onready var intro = $Intro
@onready var menu = $Menu
@onready var game = $Game

var current_screen: Node

func _ready():
	intro.finished.connect(show_menu)
	menu.start_game_pressed.connect(start_game)

	for screen in [intro, menu, game]:
		_set_screen_active(screen, false)

	show_intro()

func _set_screen_active(screen: Node, active: bool):
	screen.visible = active
	screen.process_mode = (
		Node.PROCESS_MODE_INHERIT if active
		else Node.PROCESS_MODE_DISABLED
	)

func show_screen(screen: Node):
	if current_screen == screen:
		return

	if current_screen:
		_set_screen_active(current_screen, false)
		if current_screen == game:
			game.set_ui_active(false)

	current_screen = screen
	_set_screen_active(screen, true)

	if screen == game:
		game.set_ui_active(true)

func show_intro():
	intro.done = false
	show_screen(intro)

func show_menu():
	Gamestate.set_play_state(Gamestate.State.IDLE)
	show_screen(menu)

func start_game():
	show_screen(game)
	game.start()

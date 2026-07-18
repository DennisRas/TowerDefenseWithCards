extends Node

@onready var intro = $Intro
@onready var menu = $Menu
@onready var game = $Game

var current_screen: Node

func _ready():
	Gamestate.event.connect(_on_gamestate_event)

	for screen in [intro, menu, game]:
		set_screen_active(screen, false)

	show_intro()

func _on_gamestate_event(type, _data):
	match type:
		Gamestate.Event.INTRO_FINISHED:
			show_menu()
		Gamestate.Event.START_GAME_REQUESTED:
			start_game()
		Gamestate.Event.EXIT_GAME_REQUESTED:
			get_tree().quit()

func set_screen_active(screen: Node, active: bool):
	screen.visible = active
	screen.process_mode = (
		Node.PROCESS_MODE_INHERIT if active
		else Node.PROCESS_MODE_DISABLED
	)

func show_screen(screen: Node):
	if current_screen == screen:
		return

	if current_screen:
		set_screen_active(current_screen, false)
		if current_screen == game:
			game.set_ui_active(false)

	current_screen = screen
	set_screen_active(screen, true)

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

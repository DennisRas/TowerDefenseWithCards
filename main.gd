extends Node

@onready var main_menu: Control = $MainMenu
@onready var intro: Control = $MainMenu/Intro
@onready var menu: Menu = $MainMenu/Panel/Menu
@onready var game = $Game

var intro_done := false

func _ready() -> void:
	Gamestate.event.connect(_on_gamestate_event)
	menu.apply_context(Menu.Context.MAIN)

	set_active(game, false)
	game.set_ui_active(false)

	set_active(main_menu, true)
	intro_done = false
	intro.visible = true

func _on_gamestate_event(type, _data) -> void:
	match type:
		Gamestate.Event.START_GAME_REQUESTED:
			start_game()
		Gamestate.Event.ABANDON_RUN_REQUESTED:
			abandon_run()
		Gamestate.Event.EXIT_GAME_REQUESTED:
			get_tree().quit()

func _input(event: InputEvent) -> void:
	if intro_done or not intro.visible:
		return

	if event.is_action_pressed("ui_accept"):
		finish_intro()
		get_viewport().set_input_as_handled()

func set_active(node: Node, active: bool) -> void:
	node.visible = active
	node.process_mode = (
		Node.PROCESS_MODE_INHERIT if active
		else Node.PROCESS_MODE_DISABLED
	)

func finish_intro() -> void:
	if intro_done:
		return

	intro_done = true
	intro.visible = false

func show_main_menu() -> void:
	get_tree().paused = false
	Gamestate.set_play_state(Gamestate.State.IDLE)
	intro.visible = false
	set_active(game, false)
	game.set_ui_active(false)
	set_active(main_menu, true)

func start_game() -> void:
	finish_intro()
	set_active(main_menu, false)
	set_active(game, true)
	game.set_ui_active(true)
	game.start()

func abandon_run() -> void:
	game.reset()
	show_main_menu()

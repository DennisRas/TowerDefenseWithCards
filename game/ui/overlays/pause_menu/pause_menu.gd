extends Control

@onready var menu: Menu = $Panel/Menu

var open := false

func _ready() -> void:
	visible = false
	menu.apply_context(Menu.Context.PAUSE)
	Gamestate.event.connect(_on_gamestate_event)
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_gamestate_event(type, _data) -> void:
	match type:
		Gamestate.Event.RESTART_REQUESTED, \
		Gamestate.Event.ABANDON_RUN_REQUESTED, \
		Gamestate.Event.EXIT_GAME_REQUESTED, \
		Gamestate.Event.START_GAME_REQUESTED:
			close()

func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("ui_cancel"):
		return

	if not can_toggle():
		return

	if open:
		close()
	else:
		open_menu()

	get_viewport().set_input_as_handled()

func can_toggle() -> bool:
	match Gamestate.play_state:
		Gamestate.State.PLAYING, Gamestate.State.SELECTING:
			return true
		_:
			return false

func open_menu() -> void:
	open = true
	visible = true
	get_tree().paused = true

func close() -> void:
	if not open:
		return

	open = false
	visible = false

	if Gamestate.play_state == Gamestate.State.PLAYING:
		get_tree().paused = false

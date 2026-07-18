class_name Menu
extends VBoxContainer

enum Context {
	MAIN,
	PAUSE,
	GAME_OVER
}

@onready var start_game: Button = $StartGame
@onready var restart_run: Button = $RestartRun
@onready var settings: Button = $Settings
@onready var abandon_run: Button = $AbandonRun
@onready var back_to_main_menu: Button = $BackToMainMenu
@onready var exit_game: Button = $ExitGame

func _ready() -> void:
	start_game.pressed.connect(_on_start_game_pressed)
	restart_run.pressed.connect(_on_restart_run_pressed)
	abandon_run.pressed.connect(_on_abandon_run_pressed)
	back_to_main_menu.pressed.connect(_on_back_to_main_menu_pressed)
	exit_game.pressed.connect(_on_exit_game_pressed)
	settings.disabled = true

func apply_context(context: Context) -> void:
	start_game.visible = context == Context.MAIN
	restart_run.visible = context != Context.MAIN
	abandon_run.visible = context == Context.PAUSE
	back_to_main_menu.visible = context == Context.GAME_OVER

func _on_start_game_pressed() -> void:
	Gamestate.dispatch(Gamestate.Event.START_GAME_REQUESTED)

func _on_restart_run_pressed() -> void:
	Gamestate.dispatch(Gamestate.Event.RESTART_REQUESTED)

func _on_abandon_run_pressed() -> void:
	Gamestate.dispatch(Gamestate.Event.ABANDON_RUN_REQUESTED)

func _on_back_to_main_menu_pressed() -> void:
	Gamestate.dispatch(Gamestate.Event.ABANDON_RUN_REQUESTED)

func _on_exit_game_pressed() -> void:
	Gamestate.dispatch(Gamestate.Event.EXIT_GAME_REQUESTED)

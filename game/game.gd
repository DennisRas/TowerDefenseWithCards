extends Node2D

@onready var arena = $Arena
@onready var tower = $Arena/Tower
@onready var spawner = $Arena/Spawner
@onready var ui = $Ui

func _ready():
	add_to_group("game")
	Gamestate.event.connect(_on_gamestate_event)

func _on_gamestate_event(type, _data):
	if type == Gamestate.Event.TOWER_DESTROYED:
		end()

func set_ui_active(active: bool):
	# ALWAYS while the game screen is up so overlays work when the tree is paused.
	ui.process_mode = (
		Node.PROCESS_MODE_ALWAYS if active
		else Node.PROCESS_MODE_DISABLED
	)

func start():
	reset()
	get_tree().paused = false
	Gamestate.set_play_state(Gamestate.State.PLAYING)

func end():
	if Gamestate.play_state == Gamestate.State.GAME_OVER:
		return

	get_tree().paused = true
	Gamestate.set_play_state(Gamestate.State.GAME_OVER)

func restart():
	start()

func reset():
	Gamestate.reset()
	arena.clear_entities()
	spawner.reset()
	tower.reset()

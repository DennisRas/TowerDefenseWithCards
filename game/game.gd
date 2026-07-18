extends Node2D

const STARTER_ABILITIES = [
	preload("res://game/abilities/pistol/pistol.tscn"),
	preload("res://game/abilities/aura/aura.tscn"),
	preload("res://game/abilities/laser/laser.tscn"),
	preload("res://game/abilities/cannon/cannon.tscn"),
]

@onready var arena = $Arena
@onready var tower = $Arena/Tower
@onready var spawner = $Arena/Spawner
@onready var ui = $Ui

func _ready():
	add_to_group("game")
	Gamestate.event.connect(_on_gamestate_event)

func _on_gamestate_event(type, data):
	match type:
		Gamestate.Event.TOWER_DESTROYED:
			end()
		Gamestate.Event.ABILITY_SELECTED:
			tower.add_ability(data.scene)
			begin_play()
		Gamestate.Event.RESTART_REQUESTED:
			start()

func set_ui_active(active: bool):
	ui.process_mode = (
		Node.PROCESS_MODE_ALWAYS if active
		else Node.PROCESS_MODE_DISABLED
	)

func start():
	ui.PauseMenu.close()
	reset()

	if tower.abilities.get_child_count() == 0:
		get_tree().paused = true
		Gamestate.set_play_state(Gamestate.State.SELECTING)
		ui.CardSelection.show_choices(STARTER_ABILITIES)
	else:
		begin_play()

func begin_play():
	get_tree().paused = false
	Gamestate.set_play_state(Gamestate.State.PLAYING)

func end():
	if Gamestate.play_state == Gamestate.State.GAME_OVER:
		return

	get_tree().paused = true
	Gamestate.set_play_state(Gamestate.State.GAME_OVER)

func reset():
	Gamestate.reset()
	arena.clear_entities()
	spawner.reset()
	tower.reset()

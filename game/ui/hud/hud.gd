extends Control

const INFO_ROW = preload("res://game/ui/hud/info_row.tscn")
const ABILITY_INFO_PANEL = preload("res://game/ui/hud/ability_info_panel.tscn")

@onready var info_panel = $InfoPanel
@onready var rows_container = $InfoPanel/Rows
@onready var ability_panels = $AbilityPanels

var rows := {}

func _ready() -> void:
	add_row("tower_hp", "Tower HP")
	add_row("level", "Level")
	add_row("time", "Time")
	add_row("kills", "Kills")
	info_panel.reset_size()

	Gamestate.event.connect(_on_gamestate_event)
	refresh()
	refresh_abilities()

func _process(_delta: float) -> void:
	if Gamestate.play_state != Gamestate.State.PLAYING:
		return
	set_value("time", format_time(Gamestate.level_time_left()))

func add_row(id: String, label: String) -> void:
	var row = INFO_ROW.instantiate()
	rows_container.add_child(row)
	row.setup(label)
	rows[id] = row

func set_value(id: String, value: String) -> void:
	if rows.has(id):
		rows[id].set_value(value)

func format_time(seconds: float) -> String:
	var total = maxi(0, ceili(seconds))
	var m = total / 60
	var s = total % 60
	return "%d:%02d" % [m, s]

func refresh() -> void:
	set_value("level", str(Gamestate.state.level.number))
	set_value("time", format_time(Gamestate.level_time_left()))
	set_value("kills", str(Gamestate.state.kills))

func refresh_abilities() -> void:
	for child in ability_panels.get_children():
		child.free()

	var game = get_tree().get_first_node_in_group("game")
	if game == null:
		return

	for ability in game.tower.abilities.get_children():
		if ability is Ability:
			var panel = ABILITY_INFO_PANEL.instantiate()
			ability_panels.add_child(panel)
			panel.setup(ability)

func _on_gamestate_event(type, data) -> void:
	match type:
		Gamestate.Event.TOWER_HEALTH_CHANGED:
			set_value("tower_hp", "%d/%d" % [data.current, data.max])
		Gamestate.Event.ENEMY_KILLED:
			set_value("kills", str(Gamestate.state.kills))
		Gamestate.Event.LEVEL_CHANGED:
			set_value("level", str(Gamestate.state.level.number))
			set_value("time", format_time(Gamestate.level_time_left()))
		Gamestate.Event.ABILITIES_CHANGED:
			refresh_abilities()
		Gamestate.Event.STATE_CHANGED:
			refresh()
			refresh_abilities()

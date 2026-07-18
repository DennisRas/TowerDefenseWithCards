extends Control

const INFO_ROW = preload("res://game/ui/hud/info_row.tscn")

@onready var info_panel = $InfoPanel
@onready var rows_container = $InfoPanel/Rows

var rows := {}

func _ready() -> void:
	add_row("tower_hp", "Tower HP")
	add_row("xp", "Experience")
	add_row("kills", "Kills")
	add_row("wave", "Wave")
	info_panel.reset_size()

	Gamestate.event.connect(_on_gamestate_event)
	refresh()

func add_row(id: String, label: String) -> void:
	var row = INFO_ROW.instantiate()
	rows_container.add_child(row)
	row.setup(label)
	rows[id] = row

func set_value(id: String, value: String) -> void:
	if rows.has(id):
		rows[id].set_value(value)

func refresh() -> void:
	set_value("xp", str(Gamestate.state.xp))
	set_value("kills", str(Gamestate.state.kills))
	set_value("wave", str(Gamestate.state.wave))

func _on_gamestate_event(type, data) -> void:
	match type:
		Gamestate.Event.TOWER_HEALTH_CHANGED:
			set_value("tower_hp", "%d/%d" % [data.current, data.max])
		Gamestate.Event.ENEMY_KILLED:
			set_value("xp", str(Gamestate.state.xp))
			set_value("kills", str(Gamestate.state.kills))
		Gamestate.Event.STATE_CHANGED:
			refresh()

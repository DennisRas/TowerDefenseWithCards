extends PanelContainer

const INFO_ROW = preload("res://game/ui/hud/info_row.tscn")

@onready var title_label = $VBox/Title
@onready var rows_container = $VBox/Rows

var ability: Ability
var damage_dealt_row: Node = null
var refresh_timer: Timer

func _ready() -> void:
	refresh_timer = Timer.new()
	refresh_timer.wait_time = Ability.TICK_INTERVAL
	refresh_timer.timeout.connect(_refresh_live_stats)
	add_child(refresh_timer)
	refresh_timer.start()

func setup(tracked_ability: Ability) -> void:
	ability = tracked_ability
	title_label.text = ability.display_name

	for child in rows_container.get_children():
		child.free()

	match ability.type:
		Ability.Type.CHANNEL:
			_add_row("Damage", str(ability.damage))
			_add_row("Duration", "%.1fs" % ability.duration)
			_add_row("DPS", "%.1f" % ability.get_dps())
			_add_row("Cycle DPS", "%.1f" % ability.get_cycle_dps())
			_add_row("Cooldown", "%.2fs" % ability.cooldown)
		_:
			_add_row("Damage", str(ability.damage))
			_add_row("Cooldown", "%.2fs" % ability.cooldown)
			_add_row("DPS", "%.1f" % ability.get_dps())

	damage_dealt_row = _add_row("Dealt", _format_dealt())

func _refresh_live_stats() -> void:
	if damage_dealt_row and is_instance_valid(ability):
		damage_dealt_row.set_value(_format_dealt())

func _format_dealt() -> String:
	if ability == null:
		return "0"
	return "%.0f" % ability.damage_dealt

func _add_row(label: String, value: String) -> Node:
	var row = INFO_ROW.instantiate()
	rows_container.add_child(row)
	row.setup(label, value)
	return row

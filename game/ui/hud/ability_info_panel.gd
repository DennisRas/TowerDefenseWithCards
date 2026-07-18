extends PanelContainer

const INFO_ROW = preload("res://game/ui/hud/info_row.tscn")

@onready var title_label = $VBox/Title
@onready var rows_container = $VBox/Rows

func setup(ability: Ability) -> void:
	title_label.text = ability.display_name

	for child in rows_container.get_children():
		child.free()

	_add_row("Damage", str(ability.damage))
	_add_row("Cooldown", "%.2fs" % ability.cooldown)

func _add_row(label: String, value: String) -> void:
	var row = INFO_ROW.instantiate()
	rows_container.add_child(row)
	row.setup(label, value)

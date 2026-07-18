extends HBoxContainer

@onready var name_label = $Name
@onready var value_label = $Value

func setup(label: String, initial_value: String = "-") -> void:
	name_label.text = label
	value_label.text = initial_value

func set_value(text: String) -> void:
	value_label.text = text

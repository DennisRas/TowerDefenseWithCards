extends Node2D

func _ready() -> void:
	$Tower.position = get_viewport_rect().size / 2

func _process(delta: float) -> void:
	pass

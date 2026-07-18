extends Node2D

func _ready() -> void:
	$Tower.position = get_viewport_rect().size / 2

func clear_entities():
	_free_children($Enemies)
	_free_children($Projectiles)

func _free_children(node: Node):
	for child in node.get_children():
		child.free()

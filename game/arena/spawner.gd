extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_interval := 1

var timer := 0.0

func reset():
	timer = 0.0

func _process(delta: float) -> void:
	if Gamestate.play_state != Gamestate.State.PLAYING:
		return

	timer += delta

	if timer >= spawn_interval:
		timer = 0

		var enemy = enemy_scene.instantiate()
		var enemies = get_parent().get_node("Enemies")
		enemies.add_child(enemy)

		enemy.global_position = _random_edge_position(enemy.radius)
		enemy.target = get_parent().get_node("Tower")

func _random_edge_position(margin: float) -> Vector2:
	var size = get_viewport_rect().size
	match randi() % 4:
		0: # top — fully above the screen
			return Vector2(randf() * size.x, -margin)
		1: # right
			return Vector2(size.x + margin, randf() * size.y)
		2: # bottom
			return Vector2(randf() * size.x, size.y + margin)
		_: # left
			return Vector2(-margin, randf() * size.y)

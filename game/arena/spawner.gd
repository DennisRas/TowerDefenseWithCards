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
		spawn_enemy()

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	var enemies = get_parent().get_node("Enemies")
	enemies.add_child(enemy)

	var angle = randf() * TAU
	var distance = 600

	enemy.global_position = (
		get_viewport_rect().size / 2
		+ Vector2(cos(angle), sin(angle)) * distance
	)

	enemy.target = get_parent().get_node("Tower")

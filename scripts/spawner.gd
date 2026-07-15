extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_interval := 0.1

var timer := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# if Game.state != Game.State.PLAYING:
	# 	return
	
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
	print("Enemy spawned")

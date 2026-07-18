extends Node2D

@export var enemy_scenes: Array[PackedScene] = []

var spawn_timers: Dictionary = {} # Script -> float
var type_scripts: Array[Script] = []

@onready var enemies_root: Node2D = $"../Enemies"
@onready var tower: Node2D = $"../Tower"

func _ready() -> void:
	_cache_type_scripts()
	Gamestate.event.connect(_on_gamestate_event)

func _cache_type_scripts() -> void:
	type_scripts.clear()
	for scene in enemy_scenes:
		if scene == null:
			continue
		var probe = scene.instantiate()
		type_scripts.append(probe.get_script())
		probe.free()

func _on_gamestate_event(type, _data) -> void:
	match type:
		Gamestate.Event.LEVEL_CHANGED:
			_reset_spawn_timers()

func reset() -> void:
	spawn_timers.clear()

func _reset_spawn_timers() -> void:
	spawn_timers.clear()
	var level: int = Gamestate.state.level.number
	for i in enemy_scenes.size():
		var script = type_scripts[i] if i < type_scripts.size() else null
		if script == null:
			continue
		if level < script.call("get_min_level"):
			continue
		spawn_timers[script] = 0.0

func _process(delta: float) -> void:
	if Gamestate.play_state != Gamestate.State.PLAYING:
		return

	var level: int = Gamestate.state.level.number

	for i in enemy_scenes.size():
		var scene = enemy_scenes[i]
		var script = type_scripts[i] if i < type_scripts.size() else null
		if scene == null or script == null:
			continue
		if level < script.call("get_min_level"):
			continue

		if not spawn_timers.has(script):
			spawn_timers[script] = 0.0

		spawn_timers[script] += delta
		var interval: float = script.call("get_spawn_interval", level)
		if spawn_timers[script] >= interval:
			spawn_timers[script] = 0.0
			_spawn_enemy(scene)

func _spawn_enemy(scene: PackedScene) -> void:
	var enemy = scene.instantiate() as Enemy
	enemy.apply_level(Gamestate.state.level.number)

	enemies_root.add_child(enemy)
	enemy.global_position = _random_edge_position(enemy.radius)
	enemy.target = tower

func _random_edge_position(margin: float) -> Vector2:
	var size = get_viewport_rect().size
	match randi() % 4:
		0:
			return Vector2(randf() * size.x, -margin)
		1:
			return Vector2(size.x + margin, randf() * size.y)
		2:
			return Vector2(randf() * size.x, size.y + margin)
		_:
			return Vector2(-margin, randf() * size.y)
